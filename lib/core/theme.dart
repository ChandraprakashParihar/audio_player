import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor =
      ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ).primaryColor;
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: primaryColor,
      suffixIconColor: primaryColor,
      hintStyle: TextStyle(
        color: Colors.grey.shade400,
        fontWeight: FontWeight.normal,
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStatePropertyAll(primaryColor)),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        visualDensity: const VisualDensity(vertical: 2),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
