import 'package:cloud_firestore/cloud_firestore.dart';

class GuideGetter {
  int index = -1;
  Map<String, dynamic> textMap = {};
  Map<String, dynamic> imageUrlMap = {};

  String currentText = "-------------------------------->";
  int guideID;

  GuideGetter(this.guideID) {
    //fetchTexts();
    //fetchImgUrls();
    //print(imageUrlMap);
  }

  Future<void> fetchTexts() async {
    CollectionReference guideRef =
        FirebaseFirestore.instance.collection('guides');
    Query query = guideRef.where('guideID', isEqualTo: guideID);
    QuerySnapshot snapshot = await query.get();
    DocumentSnapshot doc = snapshot.docs[0];
    textMap = doc["texts"] as Map<String, dynamic>;
    print(textMap);
    textMap[index.toString()] = currentText;
  }

  Future<void> fetchImgUrls() async {
    CollectionReference guideRef =
        FirebaseFirestore.instance.collection('guides');
    Query query = guideRef.where('guideID', isEqualTo: 1);
    QuerySnapshot snapshot = await query.get();
    DocumentSnapshot doc = snapshot.docs[0];

    final x = doc['imageUrls'] as Map<String, dynamic>;
    imageUrlMap = x;
  }

  Map<String, dynamic> getTextMap() {
    return textMap;
  }

  Map<String, dynamic> getImageUrlMap() {
    return imageUrlMap;
  }
}
