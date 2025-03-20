import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String uid;
  String firstName;
  String lastName;
  String age;

  UserData(this.uid, this.firstName, this.lastName, this.age);

  Future<void> uploadData() async {
    FirebaseFirestore.instance.collection("users").add(getJson());
  }

  Map<String, dynamic> getJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "age": age
    };
  }
}
