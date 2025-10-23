import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz read() {
    final file = File(filePath);
    final contents = file.readAsStringSync();
    final Map<String, dynamic> json = jsonDecode(contents);
    return Quiz.fromJson(json);
  }

  void write(Quiz quiz) {
    final file = File(filePath);
    final json = jsonEncode(quiz.toJson());
    file.writeAsStringSync(json);
  }
}
