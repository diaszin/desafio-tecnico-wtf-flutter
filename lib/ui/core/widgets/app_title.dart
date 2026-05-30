import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  final double fontSize;
  final double letterSpacing;

  const AppTitle({super.key, required this.fontSize, this.letterSpacing = 0});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Cine",
            style: GoogleFonts.fraunces(
              color: Color(0xFFEF233C),
              fontSize: fontSize,
              fontWeight: .w300,
              fontStyle: .italic,
              letterSpacing: letterSpacing,
            ),
          ),
          TextSpan(
            text: "Stream",
            style: GoogleFonts.fraunces(
              color: Color(0xFFF0F5FF),
              fontSize: fontSize,
              fontWeight: .w600,
              decoration: .none,
              letterSpacing: letterSpacing,
            ),
          ),
        ],
      ),
    );
  }
}
