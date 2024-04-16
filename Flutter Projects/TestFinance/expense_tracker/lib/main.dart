import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColourScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181)
);

var kDarkColourScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125)
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColourScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColourScheme.primaryContainer,
          foregroundColor: kDarkColourScheme.onPrimaryContainer
        ),
        cardTheme: const CardTheme().copyWith(
            color: kDarkColourScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColourScheme.primaryContainer,
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDarkColourScheme.onSecondaryContainer,
          ),
          titleLarge: const TextStyle(
            fontSize: 28,
          )
        )
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColourScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColourScheme.onPrimaryContainer,
          foregroundColor: kColourScheme.primaryContainer
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColourScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColourScheme.primaryContainer,
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColourScheme.onSecondaryContainer,
          ),
          titleLarge: const TextStyle(
            fontSize: 28,
          )
        )
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}