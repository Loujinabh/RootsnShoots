import 'package:plant_diary/API/DataModels/PlantModel.dart';
import 'package:plant_diary/Config/Keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<CareTips>> getPlantTipsApi(int plantId) async {
  String perenualUrl =
      "https://perenual.com/api/species-care-guide-list?key=${Keys.plantSearchKey}&species_id=$plantId";
  final response = await http.get(Uri.parse(perenualUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    var plantTips = data["data"][0]["section"] as List;

    return plantTips
        .map((e) => CareTips(title: e["type"], content: e["description"]))
        .toList();
  } else {
    throw Exception('Failed to load data');
  }
}
