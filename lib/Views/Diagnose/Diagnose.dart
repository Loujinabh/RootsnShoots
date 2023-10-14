import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_diary/API/DataModels/SearchPlantModel.dart';
import 'package:plant_diary/API/PlantIdApi.dart';
import 'package:plant_diary/API/PlantSearchApi.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Views/MyGarden/PlantCreation.dart';
import 'package:plant_diary/Views/Settings/Settings.dart';
import 'package:plant_diary/Widgets/ImageCards/ImageCardsScroll.dart';
import 'package:plant_diary/Widgets/PageHelpers/ProgressBar.dart';
import 'dart:convert';

import 'package:plant_diary/Widgets/Titles/BoxTitle.dart';

class Diagnose extends StatefulWidget {
  const Diagnose({
    super.key,
  });

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  final String name = "Loujin AbuHejleh";

  String base64Image = "";
  bool showPlus = false;
  bool identityFlag = false;
  bool isLoading = false;
  int plantId = 0;
  late Future<PlantIdentity> plantIdentity;
  late Future<PlantHealth> plantHealth;

  @override
  void initState() {
    super.initState();
    plantIdentity = Future(() => PlantIdentity(name: "", images: []));
    plantHealth = Future(() => PlantHealth(diseases: [], health: -1.0));
  }

  Future<void> identify() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      isLoading = true;
    });

    if (image == null) {
      return;
    }

    final bytes = await image.readAsBytes();
    final String imageBase64 = "data:image/jpg;base64,${base64Encode(bytes)}";

    identityFlag = true;
    plantIdentity = PlantIdApi.identifyPlant(imageBase64);
    var plant = await plantIdentity;
    List<SearchPlantModel> listPlants = await searchPlant(plant.name);
    if (listPlants.isNotEmpty) {
      plantId = listPlants.first.id;
      showPlus = plantId < 3000;
    }

    setState(() {
      base64Image = base64Encode(bytes);
      isLoading = false;
    });
  }

  Future<void> diagnose() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      isLoading = true;
    });

    if (image == null) {
      return;
    }

    final bytes = await image.readAsBytes();
    final String imageBase64 = "data:image/jpg;base64,${base64Encode(bytes)}";

    identityFlag = false;
    plantHealth = PlantIdApi.diagnosePlant(imageBase64);
    setState(() {
      base64Image = base64Encode(bytes);
      isLoading = false;
    });
  }

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
            Container(
              margin: const EdgeInsets.all(16),
              height: screenHeight * 0.35,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.contrast,
                borderRadius: BorderRadius.circular(15),
              ),
              child: base64Image.isEmpty
                  ? Center(
                      child: !isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => identify(),
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
                                        child: Icon(Icons.image_search),
                                      ),
                                      Text(
                                        "Identify",
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
                                ElevatedButton(
                                  onPressed: () => diagnose(),
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
                                        "Diagnose",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenHeight * 0.019,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.main,
                              ),
                            ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.memory(
                              base64Decode(base64Image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: screenWidth * 0.32,
                              child: ElevatedButton(
                                onPressed: () => setState(() {
                                  base64Image = "";
                                }),
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
                                      "Retake",
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
            ),
            identityFlag ? identityWidget() : healthWidget(),
          ],
        ),
      ),
    );
  }

  Widget identityWidget() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    return FutureBuilder<PlantIdentity>(
      future: plantIdentity,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.contrast,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.name.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'No results yet',
                style: TextStyle(
                    color: AppColors.main,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          );
        }
        var plant = snapshot.data;

        return Column(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenWidth * 0.9253,
              decoration: BoxDecoration(
                color: AppColors.main.withOpacity(0.35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: marginX),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plant!.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.main,
                        fontSize: 16,
                      ),
                    ),
                    if (showPlus)
                      IconButton(
                        onPressed: () {
                          navigateToNewScreen(
                            context,
                            PlantCreation(
                              plantId: plantId,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: AppColors.main,
                        ),
                      )
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
                  color: AppColors.main.withOpacity(0.35),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        BoxTitle(
                          icon: Icons.spa,
                          title: "Similar Images",
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(plant.images.length, (index) {
                          EdgeInsetsGeometry padding;
                          if (index == 0) {
                            padding = EdgeInsets.only(
                              left: screenWidth * 0.075,
                              right: screenWidth * 0.01,
                            );
                          } else if (index == plant.images.length - 1) {
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
                              plantImage: plant.images[index],
                              onlineImage: true,
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
        );
      },
    );
  }

  Widget healthWidget() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return FutureBuilder<PlantHealth>(
      future: plantHealth,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.contrast,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.health == -1.0) {
          return Expanded(
            child: Center(
              child: Text(
                'No results yet',
                style: TextStyle(
                    color: AppColors.main,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          );
        } else if (snapshot.data!.diseases.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                'Unknown condition',
                style: TextStyle(
                    color: AppColors.main,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          );
        }
        var plant = snapshot.data;
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "health bar",
                  style: TextStyle(
                      color: AppColors.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                ProgressBar(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.85,
                  progress: plant!.health,
                  color: AppColors.main.withOpacity(0.35),
                  borderRadius: 15,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21),
              child: Container(
                height: screenHeight * 0.25,
                width: screenWidth * 0.9253,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.main.withOpacity(0.35),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: marginX * 0.5, vertical: marginY * 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageCardsScroll(
                        height: screenHeight * 0.30,
                        width: screenWidth * 0.3,
                        plantImage: plant.diseases[0].images[0],
                        onlineImage: true,
                        onTap: () => {},
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                plant.diseases.length,
                                (index) {
                                  String originalString =
                                      "${plant.diseases[index].name}:";
                                  String capitalizedString =
                                      originalString[0].toUpperCase() +
                                          originalString.substring(1);

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalizedString,
                                        style: TextStyle(
                                            color: AppColors.main,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: marginY * 0.5,
                                      ),
                                      Text(plant
                                          .diseases[index]
                                          .treatment[plant.diseases[index]
                                              .treatment.keys.first]!
                                          .first),
                                      SizedBox(
                                        height: marginY,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
