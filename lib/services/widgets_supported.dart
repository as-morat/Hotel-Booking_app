import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget {
  static TextStyle whiteTextStyle(double size) {
    return GoogleFonts.ubuntu(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  static TextStyle normalTextStyle(double size) {
    return GoogleFonts.ubuntu(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}
