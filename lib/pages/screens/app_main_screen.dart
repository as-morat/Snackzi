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
        // Reduced height for better mobile UX standards
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          // Added subtle shadow for depth
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        // SafeArea ensures content stays within device bounds
        child: SafeArea(
          child: Padding(
            // Horizontal padding for breathing room
            padding: const .symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                _buildNavItems(Iconsax.home_15, "Home", 0),
                _buildNavItems(Iconsax.heart, "Favourite", 1),
                // Center search button with proper spacing
                const SizedBox(width: 70),
                _buildNavItems(Iconsax.shopping_cart, "Cart", 3),
                _buildNavItems(Iconsax.user, "Profile", 2),
              ],
            ),
          ),
        ),
      ),
      // Floating search button positioned at center
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: .circle,
          color: red,
          // Enhanced shadow for floating effect
          boxShadow: [
            BoxShadow(
              color: red.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          CupertinoIcons.search,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: .centerDocked,
    );
  }

  // Helper method to build navigation items with improved interaction feedback
  Widget _buildNavItems(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      // Ink splash effect for better touch feedback
      child: Container(
        padding: const .symmetric(horizontal: 12, vertical: 8),
        child: Stack(
          clipBehavior: .none,
          children: [
            Column(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: isActive ? red : Colors.grey.shade600,
                ),
                const SizedBox(height: 4),
                // Active indicator dot
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: isActive ? red : Colors.transparent,
                  ),
                ),
              ],
            ),
            // Cart badge positioned only for cart icon
            if (index == 3)
              Positioned(
                right: -7,
                top: -10,
                child: Container(
                  padding: const .all(4),
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: red,
                    // White border for better visibility
                    border: .all(color: Colors.white, width: 2),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    "0",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                    textAlign: .center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}