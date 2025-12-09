import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      // SafeArea ensures content stays within device bounds
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // Menu button
              _buildIconButton(
                imagePath: "images/food_delivery/icon/dash.png",
                onTap: () {},
              ),

              // Location selector with background for better visibility
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const .symmetric(horizontal: 16),
                    padding: const .symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: grey1,
                      borderRadius: .circular(10),
                    ),
                    child: Row(
                      mainAxisSize: .min,
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Iconsax.location5, color: red, size: 18),
                        const SizedBox(width: 6),
                        // Flexible prevents text overflow on small screens
                        Flexible(
                          child: Text(
                            "Ashulia Model Town, Savar",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.3,
                              fontWeight: .w600,
                              color: Colors.black87,
                            ),
                            overflow: .ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Iconsax.arrow_down_1, size: 14, color: orange),
                      ],
                    ),
                  ),
                ),
              ),

              // Profile button
              _buildIconButton(
                imagePath: "images/food_delivery/profile.png",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable icon button widget
  Widget _buildIconButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        padding: const .all(10),
        decoration: BoxDecoration(
          color: grey1,
          borderRadius: .circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(imagePath, fit: .contain),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}