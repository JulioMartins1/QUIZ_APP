import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/questionnarie/questionnaire_list.dart';
import 'package:quizapp/questionnarie/questionnarie_screen.dart';
import 'models/questionnarie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  List<QuestionnaireItem> questionnaires = [];

/////////////////////  Lista de Questionarios do firebase /////////////////////////
  @override
  void initState() {
    super.initState();
    fetchQuestionnaires();
  }

  void fetchQuestionnaires() async {
    final questionnairesRef =
        FirebaseFirestore.instance.collection('questionnaires');
    final snapshot = await questionnairesRef.get();
    final docs = snapshot.docs;
    final newQuestionnaires = docs.map((doc) {
      final data = doc.data();
      //return QuestionnaireItem(
      // name: data['name'],
      //description: data['description'],
      //author: data['author'],
      //createdAt: data['createdAt'].toDate(),
      //questions: data['questions']
      return QuestionnaireItem.fromMap(data);
    }).toList();
    setState(() {
      questionnaires = newQuestionnaires;
    });
  }

//////////////////  Barra superior /////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionários'),
      ),
      body: Column(
        children: [
          Expanded(
            child: QuestionnaireList(
              questionnaires: questionnaires,
              onSelected: (questionnaires) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionnaireScreen(
                      questionnaireItem: questionnaires,
                    ),
                  ),
                );
              },
            ),
          ),

/////////////////    Usuario logado   //////////////////
          const SizedBox(height: 16.0),
          FutureBuilder<User?>(
            future: Future.value(FirebaseAuth.instance.currentUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("signed in as: ${snapshot.data?.email}"),

//////////////////        Botao de sair        //////////////

                    const SizedBox(height: 16.0),
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      color: const Color.fromARGB(255, 45, 122, 189),
                      child: const Text('Sair'),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
