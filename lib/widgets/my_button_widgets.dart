import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color? color;
  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const .symmetric(vertical: 12, horizontal: 24),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: .w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
