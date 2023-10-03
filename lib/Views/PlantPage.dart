import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Widgets/ImageCardsScroll.dart';
import 'package:plant_diary/Widgets/ProgressBar.dart';
import 'package:plant_diary/Widgets/TitleChip.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({
    super.key,
  });

  final String platName = "5obezeh";
  final String creationDate = "17 Jul. 2023";
  final double progressNum = 0.2;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB7E6B9), Color(0xFFF5D8A8)]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.38,
              width: screenWidth,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: screenHeight * 0.3,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: marginY * 1.7),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Icon(
                                            Icons.keyboard_double_arrow_left,
                                            color: AppColors.secoundry,
                                            size: screenHeight * 0.045,
                                          ),
                                        ),
                                        Text(
                                          "$platName's Diary",
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.037,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.secoundry,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageCardsScroll(
                          height: screenHeight * 0.22,
                          width: screenWidth * 0.38,
                          plantImage: "assets/images/background.jpg",
                          plantName: "xx",
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        SizedBox(
                          height: screenHeight * 0.23,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: marginY * 0.5,
                              ),
                              Text(
                                creationDate,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.main,
                                ),
                              ),
                              SizedBox(
                                height: marginY * 0.2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TitleChip(
                                    content: "5obezeh",
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.3,
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  TitleChip(
                                    content: "1 yo",
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.15,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: marginY * 0.25,
                              ),
                              TitleChip(
                                content: "Malva pusilla",
                                height: screenHeight * 0.04,
                                width: screenWidth * 0.47,
                                fontSize: 22,
                              ),
                              SizedBox(
                                height: marginY * 0.7,
                              ),
                              ProgressBar(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.47,
                                progress: progressNum,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: AppColors.contrast,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Text("ssss"),
                    Container(
                      height: marginY * 3,
                      width: marginX * 3,
                      decoration: BoxDecoration(
                          color: AppColors.thridry,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
