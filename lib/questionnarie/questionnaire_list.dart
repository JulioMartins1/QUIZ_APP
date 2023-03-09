import 'package:flutter/material.dart';
import '../models/questionnarie_model.dart';

class QuestionnaireList extends StatelessWidget {
  final List<QuestionnaireItem> questionnaires;
  final Function(QuestionnaireItem) onSelected;

  const QuestionnaireList({
    Key? key,
    required this.questionnaires,
    required this.onSelected,
  }) : super(key: key);

/////////////////////// lista de questionarios /////////////////////////
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questionnaires.length,
      itemBuilder: (context, index) {
        final questionnaire = questionnaires[index];
        return InkWell(
          onTap: () => onSelected(questionnaire),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
////////////////     nome do questionario   ///////////////////////

                  Text(
                    questionnaire.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

////////////////     descricao de questionario   ///////////////////////

                  const SizedBox(height: 8),
                  Text(questionnaire.description),

////////////////     autor   ///////////////////////

                  const SizedBox(height: 8),
                  Text(
                    'Autor: ${questionnaire.author}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

///////// data de criacao do questionario ////////////////

                  const SizedBox(height: 8),
                  Text(
                    'Criado as: ${questionnaire.createdAt}',
                    style: Theme.of(context).textTheme.bodySmall,

//////////////////////////////////////////////////////////
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
