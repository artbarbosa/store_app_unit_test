import 'dart:convert';

class CategoryModel {
  late final String category;

  CategoryModel({required this.category});

  CategoryModel.fromJson(String json) {
    category = json;
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
    };
  }

  factory CategoryModel.fromMap(String map) {
    return CategoryModel(category: 'category');
  }

  String toJson() => json.encode(toMap());
}