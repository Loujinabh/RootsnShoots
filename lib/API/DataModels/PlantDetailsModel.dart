import 'package:plant_diary/API/DataModels/PlantModel.dart';

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

class PlantDetailsModel {
  PlantDetailsModel({
    required this.plantName,
    required this.plantScientificName,
    required this.plantOtherNames,
    required this.description,
    required this.keyFacts,
    required this.plantCharacteristics,
    this.careTips,
    this.history,
    this.creationDate,
    required this.floweringSeason,
    required this.difficulty,
    required this.imageSrc,
  });

  String plantName;
  String plantScientificName;
  List<String> plantOtherNames;
  String description;
  List<PlantFact> keyFacts;
  List<PlantCharacteristic> plantCharacteristics;
  List<CareTips>? careTips;
  List<HistoryRecord>? history;
  DateTime? creationDate;
  String floweringSeason;
  String difficulty;
  String imageSrc;

  int ageInYears() {
    if (creationDate != null) {
      final currentDate = DateTime.now();
      final difference = currentDate.difference(creationDate!);
      return difference.inDays ~/ 365.25;
    } else {
      return 0;
    }
  }

  int ageInMonths() {
    if (creationDate != null) {
      final currentDate = DateTime.now();
      final difference = currentDate.difference(creationDate!);
      return difference.inDays ~/ 30.44;
    } else {
      return 0;
    }
  }

  int ageInDays() {
    if (creationDate != null) {
      final currentDate = DateTime.now();
      final difference = currentDate.difference(creationDate!);
      return difference.inDays;
    } else {
      return 0;
    }
  }

  String getStringAge() {
    if (ageInYears() > 0) {
      return "${ageInYears()} yo.";
    } else if (ageInMonths() > 0) {
      return "${ageInMonths()} mo.";
    } else {
      return "${ageInDays()} da.";
    }
  }

  double getProgress() {
    if (creationDate != null) {
      var difference = DateTime.now().difference(creationDate!).inDays;
      return difference / 365.25;
    }
    return 0.0;
  }

  factory PlantDetailsModel.fromJSON(Map<String, dynamic> json) {
    var defaultImage = json['default_image'];
    String imageRef = "";
    if (defaultImage == null) {
      imageRef = "";
    } else if (defaultImage['original_url'] == null) {
      imageRef = "";
    } else {
      imageRef = defaultImage['original_url'];
    }

    List<PlantFact> facts = [];
    List<PlantCharacteristic> characteristics = [];
    if (json['watering'] != null) {
      facts.add(
        PlantFact(
          section: "Watering",
          value: json['watering'],
        ),
      );
    }
    if (json['cycle'] != null) {
      facts.add(
        PlantFact(
          section: "Cycle",
          value: json['cycle'],
        ),
      );
    }
    if (json['sunlight'] != null) {
      facts.add(
        PlantFact(
          section: "Sunlight",
          value: json['sunlight'].join(", "),
        ),
      );
    }
    if (json['pruning_month'] != null) {
      facts.add(
        PlantFact(
          section: "Planting Months",
          value: json['pruning_month'].join(", "),
        ),
      );
    }

    if (json['hardiness'] != null) {
      String element =
          [json['hardiness']["min"], json['hardiness']["min"]].join(" to ");
      characteristics.add(
        PlantCharacteristic(
          section: "Hardiness",
          value: [element],
        ),
      );
    }
    if (json['pruning_month'] != null) {
      var list = json["pruning_month"] as List;
      characteristics.add(
        PlantCharacteristic(
          section: "Pruning Month",
          value: list.map((e) => e.toString()).toList(),
        ),
      );
    }
    if (json['propagation'] != null) {
      var list = json["propagation"] as List;
      characteristics.add(
        PlantCharacteristic(
          section: "Propagation",
          value: list.map((e) => e.toString()).toList(),
        ),
      );
    }
    if (json['attracts'] != null) {
      var list = json["attracts"] as List;
      characteristics.add(
        PlantCharacteristic(
          section: "Attracts",
          value: list.map((e) => e.toString()).toList(),
        ),
      );
    }
    var otherNamesList = json["other_name"] as List;

    return PlantDetailsModel(
      plantName: json["common_name"],
      plantScientificName: json["scientific_name"][0],
      plantOtherNames: otherNamesList.map((e) => e.toString()).toList(),
      description: json["description"],
      keyFacts: facts,
      plantCharacteristics: characteristics,
      floweringSeason: json["flowering_season"] ?? "Unknown",
      difficulty: json["maintenance"] ?? "Unknown",
      imageSrc: imageRef,
    );
  }
}
