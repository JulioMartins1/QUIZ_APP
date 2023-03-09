class QuestionModel {
  final String text;
  final List<String> options;
  final String id;
  String answer;

  QuestionModel({
    required this.text,
    required this.options,
    required this.answer,
    required this.id,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      text: map['question'],
      options: List<String>.from(map['options'] ?? []),
      answer: map['answer'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'options': options,
      'answer': answer,
      'id': id,
    };
  }
}
