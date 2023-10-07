import 'package:plant_diary/API/DataModels/SearchPlantModel.dart';
import 'package:plant_diary/Config/Keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String perenualUrl =
    "https://perenual.com/api/species-list?key=${Keys.plantSearchKey}&q=";

Future<List<SearchPlantModel>> searchPlant(String query) async {
  final response = await http.get(Uri.parse(perenualUrl + query));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<dynamic> listPlants = data['data'];
    List<SearchPlantModel> plantsModels =
        listPlants.map((e) => SearchPlantModel.fromJSON(e)).toList();

    return plantsModels;
  } else {
    throw Exception('Failed to load data');
  }
}
