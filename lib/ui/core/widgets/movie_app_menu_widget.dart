import 'package:desafio_tecnico_wtf/ui/core/widgets/app_title.dart';
import 'package:desafio_tecnico_wtf/ui/core/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieAppMenu extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppMenu({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF1C1D21),
      title: GestureDetector(
        onTap: () {
          context.go("/home");
        },
        child: AppTitle(fontSize: 20, letterSpacing: -0.9),
      ),
      titleSpacing: 22,
      actions: [SearchButton()],
      actionsPadding: .only(right: 22),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
