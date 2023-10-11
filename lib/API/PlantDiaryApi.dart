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

  static Future<List<PlantDetailsModel>> getPlantsByUserId({int? count}) async {
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
            var facts = data['keyFacts'] as List;
            var characteristicsMap = data['plantCharacteristics'] as List;
            var characteristics = <PlantCharacteristic>[];
            if (characteristicsMap.isNotEmpty) {
              characteristics = characteristicsMap.map((e) {
                var valueRaw = e['value'] as List;
                var value = valueRaw.map((e) => e.toString()).toList();
                var section = e['section'];
                return PlantCharacteristic(section: section, value: value);
              }).toList();
            }

            var history = data['history'] as List;

            return PlantDetailsModel(
              uid: doc.id,
              plantName: data["name"],
              plantScientificName: data["scientificName"],
              plantOtherNames: [],
              description: "",
              careTips: cateTips
                  .map(
                      (e) => CareTips(title: e["title"], content: e["content"]))
                  .toList(),
              creationDate: data["creationDate"].toDate(),
              keyFacts: facts
                  .map(
                    (e) => PlantFact(
                      section: e["section"],
                      value: e["value"],
                    ),
                  )
                  .toList(),
              plantCharacteristics: characteristics,
              floweringSeason: "",
              difficulty: data["difficulty"],
              imageSrc: data["imageRef"],
              history: history
                  .map(
                    (e) => HistoryRecord(
                      content: e['content'],
                      creationDate: e['creationDate'].toDate(),
                    ),
                  )
                  .toList(),
            );
          },
        ).toList();

        if (count != null) {
          return plants.take(count).toList();
        }

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

  static Future<int> appendToHistory(
    String documentID,
    HistoryRecord historyRecord,
  ) async {
    try {
      final DocumentReference docRef =
          FirebaseFirestore.instance.collection('PlantDiary').doc(documentID);

      Map<String, dynamic> data = {
        "content": historyRecord.content,
        "creationDate": historyRecord.creationDate
      };

      await docRef.update({
        'history': FieldValue.arrayUnion([data])
      });
      return 200;
    } catch (e) {
      print("Error adding element to the history: $e");
      return 400;
    }
  }
}
