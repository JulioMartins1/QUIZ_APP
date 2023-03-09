/////////A classe QuestionnaireResponse representa a resposta completa do questionário e contém o ID do questionário,
///o ID da resposta, e uma lista de respostas às perguntas do questionário (classe QuestionResponse).
///O construtor dessa classe recebe essas informações e uma lista vazia de respostas às perguntas (que é preenchida posteriormente).

class QuestionnaireResponse {
  final String id;
  final String questionnaireId;
  final List<QuestionResponse> questionResponses;

  QuestionnaireResponse({
    required this.id,
    required this.questionnaireId,
    required this.questionResponses,
    required List answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionnaireId': questionnaireId,
      'questionResponses': questionResponses.map((e) => e.toMap()).toList(),
    };
  }

  factory QuestionnaireResponse.fromMap(Map<String, dynamic> map) {
    return QuestionnaireResponse(
      id: map['id'],
      questionnaireId: map['questionnaireId'],
      questionResponses: List<QuestionResponse>.from(
          map['questionResponses'].map((x) => QuestionResponse.fromMap(x))),
      answer: [],
    );
  }
}

/////A classe QuestionResponse representa uma resposta a
///uma única pergunta do questionário e contém o ID da pergunta e a resposta em si.
/// O construtor dessa classe recebe essas informações.

class QuestionResponse {
  final String questionId;
  final String response;

  QuestionResponse({
    required this.questionId,
    required this.response,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'response': response,
    };
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
      questionId: map['questionId'],
      response: map['response'],
    );
  }
}

////a classe Answer representa uma resposta específica a uma pergunta e contém o ID da pergunta,
/// o texto da pergunta e o valor da resposta.
///O construtor dessa classe recebe essas informações e uma string vazia (que é preenchida posteriormente).

class Answer {
  final String questionId;
  final String text;
  final dynamic value;

  Answer({
    required this.questionId,
    required this.text,
    required this.value,
    required String answer,
  });
}
