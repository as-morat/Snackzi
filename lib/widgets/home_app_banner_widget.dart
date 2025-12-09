import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HomeAppBannerWidget extends StatelessWidget {
  const HomeAppBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 160,
      decoration: BoxDecoration(
        color: imageBG1,
        borderRadius: .circular(20),
      ),
      padding: const .only(top: 25, right: 25, left: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .w600,
                    ),
                    children: [
                      TextSpan(
                        text: "The Fastest In Delivery",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: " Food",
                        style: TextStyle(color: red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: .circular(30),
                  ),
                  padding: const .symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                  child: Text(
                    "Order Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Image.asset("images/food_delivery/courier.png"),
        ],
      ),
    );
  }
}
