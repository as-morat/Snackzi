import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/home_app_banner_widget.dart';
import 'package:food_delivery/widgets/home_app_bar_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBarWidgets(),
      body: Column(
        children: [
          Padding(
            padding: const .symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                const HomeAppBannerWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
