import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class TitleChip extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final String content;
  final Function()? onTap;

  const TitleChip({
    required this.content,
    super.key,
    required this.height,
    required this.width,
    required this.fontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.main.withOpacity(0.35)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.02),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.85,
                  child: Text(
                    content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: AppColors.contrast,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
