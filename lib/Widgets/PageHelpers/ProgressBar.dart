import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class ProgressBar extends StatelessWidget {
  final double height;
  final double width;
  final double progress;

  const ProgressBar({
    super.key,
    required this.height,
    required this.width,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secoundry,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.05, horizontal: width * 0.015),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
