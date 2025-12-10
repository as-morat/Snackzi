import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/categories_model.dart';
import '../models/product_model.dart';

/// Fetch all categories
final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final response = await Supabase.instance.client.from("categories").select();

  return (response as List)
      .map((json) => CategoryModel.fromJson(json))
      .toList();
});

/// Store selected category
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Fetch product based on selected category
final productsByCategoryProvider =
    FutureProvider.family<List<FoodModel>, String>((ref, category) async {
      final response = await Supabase.instance.client
          .from("food_product")
          .select()
          .eq("category", category);

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    });
