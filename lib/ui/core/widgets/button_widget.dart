import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { primary, secondary }

class Button extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final ButtonType type;
  final Color? iconColor;

  static void _defaultPressed() {}

  const Button({
    super.key,
    this.text,
    this.onPressed = _defaultPressed,
    this.icon,
    this.width,
    this.type = ButtonType.primary,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = switch (type) {
      ButtonType.primary => Theme.of(context).colorScheme.primary,
      ButtonType.secondary => Theme.of(context).colorScheme.secondary,
    };
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      fixedSize: Size(width ?? double.infinity, 57),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.cream.withAlpha(0x14), width: 0.74),
        borderRadius: .circular(16),
      ),
    );

    if (text == null && icon != null) {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 15, color: iconColor),
        style: buttonStyle,
      );
    }

    return ElevatedButton.icon(
      icon: Icon(icon, size: 15, color: iconColor),
      onPressed: onPressed,
      style: buttonStyle,
      label: Text(
        text!,
        style: GoogleFonts.roboto(
          fontWeight: .w600,
          fontSize: 14,
          color: AppColors.cream,
        ),
      ),
    );
  }
}
