import 'package:appen/guide.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuideGetter {
  int index = -1;
  Map<String, dynamic> textMap = {};
  Map<String, dynamic> imageUrlMap = {};

  String currentText = "-------------------------------->";
  String welcomeUrl =
      "https://via.placeholder.com/150"; // Placeholder image URL instead of Firebase Storage URL
  int guideID;

  String placeholderImageUrl =
      "https://via.placeholder.com/150"; // Placeholder image URL instead of Firebase Storage URL

  GuideGetter(this.guideID) {
    print("guideID $guideID");
    //fetchTexts();
    //fetchImgUrls();
    //print(imageUrlMap);
  }

  Future<List<String>> getGuideTitles() async {
    List<String> guideIDs = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('guides')
        .orderBy('guideID')
        .get()
        .then((value) {
      return value;
    });

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      var data = documentSnapshot.data() as Map<String, dynamic>;
      guideIDs.add(data["guideTitle"]);
    }
    print("LISTAN " + guideIDs.toString());
    return guideIDs;
  }

  void swapGuideID(int guideID1, int guideID2) async {
    DocumentSnapshot doc1 = await FirebaseFirestore.instance
        .collection('guides')
        .where('guideID', isEqualTo: guideID1)
        .get()
        .then((snapshot) {
      return snapshot.docs[0];
    });

    DocumentSnapshot doc2 = await FirebaseFirestore.instance
        .collection('guides')
        .where('guideID', isEqualTo: guideID2)
        .get()
        .then((snapshot) {
      return snapshot.docs[0];
    });

    await FirebaseFirestore.instance
        .collection('guides')
        .doc(doc1.id)
        .update({'guideID': guideID2});

    await FirebaseFirestore.instance
        .collection('guides')
        .doc(doc2.id)
        .update({'guideID': guideID1});
  }

  Future<void> fetchTexts() async {
    CollectionReference guideRef =
        FirebaseFirestore.instance.collection('guides');
    Query query = guideRef.where('guideID', isEqualTo: guideID);
    QuerySnapshot snapshot = await query.get();
    DocumentSnapshot doc = snapshot.docs[0];
    textMap = doc["texts"] as Map<String, dynamic>;
    //print(textMap);
    //textMap[index.toString()] = [
    //{"insert": currentText}
    //];
  }

  Future<void> fetchImgUrls() async {
    CollectionReference guideRef =
        FirebaseFirestore.instance.collection('guides');
    Query query = guideRef.where('guideID', isEqualTo: guideID);
    QuerySnapshot snapshot = await query.get();
    DocumentSnapshot doc = snapshot.docs[0];

    imageUrlMap = doc['imageUrls'] as Map<String, dynamic>;
    imageUrlMap[index.toString()] = welcomeUrl;
  }

  Map<String, dynamic> getTextMap() {
    return textMap;
  }

  Map<String, dynamic> getImageUrlMap() {
    return imageUrlMap;
  }
}
