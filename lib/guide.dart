import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {
  int guideID;
  String guideTitle;
  Map<int, String> imageUrls;
  Map<int, dynamic> texts;

  Guide(this.guideID, this.imageUrls, this.texts, this.guideTitle);

  Map<String, dynamic> toJson() {
    return {
      'guideID': guideID,
      'guideTitle': guideTitle,
      'imageUrls': copyToStringKeys(imageUrls),
      'texts': copyToStringKeys(texts)
    };
  }

  Future<void> uploadToFirestore() async {
    FirebaseFirestore.instance.collection("guides").add(toJson());
  }

  Future<void> updateDocument() async {
    CollectionReference guideRef =
        FirebaseFirestore.instance.collection('guides');
    Query query = guideRef.where('guideID', isEqualTo: guideID);
    QuerySnapshot snapshot = await query.get();
    DocumentSnapshot doc = snapshot.docs[0];
    String docID = doc.id;
    print(docID);
    FirebaseFirestore.instance.collection('guides').doc(docID).update(toJson());
  }

  Map<String, dynamic> copyToStringKeys(Map<int, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = value;
    });
    return newMap;
  }
}
