import 'package:flutter/material.dart';

String colorToString(Color color) {
  return color.value.toRadixString(16); // Convert to Hex String
}

Color stringToColor(String colorString) {
  return Color(int.parse(colorString, radix: 16));
}