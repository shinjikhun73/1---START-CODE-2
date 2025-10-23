import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  final Quiz quiz;
  final Player player;

  QuizConsole({required this.quiz, required this.player});

  void startQuiz() {
    for (var question in quiz.questions) {
      print('\n${question.title} - (${question.points} points)');
      for (var i = 0; i < question.choices.length; i++) {
        print('${i + 1}. ${question.choices[i]}');
      }

      final input = stdin.readLineSync();
      final index = int.tryParse(input ?? '') ?? -1;
      if (index >= 1 && index <= question.choices.length) {
        player.addAnswer(Answer(
          questionId: question.id,
          answerChoice: question.choices[index - 1],
        ));
      } else {
        print('Invalid choice. Skipping...');
      }
    }

    final score = player.getScoreInPoints(quiz.questions);
    final percent = player.getScoreInPercentage(quiz.questions);
    print('\n${player.name}, your score in percentage: ${percent.toStringAsFixed(1)} %');
    print('${player.name}, your score in points: $score');
  }
}

