import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Widgets/Titles/BoxTitle.dart';

class PlantFact {
  PlantFact({required this.section, required this.value});
  String section;
  String value;
}

class PlantCharacteristic {
  PlantCharacteristic({required this.section, required this.value});
  String section;
  List<String> value;
}

class PlantCreation extends StatelessWidget {
  final int plantId;

  PlantCreation({
    super.key,
    required this.plantId,
  });

  // API vars
  final String plantName = "Plant Name";
  final String plantScientificName = "Plant Scientific Name";
  final List<String> plantOtherNames = ["Other Name 1", "Other Name 2"];
  final List<PlantFact> keyFacts = [
    PlantFact(section: "watering", value: "Frequent"),
    PlantFact(section: "cycle", value: "Perennial"),
    PlantFact(section: "sunlight", value: "Part shade"),
    PlantFact(section: "pruning month", value: "April"),
  ];
  final List<PlantCharacteristic> plantCharacteristics = [
    PlantCharacteristic(section: "Hardiness", value: ["7 to 9"]),
    PlantCharacteristic(section: "Pruning Months", value: ["March", "April"]),
    PlantCharacteristic(section: "Propagation", value: ["Seeding", "Cutting"]),
    PlantCharacteristic(
        section: "Attracts", value: ["Bees", "Rabbits", "Birds"]),
  ];
  final difficulty = "High";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: screenHeight * 0.35,
              width: screenWidth,
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                plantName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.main,
                                  fontSize: 24,
                                ),
                              ),
                              IconButton.outlined(
                                onPressed: () {},
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
                              "Also known as $plantScientificName, ${plantOtherNames.join(", ")}",
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
                              "Amazing garden plant that is sure to capture attention...",
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
                          keyFacts.length,
                          (index) {
                            Color color = index % 2 == 0
                                ? AppColors.secoundry.withOpacity(0.35)
                                : AppColors.gradientStart.withOpacity(0.35);
                            return Padding(
                              padding: EdgeInsets.only(top: marginY * 0.25),
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
                                        keyFacts[index].section,
                                        style: TextStyle(
                                          color: AppColors.main,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        keyFacts[index].value,
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
                          child: getDifficulty(difficulty),
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
                          plantCharacteristics.length,
                          (index) {
                            Color color = index % 2 == 0
                                ? AppColors.secoundry.withOpacity(0.35)
                                : AppColors.gradientStart.withOpacity(0.35);
                            return Padding(
                              padding: EdgeInsets.only(top: marginY * 0.25),
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
                                        plantCharacteristics[index].section,
                                        style: TextStyle(
                                          color: AppColors.main,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        plantCharacteristics[index]
                                            .value
                                            .join(", "),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getDifficulty(String value) {
  Color color = AppColors.main;
  IconData icon = Icons.signal_cellular_alt_1_bar;

  if (value == "Medium") {
    color = AppColors.thridry;
    icon = Icons.signal_cellular_alt_2_bar;
  }
  if (value == "High") {
    color = AppColors.gradientEnd;
    icon = Icons.signal_cellular_4_bar;
  }

  return Column(
    children: [
      Icon(
        icon,
        size: 24,
        color: color,
      ),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 24,
        ),
      )
    ],
  );
}
