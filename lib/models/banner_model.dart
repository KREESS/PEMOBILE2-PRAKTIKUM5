class BannerModel {
  final String image;
  final String title;
  final String description;

  BannerModel({
    required this.image,
    required this.title,
    required this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'],
      title: json['name'],
      description: json['description'],
    );
  }
}
