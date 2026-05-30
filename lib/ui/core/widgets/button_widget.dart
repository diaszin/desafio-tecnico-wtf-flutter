import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  static void _defaultPressed() {}

  const Button({
    super.key,
    required this.text,
    this.onPressed = _defaultPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size platform = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFEF233C),
        fixedSize: Size(platform.width * 0.9, 57),
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: .w600,
          fontSize: 14,
          color: Color(0xFFEDE8DD),
        ),
      ),
    );
  }
}
