import 'package:flutter/material.dart';

class MovieAppMenu extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppMenu({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("Cine Stream"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
