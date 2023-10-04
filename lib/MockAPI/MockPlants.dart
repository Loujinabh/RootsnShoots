import 'package:plant_diary/Utils/PlantModel.dart';

class MockPlants {
  static List<PlantModel> myGarden = [
    PlantModel(
      name: "5obezeh",
      scientificName: "Malva pusilla",
      imageSrc: "assets/images/background.jpg",
      creationDate: DateTime(2022, 7, 17),
      progressNum: 0.2,
      history: [
        HistoryRecord(
            content: "I'm doing well <3", creationDate: DateTime(2023, 7, 17))
      ],
      tips: [
        CareTips(
          title: "Water",
          content:
              "Moisture-loving, keep the soil moist but do not let water accumulate.",
        ),
        CareTips(
          title: "Pruning",
          content: "Shape the plant every 2 months during the growing season.",
        ),
      ],
    ),
    PlantModel(
      name: "Plant 1",
      scientificName: "Malva pusilla 2",
      imageSrc: "assets/images/background.jpg",
      creationDate: DateTime(2023, 3, 13),
      progressNum: 0.4,
      tips: [
        CareTips(
          title: "Water",
          content:
              "Moisture-loving, keep the soil moist but do not let water accumulate.",
        )
      ],
    ),
    PlantModel(
      name: "Plant 2",
      scientificName: "Malva pusilla 3",
      imageSrc: "assets/images/background.jpg",
      creationDate: DateTime(2023, 2, 13),
      progressNum: 0.56,
      history: <HistoryRecord>[
        HistoryRecord(
            content: "Honestly, I thought I'd be dead by now.",
            creationDate: DateTime(2023, 4, 4)),
        HistoryRecord(
            content: "Thank you for taking care of me <3",
            creationDate: DateTime(2023, 4, 5))
      ],
    ),
    PlantModel(
      name: "Plant 3",
      scientificName: "Malva pusilla 4",
      imageSrc: "assets/images/background.jpg",
      creationDate: DateTime(2023, 9, 13),
      progressNum: 0.1,
      history: <HistoryRecord>[
        HistoryRecord(
            content: "I'm don't know, I'm just a little plant :3",
            creationDate: DateTime(2023, 9, 30))
      ],
    ),
  ];

  static List<PlantModel> trendingInJordan = [
    PlantModel(
        name: "Plant 1",
        scientificName: "Malva pusilla 1",
        imageSrc: "assets/images/background.jpg"),
    PlantModel(
        name: "Plant 2",
        scientificName: "Malva pusilla 2",
        imageSrc: "assets/images/background.jpg"),
    PlantModel(
        name: "Plant 3",
        scientificName: "Malva pusilla 3",
        imageSrc: "assets/images/background.jpg"),
    PlantModel(
        name: "Plant 4",
        scientificName: "Malva pusilla 4",
        imageSrc: "assets/images/background.jpg"),
    PlantModel(
        name: "Plant 5",
        scientificName: "Malva pusilla 5",
        imageSrc: "assets/images/background.jpg"),
  ];
}
