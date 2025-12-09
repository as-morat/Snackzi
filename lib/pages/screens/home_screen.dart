import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:iconsax/iconsax.dart';

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
            _buildNavItems(Icons.person_2_outlined, "Profile", 2),
            const SizedBox(width: 10),
            Stack(
              clipBehavior: .none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, "Cart", 3),
                Positioned(
                  right: -7,
                  top: 16,
                  child: CircleAvatar(
                    backgroundColor: red,
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 155,
                    top: -25,
                    child: CircleAvatar(
                  backgroundColor: red,
                  radius: 35,
                  child: Icon(CupertinoIcons.search, size: 35, color: Colors.white,,),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // helper method to build navigation items
  Widget _buildNavItems(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {});
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
