import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Widgets/Interactive/SearchBarWidget.dart';

class NewImageCard extends StatelessWidget {
  final double height;
  final double width;
  final double? iconSize;
  final Function() onTap;

  const NewImageCard({
    super.key,
    required this.height,
    required this.width,
    this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Ink(
                height: height,
                width: width,
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
                height: height,
                width: width,
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
                    size: iconSize ?? height * 0.25,
                    shadows: [
                      Shadow(
                          color: Colors.black87.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 6)
                    ],
                  ),
                ),
              ),
            ),
            SearchBarWidget(
              height: height,
              width: width,
              borderRadius: 10,
              hide: true,
            ),
          ],
        ),
      ),
    );
  }
}
