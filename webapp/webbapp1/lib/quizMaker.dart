//import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class QuizMaker extends StatefulWidget {
  const QuizMaker({super.key, required this.quizName});
  final String title = "QuizMaker";
  final String quizName;

  @override
  State<QuizMaker> createState() => _QuizMakerState();
}

class _QuizMakerState extends State<QuizMaker> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final quizNameController = TextEditingController();
  final db = FirebaseFirestore.instance;

  Future<void> addQuestion(question, answer) async {
    final data = <String, String>{"question": question, "answer": answer};
    db.collection("quizzes").doc(widget.quizName).set(data);
  }

  void _addQuestion() {
    String question = questionController.text;
    String answer = answerController.text;
    //String quizName = quizNameController.text;
    addQuestion(question, answer);

    addQuestion(question, answer);
    setState(() {});
  }

  void _addQuiz() {
    var count = 0;
    final quizRef = db.collection("quizzes");
    final quizzes = quizRef.where("quizName", isEqualTo: widget.quizName);

    if (count == 0) {
      final quiz = {"quizName": widget.quizName};
      quizRef.add(quiz);
    }
  }

  @override
  Widget build(BuildContext context) {
    _addQuiz();
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
              'question',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            Text(
              'answer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
                controller: answerController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            ElevatedButton(
                onPressed: _addQuestion, child: const Text("Add Question")),
            Text(
              'flervalfråga',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextFormField(
                controller: answerController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                )),
            ElevatedButton(
                onPressed: _addQuestion, child: const Text("Add Question"))
          ],
        ),
      ),
    );
  }
}
