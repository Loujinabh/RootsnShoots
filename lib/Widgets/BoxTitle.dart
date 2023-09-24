import 'package:flutter/material.dart'
    show
        BuildContext,
        EdgeInsets,
        FontWeight,
        Icon,
        IconData,
        MediaQuery,
        Padding,
        Row,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:plant_diary/Config/Colors.dart';

class BoxTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const BoxTitle({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.iconcolor,
            size: screenHeight * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: screenHeight * 0.02,
                color: AppColors.contrast,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
