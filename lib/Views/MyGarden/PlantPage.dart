import 'package:flutter/material.dart';
import 'package:plant_diary/API/DataModels/PlantDetailsModel.dart';
import 'package:plant_diary/API/DataModels/PlantModel.dart';
import 'package:plant_diary/API/PlantDiaryApi.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/DateFormatter.dart';
import 'package:plant_diary/Utils/ShowSnackbar.dart';
import 'package:plant_diary/Widgets/ImageCards/ImageDisplay.dart';
import 'package:plant_diary/Widgets/PageHelpers/GetDifficulty.dart';
import 'package:plant_diary/Widgets/PageHelpers/ProgressBar.dart';
import 'package:plant_diary/Widgets/Titles/BoxTitle.dart';
import 'package:plant_diary/Widgets/Titles/TitleChip.dart';

class PlantPage extends StatefulWidget {
  final PlantDetailsModel plant;

  PlantPage({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  _PlantPageState createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  late final PlantDetailsModel plant;
  late List<HistoryRecord> history;
  @override
  void initState() {
    super.initState();
    plant = widget.plant;
    history = plant.history!;
  }

  Future<void> addHistoryRecord() async {
    TextEditingController textFieldController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.contrast,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Add History Record",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.main,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    hintText: "Enter your record",
                    hintStyle: TextStyle(
                      color: AppColors.main,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String historyRecord = textFieldController.text;
                    if (historyRecord.isNotEmpty) {
                      var record = HistoryRecord(
                        content: historyRecord,
                        creationDate: DateTime.now(),
                      );
                      var statusCode = await PlantDiaryApi.appendToHistory(
                          plant.uid!, record);
                      if (statusCode == 200) {
                        showSnackBar("History record added");
                        setState(() {
                          history.add(record);
                        });
                      } else {
                        showSnackBar("Failed to add history record ");
                      }

                      Navigator.of(context).pop();
                    } else {
                      showSnackBar("Enter record content");
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.main),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: AppColors.contrast,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    double historyBoxHeight = screenHeight * 0.25;
    if (history.isNotEmpty) {
      historyBoxHeight = history.length * screenHeight * 0.1;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
                                        SizedBox(
                                          width: screenWidth * 0.8,
                                          child: Text(
                                            "${plant.plantName}'s Diary",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.037,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.secoundry,
                                            ),
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
                        ImageDisplay(
                          height: screenHeight * 0.22,
                          width: screenWidth * 0.38,
                          plantImage: plant.imageSrc,
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
                                formatDate(plant.creationDate!),
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
                                    content: plant.plantName,
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.3,
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  TitleChip(
                                    content: plant.getStringAge(),
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
                                content: plant.plantScientificName,
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
                                progress: plant.getProgress(),
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
            Container(
              height: screenHeight * 0.62,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.contrast,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: marginY * 2,
                    left: marginX * 1.5,
                    right: marginX * 1.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BoxTitle(
                        icon: Icons.local_florist,
                        title: "How to take care of them",
                        color: AppColors.main,
                      ),
                      if (plant.careTips != null)
                        ...List.generate(
                          plant.careTips!.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: marginY * 0.25),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? AppColors.gradientStart.withOpacity(0.35)
                                    : AppColors.secoundry.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: marginY * 0.5,
                                    horizontal: marginX * 0.75),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant.careTips![index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.main,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: marginY * 0.25,
                                        left: marginX * 0.5,
                                      ),
                                      child: Text(
                                        plant.careTips![index].content,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.main,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.gradientStart.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: marginY, horizontal: marginX * 0.75),
                            child: Center(
                              child: Text(
                                "No Tips available.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.main,
                                  fontSize: 16,
                                ),
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
                                      plant.plantCharacteristics[index].section,
                                      style: TextStyle(
                                        color: AppColors.main,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.5,
                                      child: Text(
                                        plant.plantCharacteristics[index].value
                                                .join(", ")
                                                .isEmpty
                                            ? "Unknown"
                                            : plant.plantCharacteristics[index]
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
                      Padding(
                        padding: EdgeInsets.only(top: marginY * 0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BoxTitle(
                              icon: Icons.local_florist,
                              title: "Health History",
                              color: AppColors.main,
                            ),
                            IconButton(
                                onPressed: () => addHistoryRecord(),
                                icon: Icon(
                                  Icons.add,
                                  color: AppColors.main,
                                  size: marginY * 0.25 + marginX,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black87.withOpacity(0.3),
                                        offset: const Offset(0, 3),
                                        blurRadius: 6)
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: historyBoxHeight,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: AppColors.gradientStart.withOpacity(0.35),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: marginY * 0.5,
                              horizontal: marginX * 0.75),
                          child: Column(
                            children: history.isNotEmpty
                                ? List.generate(
                                    history.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.only(
                                          bottom: marginY * 0.5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.4,
                                            child: Text(
                                              history[index].content,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.gray,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            formatDate(
                                                history[index].creationDate),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.gray,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : [
                                    Text(
                                      "No History available.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.gray,
                                          fontSize: 14),
                                    )
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
        ),
      ),
    );
  }
}
