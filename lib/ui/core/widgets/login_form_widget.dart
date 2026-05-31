import 'package:desafio_tecnico_wtf/ui/core/widgets/button_widget.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/login_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Logger logger = context.read<Logger>();
    Size platform = MediaQuery.of(context).size;
    double bigButtonWidth = platform.width * 0.9;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .only(topLeft: .circular(24), topRight: .circular(24)),
          border: .all(color: Color(0x66EDE8DD)),
          color: Color(0xFF1C1D21),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: 40,
          children: [
            LoginFormField(label: "Email", hintText: "seu@email.com"),
            Column(
              children: [
                LoginFormField(
                  label: "Senha",
                  hintText: "123456",
                  isPassword: true,
                ),
                Container(
                  alignment: .centerRight,
                  margin: .only(top: 8),
                  child: Text(
                    "Esqueceu a senha?",
                    style: GoogleFonts.roboto(
                      color: Color(0xFFEDE8DD),
                      fontWeight: .w500,
                      fontSize: 11,
                      letterSpacing: 0.28,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 36,
              children: [
                Button(
                  text: "Entrar",
                  onPressed: () {
                    logger.i("Redirecionando para a página HOME ...");
                    context.go("/home");
                  },
                  width: bigButtonWidth,
                ),
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Text(
                      "Não possui conta?",
                      style: GoogleFonts.roboto(
                        color: Color(0xFFF0F5FF),
                        fontWeight: .w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Cadastre-se",
                      style: GoogleFonts.roboto(
                        color: Color(0xFFEF233C),
                        fontWeight: .w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
