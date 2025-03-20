import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditQuizQuestionScreen extends StatefulWidget {
  final String quizQuestionId;

  EditQuizQuestionScreen({required this.quizQuestionId});

  @override
  _EditQuizQuestionScreenState createState() => _EditQuizQuestionScreenState();
}

class _EditQuizQuestionScreenState extends State<EditQuizQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers = [];

  int _correctAnswerIndex = 0;

  @override
  void initState() {
    super.initState();
    _getQuizQuestion();
  }

  void _getQuizQuestion() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://YOUR_CLOUD_FUNCTION_REGION-YOUR_PROJECT_ID.cloudfunctions.net/getQuizQuestion?id=${widget.quizQuestionId}'),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to get quiz question');
      }
      final quizQuestion = jsonDecode(response.body);
      _questionController.text = quizQuestion['question'];
      _answerControllers.clear();
      for (var answer in quizQuestion['answers']) {
        _answerControllers.add(TextEditingController(text: answer));
      }
      _correctAnswerIndex = quizQuestion['correctAnswer'];
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Quiz Question')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              ..._answerControllers.map((controller) {
                int index = _answerControllers.indexOf(controller);
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration:
                        InputDecoration(labelText: 'Answer ${index + 1}'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an answer';
                      }
                      return null;
                    },
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DropdownButtonFormField(
                  value: _correctAnswerIndex,
                  items: _answerControllers
                      .map((controller) => DropdownMenuItem(
                            value: _answerControllers.indexOf(controller),
                            child: Text(controller.text),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _correctAnswerIndex = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  child: Text('Update'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final question = {
                          "id": widget.quizQuestionId,
                          "question": _questionController.text,
                          "answers":
                              _answerControllers.map((c) => c.text).toList(),
                          "correctAnswer": _correctAnswerIndex,
                        };
                        final response = await http.post(
                          Uri.parse(
                              'https://us-central1-your-project-id.cloudfunctions.net/updateQuizQuestion'),
                          body: jsonEncode(question),
                          headers: {'Content-Type': 'application/json'},
                        );
                        if (response.statusCode != 200) {
                          throw Exception('Failed to update quiz question');
                        }
                        Navigator.of(context).pop();
                      } catch (error) {
                        print(error);
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  child: Text('Delete'),
                  onPressed: () async {
                    try {
                      final response = await http.delete(
                        Uri.parse(
                            'https://us-central1-your-project-id.cloudfunctions.net/deleteQuizQuestion?id=${widget.quizQuestionId}'),
                      );
                      if (response.statusCode != 200) {
                        throw Exception('Failed to delete quiz question');
                      }
                      Navigator.of(context).pop();
                    } catch (error) {
                      print(error);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
