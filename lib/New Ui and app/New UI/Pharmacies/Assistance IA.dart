import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

import 'Home Page.dart';

class AssistanceAIPage extends StatefulWidget {
  const AssistanceAIPage({super.key});

  @override
  _AssistanceAIPageState createState() => _AssistanceAIPageState();
}

class _AssistanceAIPageState extends State<AssistanceAIPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  void _askQuestion() {
    setState(() {
      // Logique pour générer une réponse IA
      _response = 'Réponse de l\'IA pour: "${_controller.text}"';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Assistance par l\'IA',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16.0),
              const VisitorChart(), // Le graphe des visiteurs
              const SizedBox(height: 16.0),
              TextField(
                maxLines: 3,
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Posez votre question',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed:_askQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appwidget.customGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Envoyer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                _response,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
