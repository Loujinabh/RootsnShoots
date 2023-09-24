import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';

class ShowTips extends StatelessWidget {
  final List<String> tips;

  const ShowTips({
    required this.tips,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 12),
      child: Column(
        children: List.generate(
          tips.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
            child: Text(
              '+ ${tips[index]}',
              style: TextStyle(
                fontSize: screenHeight * 0.016,
                color: AppColors.contrast,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
