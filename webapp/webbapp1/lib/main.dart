import 'package:flutter/material.dart';
import 'package:webbapp1/adminscreen.dart';
import 'package:webbapp1/gptquiz.dart';
import 'package:webbapp1/guidelistview.dart';
import 'package:webbapp1/imagetext.dart';
import 'package:webbapp1/lista.dart';
import 'package:webbapp1/login.dart';
import 'package:webbapp1/quizscreen.dart';
import 'package:webbapp1/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:webbapp1/uploadimage.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAdminPage(title: "admin"),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const MyLoginPage(
              title: "Login",
            ),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const MyRegisterPage(title: "Register"),
        '/lista': (context) => const ListTileSelectExample(),
        '/quiz': (context) => const MyQuizPage(title: "quiz"),
        '/admin': (context) => const MyAdminPage(title: "Admin")
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void login() {
    setState(() {
      Navigator.pushNamed(context, '/login');
    });
  }

  void goToAdmin() {
    setState(() {
      Navigator.pushNamed(context, '/admin');
    });
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
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            ElevatedButton(
                onPressed: goToAdmin, child: const Text("Admin Page"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
