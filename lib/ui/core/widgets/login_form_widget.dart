import 'package:desafio_tecnico_wtf/ui/core/widgets/login_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .only(topLeft: .circular(24), topRight: .circular(24)),
          border: .all(color: Color(0x66EDE8DD)),
          color: Color(0xFF1C1D21),
        ),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            LoginFormField(label: "Email", hintText: "seu@email.com"),
            LoginFormField(
              label: "Senha",
              hintText: "123456",
              isPassword: true,
            ),
          ],
        ),
      ),
    );
  }
}
