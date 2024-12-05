import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(189, 87, 18, 216), // Define the seed color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(189, 87, 18, 216),
          foregroundColor: Colors.white, // Use predefined white color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(189, 87, 18, 216),
            ).primaryContainer, // Use primaryContainer correctly
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 255, 175, 64), // Seed color for dark theme
          brightness: Brightness.dark, // Ensures colors align with dark mode
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 175, 64),
          foregroundColor: Colors.black, // Ensure contrast
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 255, 175, 64),
              brightness: Brightness.dark,
            ).primaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system, // Use system theme setting
      home: const Expenses(),
    ),
  );
}
