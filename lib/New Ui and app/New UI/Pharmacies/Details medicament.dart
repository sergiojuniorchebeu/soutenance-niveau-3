import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class MedicamentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> medicamentData;

  const MedicamentDetailsPage({super.key, required this.medicamentData});

  @override
  _MedicamentDetailsPageState createState() => _MedicamentDetailsPageState();
}

class _MedicamentDetailsPageState extends State<MedicamentDetailsPage> {
  late TextEditingController _nomController;
  late TextEditingController _prixController;
  late TextEditingController _classeController;
  late TextEditingController _laboratoireController;
  late TextEditingController _conditionnementController;
  late TextEditingController _formeController;
  late TextEditingController _principeController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialisation des TextEditingControllers avec les données actuelles
    _nomController = TextEditingController(text: widget.medicamentData['Nom Commercial']);
    _prixController = TextEditingController(text: widget.medicamentData['Prix privée']);
    _classeController = TextEditingController(text: widget.medicamentData['Classe médicamenteuse']);
    _laboratoireController = TextEditingController(text: widget.medicamentData['Laboratoire']);
    _conditionnementController = TextEditingController(text: widget.medicamentData['Conditionement']);
    _formeController = TextEditingController(text: widget.medicamentData['Forme et Dosage']);
    _principeController = TextEditingController(text: widget.medicamentData['Principes Actifs']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Détails du Médicament",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Appwidget.customGreen,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(controller: _nomController, label: 'Nom Commercial'),
            const SizedBox(height: 16),
            _buildTextField(controller: _principeController, label: 'Principes Actifs'),
            const SizedBox(height: 16),
            _buildTextField(controller: _prixController, label: 'Prix Privée', keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildTextField(controller: _classeController, label: 'Classe Médicamenteuse'),
            const SizedBox(height: 16),
            _buildTextField(controller: _formeController, label: 'Forme et Dosage'),
            const SizedBox(height: 16),
            _buildTextField(controller: _laboratoireController, label: 'Laboratoire'),
            const SizedBox(height: 16),
            _buildTextField(controller: _conditionnementController, label: 'Conditionnement'),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                  _handleUpdate();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appwidget.customGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: isLoading
                    ? Appwidget.loading()
                    : const Text(
                  'Enregistrer les modifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }


  void _handleUpdate() {
    setState(() {
      isLoading = true;
    });

    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    String medicamentId = widget.medicamentData['id'];


    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('liste des produits')
        .doc(medicamentId)
        .update({
      'Nom Commercial': _nomController.text,
      'Principes Actifs': _principeController.text,
      'Prix privée': _prixController.text,
      'Classe médicamenteuse': _classeController.text,
      'Forme et Dosage': _formeController.text,
      'Laboratoire': _laboratoireController.text,
      'Conditionement': _conditionnementController.text,
    }).then((_) {
      setState(() {
        isLoading = false;
      });
      _showSuccessDialog();
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(error);
    });
  }

  // Dialogue de succès
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle_rounded, color: Colors.green),
          title: const Text("Succès", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          content: const Text("Les modifications ont été enregistrées."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Dialogue d'erreur
  void _showErrorDialog(error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error, color: Colors.red),
          title: const Text("Erreur", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          content: Text("Erreur lors de la mise à jour : $error"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
