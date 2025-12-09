import 'package:flutter/cupertino.dart';

class CategoryModel {
  String image, name;

  CategoryModel({ required this.image, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Creating CategoryModel from: $json");
    return CategoryModel(
      image: json['image']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
    );
  }
}
