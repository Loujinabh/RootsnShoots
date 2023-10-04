import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class ImageCardsScroll extends StatelessWidget {
  final double? height;
  final double? width;
  final String plantImage;
  final String plantName;
  final Function() onTap;

  const ImageCardsScroll({
    required this.plantImage,
    required this.plantName,
    super.key,
    this.height,
    this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            height: height ?? screenHeight * 0.1846,
            width: width ?? screenWidth * 0.3364,
            decoration: BoxDecoration(
              color: AppColors.main,
              border: Border.all(
                color: AppColors.main,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(plantImage),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10, // Adjust the left position as needed
                  bottom: 10, // Adjust the bottom position as needed
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.gray.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      plantName,
                      style: TextStyle(
                        color: AppColors.contrast,
                        fontSize: screenHeight * 0.02,
                      ),
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
