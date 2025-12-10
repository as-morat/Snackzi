import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/home_app_banner_widget.dart';
import 'package:food_delivery/widgets/home_app_bar_widgets.dart';
import 'package:food_delivery/widgets/home_category_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: .bold),
                  ),
                  const SizedBox(height: 15),
                  // Categories list
                  const HomeCategoryListWidget(),
                  const SizedBox(height: 25),
                  // popular now title
                  const Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Popular Now",
                        style: TextStyle(fontSize: 20, fontWeight: .bold),
                      ),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: .bold,
                              color: orange,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
