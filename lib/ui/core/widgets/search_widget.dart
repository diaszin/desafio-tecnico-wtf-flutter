import 'package:desafio_tecnico_wtf/ui/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.search, color: AppColors.mauveGray),
    );
  }
}
