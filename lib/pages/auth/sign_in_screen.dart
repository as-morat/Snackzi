import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_screen.dart';
import 'package:food_delivery/widgets/my_button_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_service.dart';
import '../../utils/custome_snackbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordChecked = false;
  bool isLoading = false;
  final AuthService _authService = AuthService();

  Future<void> signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final emailRegex = RegExp(r"^\w+@([\w-]+\.)+[\w-]{2,4}$");

    // INVALID EMAIL
    if (!emailRegex.hasMatch(email)) {
      showSnackBar(
        context: context,
        snackBarType: SnackBarType.failed,
        message: "Invalid email format",
      );
      return; // STOP HERE
    }

    // EMPTY CHECK
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(
        context: context,
        snackBarType: SnackBarType.failed,
        message: "Email or password cannot be empty",
      );
      return;
    }

    if (!mounted) return;
    setState(() => isLoading = true);

    final result = await _authService.login(email, password);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (result == null) {
      showSnackBar(
        context: context,
        snackBarType: SnackBarType.success,
        message: "Sign In Successful!",
      );
    }
    else {
      showSnackBar(
        context: context,
        snackBarType: SnackBarType.failed,
        message: result,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
            Image.asset("images/login.jpg", width: 500, fit: .cover),
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
              obscureText: !isPasswordChecked,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordChecked = !isPasswordChecked;
                    });
                  },
                  icon: Icon(
                    isPasswordChecked ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Sign Up Button
            SizedBox(
              width: .maxFinite,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : MyButton(onTap: signIn, buttonText: "Sign In"),
            ),
            const SizedBox(height: 20),
            // Already have an account?
            Row(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Text("Do not have an account?", style: baseText),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: Text(
                    "Signup here",
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
