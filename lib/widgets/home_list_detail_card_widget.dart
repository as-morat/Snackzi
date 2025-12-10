import 'package:flutter/material.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeListDetailCardWidget extends StatefulWidget {
  const HomeListDetailCardWidget({super.key});

  @override
  State<HomeListDetailCardWidget> createState() =>
      _HomeListDetailCardWidgetState();
}

class _HomeListDetailCardWidgetState extends State<HomeListDetailCardWidget> {
  late Future<List<FoodModel>> futureCategories = fetchCategories();
  List<FoodModel> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    try {
      final fetchedCategories = await futureCategories;
      if (fetchedCategories.isNotEmpty) {
        setState(() {
          categories = fetchedCategories;
          selectedCategory = fetchedCategories.first.name;
        });
      }
    } catch (e) {
      debugPrint("Error initializing data: $e");
    }
  }

  Future<List<FoodModel>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from("categories")
          .select();

      debugPrint("Fetched categories: $response");

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
