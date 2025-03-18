class RecipeModel {
  final int? id;
  final String image;
  final String? name;
  final String? ingredients;
  final String? steps;

  RecipeModel({
    this.id,
    required this.image,
    required this.name,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      ingredients: json['ingredients'],
      steps: json['steps'],
    );
  }
}
