import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {
  int guideID;
  Map<int, String> imageUrls;
  Map<int, dynamic> texts;

  Guide(this.guideID, this.imageUrls, this.texts);

  Map<String, dynamic> toJson() {
    return {
      'guideID': guideID,
      'imageUrls': copyToStringKeys(imageUrls),
      'texts': copyToStringKeys(texts)
    };
  }

  void uploadToFirestore() async {
    FirebaseFirestore.instance.collection("guides").add(toJson());
  }

  Map<String, dynamic> copyToStringKeys(Map<int, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = value;
    });
    return newMap;
  }
}
