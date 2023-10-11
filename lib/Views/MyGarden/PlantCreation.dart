import 'package:flutter/material.dart';
import 'package:plant_diary/API/DataModels/PlantDetailsModel.dart';
import 'package:plant_diary/API/GetPlantDetails.dart';
import 'package:plant_diary/API/PlantDiaryApi.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Layouts/LayoutPage.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Widgets/PageHelpers/GetDifficulty.dart';
import 'package:plant_diary/Widgets/Titles/BoxTitle.dart';

class PlantCreation extends StatefulWidget {
  final int plantId;

  const PlantCreation({
    Key? key,
    required this.plantId,
  }) : super(key: key);

  @override
  _PlantCreationState createState() => _PlantCreationState();
}

class _PlantCreationState extends State<PlantCreation> {
  late PlantDetailsModel plantRequest;

  @override
  void initState() {
    super.initState();
  }

  Future<PlantDetailsModel> getPlantDetails() async {
    var plant = await getPlantDetailsApi(widget.plantId);
    plantRequest = plant;
    return plant;
  }

  Future<void> addPlantToDiary() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.contrast,
          content: SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.main,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Adding Plant...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    try {
      await PlantDiaryApi.addPlant(
        name: plantRequest.plantName,
        scientificName: plantRequest.plantScientificName,
        speciesId: widget.plantId,
        imageRef: plantRequest.imageSrc,
        keyFacts: plantRequest.keyFacts,
        difficulty: plantRequest.difficulty,
        plantCharacteristics: plantRequest.plantCharacteristics,
      );

      Navigator.of(context).pop();
      Navigator.popUntil(context, (route) => false);
      navigateToNewScreen(context, LayoutPage());
    } catch (error) {
      print("Error adding plant: $error");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return Scaffold(
      body: FutureBuilder<PlantDetailsModel>(
        future: getPlantDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.main,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          var plant = snapshot.data!;
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: screenHeight * 0.35,
                  width: screenWidth,
                  child: Image.network(
                    plant.imageSrc,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      try {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.contrast,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      } catch (e) {
                        return Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.main),
                          child: Center(
                            child: Text(
                              "No Image",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.contrast,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.3),
                  child: Container(
                    height: screenHeight * 0.955,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.contrast,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: marginY,
                        left: marginX * 1.25,
                        right: marginX * 1.25,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: marginY),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      plant.plantName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.main,
                                        fontSize: 24,
                                      ),
                                    ),
                                    IconButton.outlined(
                                      onPressed: () => setState(() {
                                        addPlantToDiary();
                                      }),
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.main,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: marginY * 0.1),
                                  child: Text(
                                    "Also known as ${plant.plantScientificName}, ${plant.plantOtherNames.join(", ")}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.gray,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: marginY * 0.5),
                                  child: Text(
                                    plant.description,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secoundry,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: marginY),
                                child: BoxTitle(
                                  icon: Icons.local_florist,
                                  title: "Key Facts",
                                  color: AppColors.main,
                                ),
                              ),
                              // Key Facts
                              ...List.generate(
                                plant.keyFacts.length,
                                (index) {
                                  Color color = index % 2 == 0
                                      ? AppColors.secoundry.withOpacity(0.35)
                                      : AppColors.gradientStart
                                          .withOpacity(0.35);
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(top: marginY * 0.25),
                                    child: Container(
                                      height: screenHeight * 0.05,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              plant.keyFacts[index].section,
                                              style: TextStyle(
                                                color: AppColors.main,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              plant.keyFacts[index].value,
                                              style: TextStyle(
                                                color: AppColors.main,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Difficulty
                              Padding(
                                padding: EdgeInsets.only(top: marginY),
                                child: BoxTitle(
                                  icon: Icons.local_florist,
                                  title: "Difficulty",
                                  color: AppColors.main,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: getDifficulty(plant.difficulty),
                              ),
                              // Difficulty
                              Padding(
                                padding: EdgeInsets.only(top: marginY),
                                child: BoxTitle(
                                  icon: Icons.local_florist,
                                  title: "Characteristics",
                                  color: AppColors.main,
                                ),
                              ),
                              ...List.generate(
                                plant.plantCharacteristics.length,
                                (index) {
                                  Color color = index % 2 == 0
                                      ? AppColors.secoundry.withOpacity(0.35)
                                      : AppColors.gradientStart
                                          .withOpacity(0.35);
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(top: marginY * 0.25),
                                    child: Container(
                                      height: screenHeight * 0.045,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              plant.plantCharacteristics[index]
                                                  .section,
                                              style: TextStyle(
                                                color: AppColors.main,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.5,
                                              child: Text(
                                                plant
                                                        .plantCharacteristics[
                                                            index]
                                                        .value
                                                        .join(", ")
                                                        .isEmpty
                                                    ? "Unknown"
                                                    : plant
                                                        .plantCharacteristics[
                                                            index]
                                                        .value
                                                        .join(", "),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: AppColors.main,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
