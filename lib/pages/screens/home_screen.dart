import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/home_app_banner_widget.dart';
import 'package:food_delivery/widgets/home_app_bar_widgets.dart';
import 'package:food_delivery/widgets/home_category_list_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/categories_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CategoryModel>> futureCategories = fetchCategories();
  List<CategoryModel> categories = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    try {
      final categories = await futureCategories;
      if (categories.isNotEmpty) {
        setState(() {
          this.categories = categories;
          selectedCategory = categories.first.name;
        });
      }
    } catch (_) {}
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from("categories")
          .select();
      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (_) {
      debugPrint("Error fetching categories");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // App Bar with custom widget
      appBar: const HomeAppBarWidgets(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const .symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  // Custom App Banner
                  const HomeAppBannerWidget(),
                  const SizedBox(height: 25),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ), // Categories list
                  HomeCategoryListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
