import 'package:flutter/material.dart';

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({super.key, required this.title});

  final String title;

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  void submitAnswer() {
    setState(() {});
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
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Svar',
              ),
            ),
            TextButton(
                onPressed: submitAnswer, child: const Icon(Icons.check_box)),
          ],
        ),
      ),
    );
  }
}
