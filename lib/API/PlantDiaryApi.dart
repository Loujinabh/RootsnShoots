import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_diary/Utils/PlantModel.dart';

class PlantDiaryApi {
  static Future<void> addPlant({
    required String name,
    required String scientificName,
    required String imageRef,
    required DateTime creationDate,
    required List<HistoryRecord> history,
    required List<CareTips> tips,
  }) {
    CollectionReference plants =
        FirebaseFirestore.instance.collection('PlantDiary');

    return plants
        .add({
          'name': name,
          'scientificName': scientificName,
          'imageRef': imageRef,
          'creationDate': creationDate,
          'history': history.asMap(),
          'tips': tips.asMap(),
        })
        .then((value) => print("Plant Added"))
        .catchError((error) => print("Failed to add Plant: $error"));
  }
}
