import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFFEF233C);
  static const Color background = Color(0xFF1C1D21);
  static const Color cream = Color(0xFFEDE8DD);
  static const Color iceBlue = Color(0xFFF0F5FF);
  static const Color beige = Color(0xFFF5F0EA);
  static const Color mauveGray = Color(0xFF6E6878);

  // Cores do Shimmer/Skeleton
  static const Color skeletonBase = Color(0xFF24262B);
  static const Color skeletonHighlight = Color(0xFF32353B);
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.background,
        surface: AppColors.background,
        onPrimary: AppColors.cream,
        onSurface: AppColors.cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: Colors.blueAccent,
        secondary: AppColors.background,
        surface: AppColors.background,
        onPrimary: AppColors.cream,
        onSurface: AppColors.cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
