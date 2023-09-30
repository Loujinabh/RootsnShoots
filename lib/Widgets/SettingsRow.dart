import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class SettingsRow extends StatelessWidget {
  final String title;
  final Function()? buttonFunction;
  final Widget? customButton;

  const SettingsRow({
    required this.title,
    this.buttonFunction,
    this.customButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.main,
            fontSize: screenWidth * 0.0475,
            fontWeight: FontWeight.bold,
          ),
        ),
        customButton ??
            IconButton.filled(
              onPressed: buttonFunction,
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: screenWidth * 0.08,
                color: AppColors.main,
              ),
            )
      ],
    );
  }
}
