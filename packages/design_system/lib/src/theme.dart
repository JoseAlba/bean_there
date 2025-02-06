import 'package:flutter/material.dart';

const _seedColor = Colors.brown;

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
  fontFamily: 'HennyPenny',
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  ),
  fontFamily: 'HennyPenny',
);
