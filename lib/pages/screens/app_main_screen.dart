import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/screens/home_screen.dart';
import 'package:food_delivery/pages/screens/profile_screen.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    Scaffold(),
    ProfileScreen(),
    Scaffold()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            _buildNavItems(Iconsax.home_15, "Home", 0),
            const SizedBox(width: 10),
            _buildNavItems(Iconsax.heart, "Favourite", 1),
            const SizedBox(width: 90),
            Stack(
              clipBehavior: .none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, "Cart", 3),
                Positioned(
                  right: -10,
                  top: -10,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: red,
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 60,
                  top: -25,
                  child: CircleAvatar(
                    backgroundColor: red,
                    radius: 35,
                    child: Icon(
                      CupertinoIcons.search,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            _buildNavItems(Iconsax.user, "Profile", 2),
          ],
        ),
      ),
    );
  }

  // helper method to build navigation items
  Widget _buildNavItems(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? red : Colors.grey,
          ),
          const SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor: currentIndex == index ? red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
