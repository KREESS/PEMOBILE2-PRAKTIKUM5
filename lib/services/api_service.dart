import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:praktikum_5/models/banner_model.dart';
import 'package:praktikum_5/models/category_model.dart';
import 'package:praktikum_5/models/recipe_model.dart';

class ApiService {
  static const String baseUrl = 'https://polindra.cicd.my.id';
  static const String apiUrl = '$baseUrl/items/';
  static const String assetUrl = '$baseUrl/assets/';

  /// Membuat URI berdasarkan collection API
  static Uri getUri(String collection) {
    return Uri.parse('$apiUrl$collection');
  }

  /// Mengambil URL dari asset ID
  static String getAsset(String? imageId) {
    return imageId != null ? '$assetUrl$imageId' : '';
  }

  /// **Mengunggah gambar ke API**
  /// - Mengembalikan `String?` berupa ID gambar jika berhasil.
  /// - Mengembalikan `null` jika gagal.
  static Future<String?> uploadImage(File imageFile) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse("$baseUrl/files"));
      request.files
          .add(await http.MultipartFile.fromPath("file", imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = json.decode(responseData);
        return jsonData["data"]["id"]; // ID file yang dikembalikan dari server
      } else {
        print("Gagal mengunggah gambar. Status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error upload image: $e");
      return null;
    }
  }

  /// **Mengirim review ke API**
  /// - Parameter:
  ///   - `recipeId`: ID resep.
  ///   - `name`: Nama pengguna yang memberi review.
  ///   - `description`: Isi review.
  ///   - `rating`: Nilai rating (good/no_good).
  ///   - `imageId`: ID gambar yang diunggah (opsional).
  /// - Return: `true` jika sukses, `false` jika gagal.
  static Future<bool> postReview(int recipeId, String name, String description,
      String rating, String? imageId) async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/fr_reviews"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "recipes_id": recipeId,
          "name": name,
          "description": description,
          "ratting": rating,
          "image": imageId
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal mengirim review. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error post review: $e");
      return false;
    }
  }

  /// **Mengambil daftar banner**
  static Future<List<BannerModel>> getBanners() async {
    try {
      final response = await http.get(getUri('fr_banners'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] != null) {
          final List<dynamic> data = body['data'];
          return data.map((item) => BannerModel.fromJson(item)).toList();
        }
      }
      throw Exception('No data found');
    } catch (e) {
      print("Error get banners: $e");
      throw Exception('Failed to load banners');
    }
  }

  /// **Mengambil daftar kategori**
  static Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(getUri('fr_categories'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] != null) {
          final List<dynamic> data = body['data'];
          return data.map((item) => CategoryModel.fromJson(item)).toList();
        }
      }
      throw Exception('No data found');
    } catch (e) {
      print("Error get categories: $e");
      throw Exception('Failed to load categories');
    }
  }

  /// **Mengambil daftar resep**
  static Future<List<RecipeModel>> getRecipes() async {
    try {
      final response = await http.get(getUri('fr_recipes'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['data'] != null) {
          final List<dynamic> data = body['data'];
          return data.map((item) => RecipeModel.fromJson(item)).toList();
        }
      }
      throw Exception('No data found');
    } catch (e) {
      print("Error get recipes: $e");
      throw Exception('Failed to fetch recipes');
    }
  }
}
