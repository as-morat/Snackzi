import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_in_screen.dart';
import 'package:food_delivery/services/auth_service.dart';
import 'package:food_delivery/widgets/my_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  final AuthService _authService = AuthService();

  Future<void> SignUp() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final emailRegex = RegExp(r"^\w+@([\w-]+\.)+[\w-]{2,4}$");
    if(!emailRegex.hasMatch(email)){

    }
}

  final baseText = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: .w500,
    color: Colors.grey,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: .all(15),
        child: Column(
          children: [
            // Intro Images
            Image.asset("images/6343825.jpg", width: 500, fit: .cover),
            const SizedBox(height: 20),
            // Input Fields for email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Input Fields for Password
            TextField(
              controller: passwordController,
              obscureText: !isChecked,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  icon: Icon(
                    isChecked ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Sign Up Button
            SizedBox(
              width: .maxFinite,
              child: MyButton(onTap: () {}, buttonText: "Sign Up"),
            ),
            const SizedBox(height: 20),
            // Already have an account?
            Row(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Text("Already have an account?", style: baseText),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignInScreen()),
                    );
                  },
                  child: Text(
                    "Login here",
                    style: baseText.copyWith(
                      fontWeight: .bold,
                      color: Colors.blue,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
