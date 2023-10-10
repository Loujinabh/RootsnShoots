import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class ImageDisplay extends StatelessWidget {
  final double? height;
  final double? width;
  final String plantImage;

  const ImageDisplay({
    required this.plantImage,
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: height ?? screenHeight * 0.1846,
      width: width ?? screenWidth * 0.3364,
      decoration: BoxDecoration(
        color: AppColors.main,
        border: Border.all(
          color: AppColors.main,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: height ?? screenHeight * 0.1846,
          width: width ?? screenWidth * 0.3364,
          child: Image.network(
            plantImage,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              try {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.contrast,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              } catch (e) {
                return Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.main),
                  child: Center(
                    child: Text(
                      "No Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.contrast,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
