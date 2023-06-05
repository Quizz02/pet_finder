import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE0F6F4),
  100: Color(0xFFB3E8E4),
  200: Color(0xFF80D9D3),
  300: Color(0xFF4DCAC1),
  400: Color(0xFF26BEB3),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF00AC9E),
  700: Color(0xFF00A395),
  800: Color(0xFF009A8B),
  900: Color(0xFF008B7B),
});
const int _primaryPrimaryValue = 0xFF00B3A6;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFB7FFF5),
  200: Color(_primaryAccentValue),
  400: Color(0xFF51FFE7),
  700: Color(0xFF37FFE4),
});
const int _primaryAccentValue = 0xFF84FFEE;
