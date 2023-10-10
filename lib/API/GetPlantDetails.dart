import 'package:plant_diary/API/DataModels/PlantDetailsModel.dart';
import 'package:plant_diary/Config/Keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<PlantDetailsModel> getPlantDetailsApi(int plantId) async {
  String perenualUrl =
      "https://perenual.com/api/species/details/${plantId}?key=${Keys.plantSearchKey}";
  final response = await http.get(Uri.parse(perenualUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    var plantDetailsModel = PlantDetailsModel.fromJSON(data);
    return plantDetailsModel;
  } else {
    throw Exception('Failed to load data');
  }
}
