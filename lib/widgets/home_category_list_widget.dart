import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/home_cat_list_details_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/categories_model.dart';

class HomeCategoryListWidget extends StatefulWidget {
  const HomeCategoryListWidget({super.key});

  @override
  State<HomeCategoryListWidget> createState() => _HomeCategoryListWidgetState();
}

class _HomeCategoryListWidgetState extends State<HomeCategoryListWidget> {
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

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from("categories")
          .select();

      debugPrint("Fetched categories: $response");

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: futureCategories,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return const Center(
            child: Padding(
              padding: .all(20),
              child: CircularProgressIndicator(color: red),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: .horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              final category = snapshot.data![index];
              return GestureDetector(
                onTap: () => HomeCatListDetailsWidget(),
                child: Container(
                  padding: const .symmetric(horizontal: 18, vertical: 10),
                  margin: const .only(right: 12, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: selectedCategory == category.name ? red : grey1,
                    borderRadius: .circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const .all(5),
                        decoration: BoxDecoration(
                          color: selectedCategory == category.name
                              ? Colors.white
                              : Colors.transparent,
                          shape: .circle,
                        ),
                        child: Image.network(
                          category.image,
                          width: 28,
                          height: 28,
                          errorBuilder: (ctx, error, stackTrace) =>
                              const Icon(Icons.fastfood, size: 28),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: .w600,
                          color: selectedCategory == category.name
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
