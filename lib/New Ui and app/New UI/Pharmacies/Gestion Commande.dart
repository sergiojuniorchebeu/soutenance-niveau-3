import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class CommandeManagementPage extends StatefulWidget {
  const CommandeManagementPage({super.key});

  @override
  _CommandeManagementPageState createState() => _CommandeManagementPageState();
}

class _CommandeManagementPageState extends State<CommandeManagementPage> {
  List<Commande> commandes = [
    Commande('Commande 1', false),
    Commande('Commande 2', true),
    Commande('Commande 3', false),
  ];

  void validateCommande(int index) {
    setState(() {
      commandes[index].isValidated = true;
    });
  }

  void removeCommande(int index) {
    setState(() {
      commandes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Liste des Commandes',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: commandes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(commandes[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!commandes[index].isValidated)
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => validateCommande(index),
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeCommande(index),
                        ),
                      ],
                    ),
                    tileColor: commandes[index].isValidated ? Colors.green.withOpacity(0.1) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Commande {
  String name;
  bool isValidated;

  Commande(this.name, this.isValidated);
}
