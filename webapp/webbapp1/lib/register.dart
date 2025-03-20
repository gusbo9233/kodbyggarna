import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenController = TextEditingController();

  void _register() {
    String emailAddress = nameController.text;
    String password = nameController.text;

    register(emailAddress, password);
  }

  Future<void> addUser(String emailAddress, String id) async {}

  Future<void> register(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Användarnamn',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            Text(
              'Lösenord',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            Text(
              'Aktiveringsnyckel',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
                controller: tokenController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            ElevatedButton(
                onPressed: _register, child: const Text("Registrera"))
          ],
        ),
      ),
    );
  }
}
