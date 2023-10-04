import 'package:cloud_firestore/cloud_firestore.dart';

class Tips {
  static Future<List<dynamic>> getTips() async {
    CollectionReference tipsCollection =
        FirebaseFirestore.instance.collection('SeasonalTips');

    var snapshot = await tipsCollection.get();
    Map<String, dynamic> data = snapshot.docs[0].data() as Map<String, dynamic>;

    String season = "Spring";
    var dateMonth = DateTime.now().month;
    if (dateMonth >= 3 && dateMonth <= 5) {
      season = "Spring";
    } else if (dateMonth >= 6 && dateMonth <= 8) {
      season = "Summer";
    } else if (dateMonth >= 9 && dateMonth <= 11) {
      season = "Autumn";
    } else {
      season = "Winter";
    }
    return data[season] as List;
  }
}
