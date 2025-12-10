import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/utils/colors.dart';
import '../providers/category_provider.dart';

class HomeCategoryListWidget extends ConsumerWidget {
  const HomeCategoryListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return categoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: red)),
      error: (_, _) => const SizedBox.shrink(),
      data: (categories) {
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: .horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (ctx, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  ref.read(selectedCategoryProvider.notifier).state =
                      category.name;
                },
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
