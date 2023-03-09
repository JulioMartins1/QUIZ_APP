import 'package:flutter/material.dart';

class SendSuccessScreen extends StatelessWidget {
  const SendSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //trocar para retornar o nome do questionário respondido
        title: const Text('Sertaozinho'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Questinário Finalizado!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              child: const Text('Volte para a tela inicial '),
            ),
          ],
        ),
      ),
    );
  }
}
