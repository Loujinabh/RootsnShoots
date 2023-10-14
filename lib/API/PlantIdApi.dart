import 'package:plant_diary/Config/Keys.dart';
import 'package:plant_diary/Utils/GetLocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantIdentity {
  PlantIdentity({
    required this.name,
    required this.images,
  });

  String name;
  List<String> images;
}

class PlantDisease {
  PlantDisease({
    required this.name,
    required this.description,
    required this.treatment,
    required this.images,
  });

  String name;
  String description;
  Map<String, dynamic> treatment;
  List<String> images;
}

class PlantHealth {
  PlantHealth({
    required this.health,
    required this.diseases,
  });

  double health;
  List<PlantDisease> diseases;
}

class PlantIdApi {
  static Future<PlantIdentity> identifyPlant(String base64) async {
    final url = Uri.parse('https://plant.id/api/v3/identification');

    var location = await getLocation();

    final Map<String, dynamic> requestBody = {
      "images": [base64],
      "latitude": location.latitude,
      "longitude": location.longitude,
      "similar_images": true,
    };

    final headers = {
      'Api-Key': Keys.plantId,
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode < 300) {
      try {
        var suggestion = data['result']['classification']['suggestions'][0];
        var similarImages = suggestion['similar_images'] as List;
        return PlantIdentity(
          name: suggestion['name'],
          images: similarImages.map((e) => e['url'].toString()).toList(),
        );
      } catch (e) {
        return PlantIdentity(name: "Unknown", images: []);
      }
    } else {
      return PlantIdentity(name: "Unknown", images: []);
    }
  }

  static Future<PlantHealth> diagnosePlant(String base64) async {
    final url = Uri.parse(
        'https://plant.id/api/v3/health_assessment?details=description,treatment,cause');

    var location = await getLocation();

    final Map<String, dynamic> requestBody = {
      "images": [base64],
      "latitude": location.latitude,
      "longitude": location.longitude,
      "similar_images": true,
    };

    final headers = {
      'Api-Key': Keys.plantId,
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode < 300) {
      try {
        Map<String, dynamic> result = data['result'];
        double health = result['is_healthy']["probability"];
        var diseases = result['disease']['suggestions'] as List;

        List<PlantDisease> diseasesList = diseases.map((e) {
          var name = e['name'];
          var similarImages = e['similar_images'] as List;
          var images = similarImages.map((e) => e['url'].toString()).toList();
          var description =
              e['details']['description'] ?? "No description available.";
          var treatments = e['details']['treatment'] ??
              {
                "Unknown": ["No treatments found in database."]
              };

          return PlantDisease(
              name: name,
              description: description,
              treatment: treatments,
              images: images);
        }).toList();

        return PlantHealth(diseases: diseasesList, health: health);
      } catch (e) {
        return PlantHealth(diseases: [], health: 0.0);
      }
    } else {
      return PlantHealth(diseases: [], health: 0.0);
    }
  }
}
