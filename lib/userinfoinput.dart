//import 'dart:ffi';
import 'package:appen/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyUserInfoPage extends StatefulWidget {
  const MyUserInfoPage({super.key, required this.title});

  final String title;

  @override
  State<MyUserInfoPage> createState() => _MyUserInfoState();
}

class _MyUserInfoState extends State<MyUserInfoPage> {
  final firstNameController = TextEditingController();
  final familyNameController = TextEditingController();
  final ageController = TextEditingController();
  late String uid;

  Future<void> addInfo(firstName, lastName, age, uid) async {
    UserData userInfo = UserData(uid, firstName, lastName, age);
  }

  Future<void> getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        uid = user.uid;
      }
    });
  }

  void _login() async {
    String firstName = firstNameController.text;
    String lastName = familyNameController.text;
    String age = ageController.text;

    await getUser().then((value) {
      addInfo(firstName, lastName, age, uid);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Email',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            Text(
              'Lösenord',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
                controller: familyNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            ElevatedButton(onPressed: _login, child: const Text("Registrera")),
          ],
        ),
      ),
    );
  }
}
