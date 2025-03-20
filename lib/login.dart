//import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void _login() {
    String emailAddress = emailController.text;
    String password = passwordController.text;
    login(emailAddress, password);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, '/admin');
      }
    });

    setState(() {});
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, '/admin');
      }
    });
    super.initState();
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
              controller: emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            Text(
              'Lösenord',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
                controller: passwordController,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            ElevatedButton(
                onPressed: _goToRegister, child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
