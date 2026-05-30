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
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.45,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Cine",
                        style: GoogleFonts.fraunces(
                          color: Color(0xFFEF233C),
                          fontSize: 40,
                          fontWeight: .w300,
                          fontStyle: .italic,
                        ),
                      ),
                      TextSpan(
                        text: "Stream",
                        style: GoogleFonts.fraunces(
                          color: Color(0xFFF0F5FF),
                          fontSize: 40,
                          fontWeight: .w600,
                          decoration: .none,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "O CINEMA QUE VOCÊ AMA",
                  style: GoogleFonts.dmMono(
                    color: Color(0xFFEDE8DD),
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
