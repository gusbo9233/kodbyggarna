class Question {
  String question = "";
  bool isMultipleChoice = false;
  var answers = <String>{};
  var singleAnswer = "";

  Question(this.question, this.isMultipleChoice);

  void addAnswer(String answer) {
    answers.add(answer);
  }
}
