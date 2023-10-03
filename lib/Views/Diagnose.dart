import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_diary/Config/Colors.dart';

import '../Utils/Navigation.dart';
import '../Widgets/BoxTitle.dart';
import '../Widgets/ImageCardsScroll.dart';
import 'Settings.dart';

class Diagnose extends StatelessWidget {
  const Diagnose({
    super.key,
  });

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

            SizedBox(
              height: screenHeight * 0.40,
              width: screenWidth,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    height: screenHeight * 0.35,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40),
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.05,
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white60,
                          backgroundColor:
                              AppColors.secoundry.withOpacity(0.70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.medication),
                            ),
                            Text(
                              "Auto Diagnose",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.0215,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
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
                              child: const BoxTitle(
                                icon: Icons.local_florist,
                                title: "Explore by Plant",
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
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: ImageCardsScroll(
                              plantName: 'xx',
                              plantImage: "assets/images/background.jpg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
