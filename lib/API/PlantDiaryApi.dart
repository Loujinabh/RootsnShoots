import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_diary/API/DataModels/PlantDetailsModel.dart';
import 'package:plant_diary/API/DataModels/PlantModel.dart';
import 'package:plant_diary/API/GetPlantTipsApi.dart';

class PlantDiaryApi {
  static Future<void> addPlant({
    required String name,
    required String scientificName,
    required int speciesId,
    required String imageRef,
    required List<PlantFact> keyFacts,
    required String difficulty,
    required List<PlantCharacteristic> plantCharacteristics,
  }) async {
    CollectionReference plants =
        FirebaseFirestore.instance.collection('PlantDiary');

    var plantTips = await getPlantTipsApi(speciesId);
    List<Map<String, String>> plantTipsMap = plantTips
        .map((e) => {
              "title": e.title[0].toUpperCase() + e.title.substring(1),
              "content": e.content
            })
        .toList();
    List<Map<String, String>> keyFactsMap =
        keyFacts.map((e) => {"section": e.section, "value": e.value}).toList();
    List<Map<String, Object>> plantCharacteristicsMap = plantCharacteristics
        .map((e) => {'section': e.section, 'value': e.value})
        .toList();
    List<Map<String, Object>> historyMap = [];

    User? user = FirebaseAuth.instance.currentUser;
    String userId = "";
    if (user != null) {
      userId = user.uid;
    }

    return plants
        .add({
          'userId': userId,
          'speciesId': speciesId.toString(),
          'name': name,
          'scientificName': scientificName,
          'imageRef': imageRef,
          'creationDate': DateTime.now(),
          "keyFacts": keyFactsMap,
          "difficulty": difficulty,
          "plantCharacteristics": plantCharacteristicsMap,
          'tips': plantTipsMap,
          'history': historyMap,
        })
        .then((value) => print("Plant Added"))
        .catchError((error) => print("Failed to add Plant: $error"));
  }

  static Future<List<PlantDetailsModel>> getPlantsByUserId() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('PlantDiary');
        QuerySnapshot querySnapshot =
            await collection.where('userId', isEqualTo: userId).get();
        List<PlantDetailsModel> plants = querySnapshot.docs.map(
          (doc) {
            var data = doc.data() as Map<String, dynamic>;
            var cateTips = data["tips"] as List;

            return PlantDetailsModel(
              plantName: data["name"],
              plantScientificName: data["scientificName"],
              plantOtherNames: [],
              description: "",
              careTips: cateTips
                  .map(
                      (e) => CareTips(title: e["title"], content: e["content"]))
                  .toList(),
              creationDate: data["creationDate"].toDate(),
              keyFacts: [],
              plantCharacteristics: [],
              floweringSeason: "",
              difficulty: data["difficulty"],
              imageSrc: data["imageRef"],
            );
          },
        ).toList();

        return plants;
      } catch (e) {
        print('Error retrieving documents: $e');
        return [];
      }
    } else {
      print('No user is currently authenticated.');
      return [];
    }
  }
}
