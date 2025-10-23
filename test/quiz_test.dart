import 'package:test/test.dart';
import 'package:my_first_project/domain/quiz.dart';

void main() {
  test('Player scoring with ID references', () {
    final q1 = Question(
      title: 'Capital of France?',
      choices: ['Paris', 'London', 'Rome'],
      goodChoice: 'Paris',
      points: 10,
    );
    final q2 = Question(
      title: '2 + 2 = ?',
      choices: ['2', '4', '5'],
      goodChoice: '4',
      points: 50,
    );

    final quiz = Quiz(questions: [q1, q2]);

    final player = Player(name: 'Shinji');
    player.addAnswer(Answer(questionId: q1.id, answerChoice: 'Paris'));
    player.addAnswer(Answer(questionId: q2.id, answerChoice: '5')); // wrong

    expect(player.getScoreInPoints(quiz.questions), equals(10));
    expect(player.getScoreInPercentage(quiz.questions), equals(10 / 60 * 100));
  });
}
