import 'package:desafio_tecnico_wtf/ui/core/widgets/login_hero_section_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Size platformSize = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginHeroSection(
        height: platformSize.height,
        width: platformSize.width,
      ),
    );
  }
}
