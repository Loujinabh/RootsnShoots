class SearchPlantModel {
  SearchPlantModel({
    required this.id,
    required this.common_name,
    required this.scientific_name,
    required this.cycle,
    required this.watering,
    required this.default_image,
  });

  int id;
  String common_name;
  String scientific_name;
  String cycle;
  String watering;
  String default_image;

  factory SearchPlantModel.fromJSON(Map<String, dynamic> json) {
    var defaultImage = json['default_image'];
    String imageRef = "";
    if (defaultImage == null) {
      imageRef = "";
    } else if (defaultImage['original_url'] == null) {
      imageRef = "";
    } else {
      imageRef = defaultImage['original_url'];
    }

    return SearchPlantModel(
        id: json['id'],
        common_name: json['common_name'],
        scientific_name: json['scientific_name'][0],
        cycle: json['cycle'],
        watering: json['watering'],
        default_image: imageRef);
  }
}
