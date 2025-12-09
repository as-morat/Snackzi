import 'package:flutter/material.dart';
import 'package:food_delivery/models/on_boarding_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool isLoading = false;

  /// Complete onboarding and let AuthGate handle navigation
  Future<void> completeOnboarding() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    try {
      // Simulate a small delay for better UX
      await Future.delayed(const Duration(milliseconds: 800));

      // Mark onboarding as completed
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);

      if (!mounted) return;

      // Just pop - AuthGate will automatically show SignInScreen
      // No need to manually navigate to AuthGate
      Navigator.of(context).pop();

    } catch (e) {
      debugPrint('Error completing onboarding: $e');

      if (!mounted) return;

      // Show error snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Image background
          Container(
            height: size.height,
            width: size.width,
            color: imageBG1,
            child: Image.asset(
              "images/food_delivery/food_pattern.png",
              color: imageBG2,
              repeat: ImageRepeat.repeatY,
            ),
          ),

          // Decorative images
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

          // Custom welcoming page
          Align(
            alignment: .bottomCenter,
            child: ClipPath(
              clipBehavior: .antiAlias,
              clipper: CustomClip(),
              child: Container(
                color: Colors.white,
                padding: const .symmetric(vertical: 75, horizontal: 50),
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    // Welcoming page content
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
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: .bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: item["title1"],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: item["title2"],
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                item["description"]!,
                                textAlign: .center,
                                style: const TextStyle(
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

                    // Page indicators
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

                    // Navigation button
                    MaterialButton(
                      onPressed: isLoading ? null : completeOnboarding,
                      color: red,
                      height: 65,
                      minWidth: 250,
                      disabledColor: red.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(30),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : const Text(
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// Custom clipper for curved container
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