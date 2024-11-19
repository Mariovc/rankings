import 'package:flutter/material.dart';
import 'package:ranking/presentation/styles/app_colors.dart';

final darkThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    secondary: AppColors.secondary,
  ),
  appBarTheme: AppBarTheme(
    color: AppColors.primary,
  ),
  textTheme: ThemeData.dark().textTheme.merge(
        createCustomTextTheme(Colors.white),
      ),
);

TextTheme createCustomTextTheme(Color defaultColor) {
  return TextTheme(
    displayLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    displayMedium: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    displaySmall: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headlineLarge: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headlineMedium:
        const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headlineSmall: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleLarge: const TextStyle(fontSize: 16.0),
    titleMedium: const TextStyle(fontSize: 14.0),
    titleSmall: const TextStyle(fontSize: 12.0),
    bodyLarge: const TextStyle(fontSize: 16.0),
    bodyMedium: const TextStyle(fontSize: 14.0),
    bodySmall: const TextStyle(fontSize: 12.0),
    labelLarge: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
    labelMedium:
        TextStyle(fontSize: 12.0, color: defaultColor.withOpacity(0.6)),
    labelSmall: TextStyle(fontSize: 10.0, color: defaultColor.withOpacity(0.5)),
  );
}
