import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class TitleChip extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final String content;

  const TitleChip({
    required this.content,
    super.key,
    required this.height,
    required this.width,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: AppColors.secoundry),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Row(
            children: [
              Text(
                content,
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.contrast,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
