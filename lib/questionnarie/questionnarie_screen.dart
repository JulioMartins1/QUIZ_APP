// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/models/question_model.dart';
import 'package:quizapp/models/questionnarie_model.dart';
import 'package:quizapp/questionnarie/questionnarie_end_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  final QuestionnaireItem questionnaireItem;

  const QuestionnaireScreen({Key? key, required this.questionnaireItem})
      : super(key: key);

  @override
  State<QuestionnaireScreen> createState() {
    return _QuestionnaireScreenState();
  }
}

////////////////A classe QuestionnaireScreen é responsável por exibir a lista de perguntas
///             e gerenciar as respostas do usuário e a navegação entre as perguntas.                ////////////////////
class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final TextEditingController _textController = TextEditingController(); // add
  int _currentIndex = 0;
//////////////// Voids ////////////////////////
  ///
  ///
  ///
  void _submitAnswer(String answer) async {
    try {
      final currentQuestion = widget.questionnaireItem.questions[_currentIndex];
      currentQuestion.answer = answer;
      if (_currentIndex == widget.questionnaireItem.questions.length - 1) {
        final docRef = FirebaseFirestore.instance
            .collection('questionnaires')
            .doc('KSz7BKt5Fyc1ZZ1Ja5Yv');
        final Map<String, String> answers = {};
        for (var question in widget.questionnaireItem.questions) {
          answers[question.id] = question.answer;
        }
        await docRef.update({'answers': answers});
        // Clear the text form field after submitting the answer
        currentQuestion.answer = '';
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SendSuccessScreen()),
        );
      } else {
        _nextQuestion();
      }
    } catch (e) {
      print('Error updating answer: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred while updating the answer.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  late QuestionModel questionModel;
  @override
  void initState() {
    questionModel = widget.questionnaireItem.questions[_currentIndex];
    super.initState();
  }

////////////////  Void proxima pergunta   ////////////////////////
  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      questionModel = widget.questionnaireItem.questions[_currentIndex];
      _textController.text = ''; // add this line
    });
  }

  void _previewQuestion() {
    setState(() {
      _currentIndex--;
      questionModel = widget.questionnaireItem.questions[_currentIndex];
    });
  }

  Widget _buildNextButton(bool isLastQuestion) {
    if (isLastQuestion) {
      return ElevatedButton(
        onPressed: () {
          _submitAnswer(questionModel.answer);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SendSuccessScreen()),
          );
        },
        child: const Text('Enviar'),
      );
    } else {
      return ElevatedButton(
        onPressed: _nextQuestion,
        child: const Text('Próxima'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
//////////////////   Barra superior  /////////////////////////

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),

//////////////////  Texto  /////////////////////////

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Por favor responda as seguintes questões:',
              style: TextStyle(fontSize: 18.0),
            ),

//////////////////  Label da Questão /////////////////////////

            const SizedBox(height: 16.0),
            Text(
              'Questão ${_currentIndex + 1} : ${questionModel.text}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            if (questionModel.options.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

//////////////////  alternativas  /////////////////////////

                children: questionModel.options
                    .map(
                      (option) => RadioListTile(
                          title: Text(option),
                          value: option,
                          groupValue: questionModel.answer,
                          activeColor:
                              Colors.blue, // set the active color to green
                          onChanged: (value) {
                            setState(() {
                              questionModel.answer = (value!);
                            });
                          }),
                    )
                    .toList(),
              ),
            if (questionModel.options.isEmpty)

//////////////////  Campo de Respostas   /////////////////////////

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Digite sua resposta aqui',
                ),
                onChanged: (value) {
                  questionModel.answer = value;
                },
                controller: _textController, // add this line
              ),

////////////// Botao para voltar a pergunta   ////////////////

            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex != 0)
                  ElevatedButton(
                    onPressed: _previewQuestion,
                    child: const Text('Anterior'),
                  ),
                _buildNextButton(_currentIndex ==
                    widget.questionnaireItem.questions.length - 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
