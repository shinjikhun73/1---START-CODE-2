import 'dart:io';
import 'package:my_first_project/data/quiz_file_provider.dart';
import 'package:my_first_project/domain/quiz.dart';
import 'package:my_first_project/ui/quiz_console.dart';

void main() {
  final repo = QuizRepository('questions.json');
  final quiz = repo.read();

  final List<Player> players = [];

  print('Welcome to the Quiz ---');

  while (true) {
    stdout.write('\nYour name: ');
    final name = stdin.readLineSync();
    if (name == null || name.isEmpty) break;

    final player = Player(name: name);
    final console = QuizConsole(quiz: quiz, player: player);
    console.startQuiz();

    players.removeWhere((p) => p.name == name);
    players.add(player);

    print('\nScores so far:');
    for (var p in players) {
      final score = p.getScoreInPoints(quiz.questions);
      final percent = p.getScoreInPercentage(quiz.questions);
      print('Player: ${p.name}  Score: $score (${percent.toStringAsFixed(1)}%)');
    }
  }

  print('\nQuiz Finished');
}
