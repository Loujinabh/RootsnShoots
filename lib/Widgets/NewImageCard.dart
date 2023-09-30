import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:plant_diary/Config/Colors.dart';

class NewImageCard extends StatelessWidget {
  const NewImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {},
      child: SizedBox(
        height: screenHeight * 0.1846,
        width: screenWidth * 0.3364,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.main.withOpacity(0.7),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GlassmorphicContainer(
                height: screenHeight * 0.1846,
                width: screenWidth * 0.3364,
                blur: 2,
                border: 2,
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.2),
                    const Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                ),
                borderRadius: 10,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.contrast.withOpacity(0.5),
                    AppColors.main.withOpacity(0.3),
                  ],
                ),
                child: Center(
                    child: Icon(
                  Icons.add,
                  color: AppColors.contrast,
                  size: screenHeight * 0.0512,
                  shadows: [
                    Shadow(
                        color: Colors.black87.withOpacity(0.3),
                        offset: const Offset(0, 3),
                        blurRadius: 6)
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
