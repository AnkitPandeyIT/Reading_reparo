import 'package:flutter/material.dart';

MaterialStateProperty<OutlinedBorder> myRoundedBorder(double radius) {
  return MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)));
}
