import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class AjoutAnnonces extends StatefulWidget {
  const AjoutAnnonces({super.key});

  @override
  State<AjoutAnnonces> createState() => _AjoutAnnoncesState();
}

class _AjoutAnnoncesState extends State<AjoutAnnonces> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _ajouterAnnonce() async {
    if (_formKey.currentState?.validate() ?? false) {
      String titre = _titreController.text;
      String description = _descriptionController.text;

      try {
        // Accédez à la collection "annonces" dans Firestore
        CollectionReference annonces = FirebaseFirestore.instance.collection('annonces');

        // Ajoutez un document à la collection
        await annonces.add({
          'titre': titre,
          'description': description,
          'date': Timestamp.now(), // Optionnel : ajouter une date
        });

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Annonce ajoutée : $titre')),
        );

        // Effacer les champs après l'ajout
        _titreController.clear();
        _descriptionController.clear();
      } catch (e) {
        // Gérer les erreurs
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ajouter une annonce',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _titreController,
                decoration: InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _ajouterAnnonce,
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

