class HistoryRecord {
  HistoryRecord({
    required this.content,
    required this.creationDate,
  });

  String content;
  DateTime creationDate;
}

class CareTips {
  CareTips({
    required this.title,
    required this.content,
  });

  String title;
  String content;
}

class PlantModel {
  PlantModel({
    required this.name,
    required this.scientificName,
    required this.imageSrc,
    this.creationDate,
    this.progressNum,
    this.history,
    this.tips,
  });

  String name;
  String scientificName;
  String imageSrc;
  DateTime? creationDate;
  double? progressNum;
  List<HistoryRecord>? history;
  List<CareTips>? tips;

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
}
