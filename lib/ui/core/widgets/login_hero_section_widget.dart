import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/app_title.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/hero_banner.png"),
          fit: .cover,
          filterQuality: .low,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.38,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                AppTitle(fontSize: 40, letterSpacing: -0.9),
                Text(
                  "O CINEMA QUE VOCÊ AMA",
                  style: GoogleFonts.dmMono(
                    color: AppColors.cream,
                    fontSize: 11,
                    fontWeight: .w400,
                  ),
                ),
              ],
            ),
          ),
          LoginFormWidget(),
        ],
      ),
    );
  }
}
