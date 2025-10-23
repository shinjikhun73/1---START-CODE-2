import 'package:test/test.dart';

import '../lib/domain/quiz.dart';

main() {
  // Create 2 questions and the quiz
  print("       --- Welcome to the QUIZ ---");
  Question q1 =
      Question(title: "2+2", choices: ["1", "2", "4"], goodChoice: "4");

  Question q2 =
      Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5");

  Question q3 = Question(
      title: "Capital city of Cambodia?",
      choices: ["Prey Veng", "Phnom Penh", "Siem Reap"],
      goodChoice: "Phnom Penh");

  Question q4 =
      Question(title: "5+2*3-7", choices: ["4", "5", "3"], goodChoice: "4");
  Quiz quiz = Quiz(questions: [q1, q2]);

  

  test('All answers are good (100%)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "4");
    Answer a2 = Answer(question: q2, answerChoice: "5");
    Answer a3 = Answer(question: q3, answerChoice: "Phnom Penh");
    Answer a4 = Answer(question: q4, answerChoice: "4");

    quiz.answers = [a1, a2, a3, a4];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(200));
  });
}
