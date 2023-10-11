import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

Widget getDifficulty(String value) {
  Color color = AppColors.main;
  IconData icon = Icons.signal_cellular_alt_1_bar;

  if (value == "Moderate") {
    color = AppColors.thridry;
    icon = Icons.signal_cellular_alt_2_bar;
  }
  if (value == "High") {
    color = AppColors.gradientEnd;
    icon = Icons.signal_cellular_4_bar;
  }

  return Column(
    children: [
      Icon(
        icon,
        size: 24,
        color: color,
      ),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 24,
        ),
      )
    ],
  );
}
