import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SnackBarType { success, failed }

void showSnackBar({
  required BuildContext context,
  required SnackBarType snackBarType,
  required String message,
}) {
  if (!context.mounted) return;

  final screenWidth = MediaQuery.of(context).size.width;
  final titleFontSize = screenWidth * 0.05;
  final descriptionFontSize = screenWidth * 0.042;

  switch (snackBarType) {
    // success snackBar
    case SnackBarType.success:
      CherryToast.success(
        title: Text(
          "Successful",
          style: GoogleFonts.balsamiqSans(
            fontWeight: .bold,
            color: Colors.green,
            fontSize: titleFontSize,
          ),
        ),
        description: Text(
          message,
          style: GoogleFonts.balsamiqSans(fontSize: descriptionFontSize),
        ),
        toastDuration: const Duration(seconds: 3),
        displayCloseButton: false,
        toastPosition: .top,
        animationType: .fromTop,
      ).show(context);
      break;

    //   failed snackBar
    case SnackBarType.failed:
      CherryToast.error(
        title: Text(
          "Error",
          style: GoogleFonts.balsamiqSans(
            fontWeight: .bold,
            color: Colors.red,
            fontSize: titleFontSize,
          ),
        ),
        description: Text(
          message,
          style: GoogleFonts.balsamiqSans(fontSize: descriptionFontSize),
        ),
        toastDuration: const Duration(seconds: 3),
        displayCloseButton: false,
        toastPosition: .top,
        animationType: .fromTop,
      ).show(context);
      break;
  }
}
