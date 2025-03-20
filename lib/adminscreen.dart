import 'package:appen/guideMakerList.dart';
import 'package:appen/guidelistview.dart';
import 'package:appen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class MyAdminPage extends StatefulWidget {
  const MyAdminPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyAdminPage> createState() => _MyAdminPageState();
}

class _MyAdminPageState extends State<MyAdminPage> {
  final quizNameController = TextEditingController();

  void _goToGuideMaker() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GuideMakerList()));
    });
  }

  void _goToGuideViewer() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyListView()));
    });
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyLoginPage(title: "Login")));
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
            ElevatedButton(
                onPressed: _goToGuideMaker, child: const Text("Guide Maker")),
            ElevatedButton(
                onPressed: _goToGuideViewer, child: const Text("Guide Viewer")),
            ElevatedButton(onPressed: signOut, child: const Text("Sign out"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
