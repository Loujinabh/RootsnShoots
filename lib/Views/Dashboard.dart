import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Views/Settings.dart';
import 'package:plant_diary/Widgets/ImageCardsScroll.dart';
import 'package:plant_diary/Widgets/NewImageCard.dart';
import 'package:plant_diary/Widgets/SearchBarWidget.dart';
import 'package:plant_diary/Widgets/BoxTitle.dart';
import 'package:plant_diary/Widgets/ShowTips.dart';

import '../Utils/Navigation.dart';

class Dashboard extends StatelessWidget {
  final Function(int) navigateCallback;
  Dashboard({super.key, required this.navigateCallback});

  final String name = "Loujin AbuHejleh";
  final List<String> tips = [
    "Avoid fertilizing trees and shrubs after July 4th. Late summer fertilizing may cause lush growth that’s more prone to winter kill",
    "Water new groundcovers and weed them to encourage spreading",
    "ssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
  ];
  final String location = "Amman, Jordan";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // print("Height: $screenHeight, Width:$screenWidth");

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return Scaffold(
      backgroundColor: AppColors.contrast,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // header
          Container(
            height: screenHeight * 0.25,
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
                                      padding: EdgeInsets.only(bottom: marginY),
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
                  SizedBox(
                    height: marginY,
                  ),
                  //search bar
                  const SearchBarWidget(),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: screenHeight * 0.1239,
                        width: screenWidth * 0.9253,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.secoundry,
                        ),
                        child: Column(
                          children: [
                            BoxTitle(icon: Icons.place, title: location),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: screenHeight * 0.23,
                              width: screenWidth * 0.9253,
                              padding: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.secoundry,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => navigateCallback(1),
                                        child: const BoxTitle(
                                          icon: Icons.local_florist,
                                          title: "My Garden",
                                          secondIcon: Icons.navigate_next,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: marginY * 2),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    4,
                                    (index) => const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: ImageCardsScroll(
                                        plantName: 'xx',
                                        plantImage:
                                            "assets/images/background.jpg",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: NewImageCard(
                                      height: screenHeight * 0.1846,
                                      width: screenWidth * 0.3364,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Container(
                          //height: screenHeight * 0.25,
                          width: screenWidth * 0.9253,
                          padding: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.secoundry,
                          ),
                          child: Column(
                            children: [
                              const BoxTitle(
                                  icon: Icons.emoji_nature,
                                  title: "Seasonal Tips"),
                              ShowTips(tips: tips)
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.9253,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.secoundry,
                        ),
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                BoxTitle(
                                  icon: Icons.spa,
                                  title: "Trending in Jordan",
                                  secondIcon: Icons.navigate_next,
                                ),
                              ],
                            ),
                            Row()
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.9253,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.secoundry,
                        ),
                        child: const Column(
                          children: [
                            Row(
                              children: [Text("LALLALALA")],
                            ),
                            Row()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
