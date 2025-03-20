import 'package:flutter/material.dart';
import 'package:webbapp1/guidemake.dart';
import 'package:webbapp1/quizMaker.dart';

import 'guideviewer.dart';

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

  void _createQuiz() {
    String quizName = quizNameController.text;
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizMaker(quizName: quizName)));
    });
  }

  void _goToGuideMaker() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GuideMaker(guideIndex: 1)));
    });
  }

  void _goToGuideViewer() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => GuideViewer(guideIndex: 1)));
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
            Text(
              'quizname',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
              controller: quizNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Quizname',
              ),
            ),
            ElevatedButton(
                onPressed: _createQuiz, child: const Text("Create Quiz")),
            ElevatedButton(
                onPressed: _goToGuideMaker, child: const Text("Guide Maker")),
            ElevatedButton(
                onPressed: _goToGuideViewer, child: const Text("Guide Viewer"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
