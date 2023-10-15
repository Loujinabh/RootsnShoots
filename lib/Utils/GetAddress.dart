import 'package:geocoding/geocoding.dart';
import 'package:plant_diary/Utils/GetLocation.dart';

Future<String> getAddress() async {
  try {
    var location = await getLocation();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address = "${place.locality}, ${place.country}";
      return address;
    }
  } catch (e) {
    print("Error getting address: $e");
  }
  return "Address not found";
}
