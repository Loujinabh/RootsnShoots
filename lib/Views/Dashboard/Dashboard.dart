import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/MockAPI/MockPlants.dart';
import 'package:plant_diary/MockAPI/MockTips.dart';
import 'package:plant_diary/Utils/DateFormatter.dart';
import 'package:plant_diary/Utils/GetWeather.dart';
import 'package:plant_diary/Utils/PlantModel.dart';
import 'package:plant_diary/Views/MyGarden/PlantPage.dart';
import 'package:plant_diary/Views/Settings/Settings.dart';
import 'package:plant_diary/Widgets/ImageCards/ImageCardsScroll.dart';
import 'package:plant_diary/Widgets/ImageCards/NewImageCard.dart';
import 'package:plant_diary/Widgets/Interactive/SearchBarWidget.dart';
import 'package:plant_diary/Widgets/Titles/BoxTitle.dart';
import 'package:plant_diary/Widgets/PageHelpers/ShowTips.dart';

import '../../Utils/Navigation.dart';

class Dashboard extends StatelessWidget {
  final Function(int) navigateCallback;
  Dashboard({super.key, required this.navigateCallback});

  // API vars
  final String name = "Loujin AbuHejleh";
  final String location = "Amman, Jordan";

  final List<String> tips = MockTips.tips;
  final List<PlantModel> myGarden = MockPlants.myGarden;
  final List<PlantModel> trendingInJordan = MockPlants.trendingInJordan;

  //

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                        width: screenWidth * 0.9253,
                        padding: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.secoundry,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: marginY * 0.5),
                          child: Column(
                            children: [
                              BoxTitle(icon: Icons.place, title: location),
                              FutureBuilder<Widget>(
                                future: getWeather(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.contrast,
                                    ));
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return snapshot.data!;
                                  }
                                },
                              ),
                            ],
                          ),
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
                                    myGarden.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.01),
                                      child: ImageCardsScroll(
                                        plantName: myGarden[index].name,
                                        plantImage: myGarden[index].imageSrc,
                                        onTap: () => navigateToNewScreen(
                                          context,
                                          PlantPage(
                                            plant: myGarden[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: NewImageCard(
                                      height: screenHeight * 0.1846,
                                      width: screenWidth * 0.3364,
                                      onTap: () => {},
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const BoxTitle(
                                      icon: Icons.emoji_nature,
                                      title: "Seasonal Tips"),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 12, right: 20),
                                    child: Text(
                                      getMonthName(DateTime.now()),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.02,
                                        color: AppColors.contrast,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.03,
                                    right: screenWidth * 0.03,
                                    bottom: screenHeight * 0.01),
                                child: Divider(
                                  color: AppColors.contrast,
                                  thickness: 1.0,
                                ),
                              ),
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
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                BoxTitle(
                                  icon: Icons.spa,
                                  title: "Trending in Jordan",
                                  secondIcon: Icons.navigate_next,
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(trendingInJordan.length,
                                    (index) {
                                  EdgeInsetsGeometry padding;
                                  if (index == 0) {
                                    padding = EdgeInsets.only(
                                      left: screenWidth * 0.075,
                                      right: screenWidth * 0.01,
                                    );
                                  } else if (index ==
                                      trendingInJordan.length - 1) {
                                    padding = EdgeInsets.only(
                                      left: screenWidth * 0.01,
                                      right: screenWidth * 0.075,
                                    );
                                  } else {
                                    padding = EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.01,
                                    );
                                  }
                                  return Padding(
                                    padding: padding,
                                    child: ImageCardsScroll(
                                      height: screenHeight * 0.15,
                                      width: screenWidth * 0.275,
                                      plantName: trendingInJordan[index].name,
                                      plantImage:
                                          trendingInJordan[index].imageSrc,
                                      onTap: () => {},
                                    ),
                                  );
                                }),
                              ),
                            )
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
