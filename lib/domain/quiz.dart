import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    String? id,
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.points,
  }) : id = id ?? _uuid.v4();

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      points: json['points'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'choices': choices,
    'goodChoice': goodChoice,
    'points': points,
  };
}

class Answer {
  final String questionId;
  final String answerChoice;

  Answer({required this.questionId, required this.answerChoice});

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'answerChoice': answerChoice,
  };

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionId: json['questionId'],
      answerChoice: json['answerChoice'],
    );
  }
}

class Player {
  final String name;
  final List<Answer> answers = [];

  Player({required this.name});

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  int getScoreInPoints(List<Question> questions) {
    int score = 0;
    for (var answer in answers) {
      final question = questions.firstWhere(
        (q) => q.id == answer.questionId,
        orElse: () => Question(
          id: '',
          title: '',
          choices: [],
          goodChoice: '',
          points: 0,
        ),
      );
      if (answer.answerChoice == question.goodChoice) {
        score += question.points;
      }
    }
    return score;
  }

  double getScoreInPercentage(List<Question> questions) {
    final totalPoints = questions.fold(0, (sum, q) => sum + q.points);
    final earnedPoints = getScoreInPoints(questions);
    return totalPoints == 0 ? 0 : (earnedPoints / totalPoints) * 100;
  }

  Answer? getAnswerById(String questionId) {
    try {
      return answers.firstWhere((a) => a.questionId == questionId);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'answers': answers.map((a) => a.toJson()).toList(),
  };

  factory Player.fromJson(Map<String, dynamic> json) {
    final answersJson = json['answers'] as List;
    return Player(name: json['name'])
      ..answers.addAll(answersJson.map((a) => Answer.fromJson(a)));
  }
}

class Quiz {
  final String id;
  final List<Question> questions;

  Quiz({String? id, required this.questions}) : id = id ?? _uuid.v4();

  Question? getQuestionById(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'questions': questions.map((q) => q.toJson()).toList(),
  };

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final questionsJson = json['questions'] as List;
    final questions = questionsJson.map((q) => Question.fromJson(q)).toList();
    return Quiz(id: json['id'], questions: questions);
  }
}
class Submission {
  final String id;
  final String playerName;
  final String quizId;
  final List<Answer> answers;

  Submission({
    String? id,
    required this.playerName,
    required this.quizId,
    required this.answers,
  }) : id = id ?? _uuid.v4();

  int getScoreInPoints(List<Question> questions) {
    int score = 0;
    for (var answer in answers) {
      final question = questions.firstWhere(
        (q) => q.id == answer.questionId,
        orElse: () => Question(
          id: '',
          title: '',
          choices: [],
          goodChoice: '',
          points: 0,
        ),
      );
      if (answer.answerChoice == question.goodChoice) {
        score += question.points;
      }
    }
    return score;
  }

  double getScoreInPercentage(List<Question> questions) {
    final totalPoints = questions.fold(0, (sum, q) => sum + q.points);
    final earnedPoints = getScoreInPoints(questions);
    return totalPoints == 0 ? 0 : (earnedPoints / totalPoints) * 100;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'playerName': playerName,
    'quizId': quizId,
    'answers': answers.map((a) => a.toJson()).toList(),
  };

  factory Submission.fromJson(Map<String, dynamic> json) {
    final answersJson = json['answers'] as List;
    return Submission(
      id: json['id'],
      playerName: json['playerName'],
      quizId: json['quizId'],
      answers: answersJson.map((a) => Answer.fromJson(a)).toList(),
    );
  }
}

