import 'package:quizapp/models/question_model.dart';

class QuestionnaireItem {
  final String name;
  final String description;
  final String author;
  final DateTime createdAt;
  final List<QuestionModel> questions;

  QuestionnaireItem({
    required this.name,
    required this.description,
    required this.author,
    required this.createdAt,
    required this.questions,
  });

  factory QuestionnaireItem.fromMap(Map<String, dynamic> map) {
    return QuestionnaireItem(
      name: map['name'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdAt: DateTime.now(),
      questions: List<QuestionModel>.from(
        (map['questions'] as List<dynamic>).map<dynamic>(
          (x) => QuestionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
