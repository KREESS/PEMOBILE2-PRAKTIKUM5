class CategoryModel {
  final String image;
  final String name;
  final String description;

  CategoryModel({
    required this.image,
    required this.name,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
