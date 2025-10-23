// class Player {
//   final String name;
  
// }

class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;

  Question(
      {required this.title, required this.choices, required this.goodChoice});
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({required this.questions});

  void addAnswer(Answer asnwer) {
    this.answers.add(asnwer);
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }
}
