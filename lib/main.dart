 
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {

  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris"),
    Question(
        title: "2 + 2 = ?", 
        choices: ["2", "4", "5"], 
        goodChoice: "4"),
    Question(
      title: "Capital city of Cambodia?",
      choices: ["Prey Veng", "Phnom Penh", "Siem Reap"],
      goodChoice: "Phnom Penh"),
    Question(title: "5+2*3-7", choices: ["4", "5", "3"], goodChoice: "4")

  ];
  


  Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();
}
