import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Widgets/ImageCardsScroll.dart';
import 'package:plant_diary/Widgets/NewImageCard.dart';

import '../Utils/Navigation.dart';
import 'Settings.dart';

class MyGarden extends StatelessWidget {
  final Function() navigateBackCallback;

  const MyGarden({super.key, required this.navigateBackCallback});

  final String name = "Loujin AbuHejleh";

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // header
            Container(
              height: screenHeight * 0.17,
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
                    //buttons image and text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: marginX),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.155,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.main),
                                child: Center(
                                  child: Text(
                                    "LA",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.contrast),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: marginY * 0.35, left: marginX * 0.2),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(bottom: marginY),
                                        child: Text(
                                          "Welcome back,",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.thridry,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: marginY / 2),
                                        child: Text(
                                          "$name !",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.main,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: SizedBox(
                              height: screenHeight * 0.07,
                              width: screenWidth * 0.155,
                              child: SvgPicture.asset('assets/icons/menu.svg',
                                  colorFilter: ColorFilter.mode(
                                      AppColors.main, BlendMode.srcIn)),
                            ),
                            onPressed: () => navigateToNewScreen(
                              context,
                              const Settings(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: navigateBackCallback,
                    child: Icon(
                      Icons.keyboard_double_arrow_left,
                      color: AppColors.secoundry,
                      size: screenHeight * 0.045,
                    ),
                  ),
                  Text(
                    "My Garden",
                    style: TextStyle(
                      fontSize: screenHeight * 0.037,
                      fontWeight: FontWeight.w900,
                      color: AppColors.contrast,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 0.8, // Aspect ratio of each grid item
                  mainAxisSpacing: screenHeight * 0.01,
                ),
                // itemCount: list.length,
                itemCount: 27,
                itemBuilder: (context, index) {
                  // if (index == list.length - 1) {
                  if (index == 26) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: NewImageCard(
                        height: double.infinity,
                        width: double.infinity,
                        iconSize: screenHeight * 0.075,
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: const ImageCardsScroll(
                      plantImage: "assets/images/background.jpg",
                      plantName: "XY",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}