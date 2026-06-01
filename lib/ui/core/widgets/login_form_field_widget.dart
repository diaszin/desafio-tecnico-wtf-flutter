import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormField extends StatefulWidget {
  const LoginFormField({
    super.key,
    required this.label,
    this.hintText,
    this.isPassword = false,
  });

  final String label;
  final String? hintText;
  final bool isPassword;

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _passwordIsVisible = false;

  void _changeVisiblePassword() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: GoogleFonts.roboto(
            color: AppColors.cream,
            fontWeight: .w500,
            fontSize: 10,
            letterSpacing: 2,
          ),
        ),
        TextField(
          style: GoogleFonts.roboto(color: AppColors.cream, fontSize: 15),
          obscureText: _passwordIsVisible || !widget.isPassword ? false : true,
          enableSuggestions: !widget.isPassword,
          autocorrect: !widget.isPassword,
          keyboardType: !widget.isPassword
              ? TextInputType.text
              : TextInputType.visiblePassword,
          decoration: InputDecoration(
            suffixIcon: !widget.isPassword
                ? null
                : IconButton(
                    icon: !_passwordIsVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onPressed: _changeVisiblePassword,
                  ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.roboto(color: AppColors.cream.withAlpha(0x66)),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.cream.withAlpha(0x1f)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.cream),
            ),
          ),
        ),
      ],
    );
  }
}
