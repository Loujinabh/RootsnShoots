import 'package:flutter/material.dart';
import 'package:plant_diary/API/Tips.dart';
import 'package:plant_diary/Config/Colors.dart';

class ShowTips extends StatelessWidget {
  const ShowTips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 12),
      child: FutureBuilder<List<dynamic>>(
          future: Tips.getTips(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (!snapshot.hasData) {
              return const Text("No documents found");
            }
            var tips = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            );
          }),
    );
  }
}
