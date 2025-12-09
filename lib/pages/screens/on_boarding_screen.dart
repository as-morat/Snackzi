import 'package:flutter/material.dart';
import 'package:food_delivery/models/on_boarding_model.dart';
import 'package:food_delivery/pages/auth/sign_up_screen.dart';
import 'package:food_delivery/utils/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // for image bg
          Container(
            height: size.height,
            width: size.width,
            color: imageBG1,
            child: Image.asset(
              "images/food_delivery/food_pattern.png",
              color: imageBG2,
              repeat: .repeatY,
            ),
          ),
          Positioned(
            top: -80,
            right: 0,
            left: 0,
            child: Image.asset("images/food_delivery/chef.png"),
          ),
          Positioned(
            top: 139,
            right: 50,
            child: Image.asset("images/food_delivery/leaf.png", width: 80),
          ),
          Positioned(
            top: 390,
            right: 40,
            child: Image.asset("images/food_delivery/chili.png", width: 80),
          ),
          Positioned(
            top: 230,
            left: -20,
            child: Image.asset(
              "images/food_delivery/ginger.png",
              height: 90,
              width: 90,
            ),
          ),

          // custom welcoming page
          Align(
            alignment: .bottomCenter,
            child: ClipPath(
              clipBehavior: .antiAlias,
              clipper: CustomClip(),
              child: Container(
                color: Colors.white,
                padding: .symmetric(vertical: 75, horizontal: 50),
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    // welcoming page title
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: data.length,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemBuilder: (_, index) {
                          final item = data[index];
                          return Column(
                            children: [
                              RichText(
                                textAlign: .center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: .bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: item["title1"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: item["title2"],
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                item["description"]!,
                                textAlign: .center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w300,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: .min,
                      children: List.generate(
                        data.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const .only(right: 10),
                          width: currentPage == index ? 25 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.orange
                                : Colors.grey.shade300,
                            borderRadius: .circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // navigation button
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                        );
                      },
                      color: red,
                      height: 65,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(30),
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: .w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// for curve container
class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.1);

    path.quadraticBezierTo(
      size.width * 0.5,
      -40,
      size.width,
      size.height * 0.1,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
