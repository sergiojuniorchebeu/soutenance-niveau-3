import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Pharmacies/Gestion%20liste%20produit.dart';

class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  State<AjouterProduit> createState() => _AjouterProduitState();
}

class _AjouterProduitState extends State<AjouterProduit> {
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _classe = TextEditingController();
  final TextEditingController _prix = TextEditingController();
  final TextEditingController _laboratoire = TextEditingController();
  final TextEditingController _Conditionement = TextEditingController();
  final TextEditingController _forme = TextEditingController();
  final TextEditingController _principe = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "Ajouter un nouveau produit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Appwidget.customGreen,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Remplissez les détails ci-dessous pour enregistrer un nouveau produit.",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/img/medicament (1).png'),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: _nom,
                        label: 'Nom Commercial',
                        icon: Icons.medical_services_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _principe,
                        label: 'Principes Actifs',
                        icon: Icons.science_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _prix,
                        label: 'Prix Privée',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _classe,
                        label: 'Classe Médicamenteuse',
                        icon: Icons.category_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _forme,
                        label: 'Forme et Dosage',
                        icon: Icons.description_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _laboratoire,
                        label: 'Laboratoire',
                        icon: Icons.business_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _Conditionement,
                        label: 'Conditionnement',
                        icon: Icons.local_shipping_outlined,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            _handleSubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appwidget.customGreen,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                          ),
                          child: isLoading
                              ? Appwidget.loading()
                              : Text(
                            'Enregistrer',
                            style: Appwidget.styledetexte(taille: 18, couleur: Colors.white, w: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour créer des champs de texte stylisés
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Appwidget.customGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  // Fonction pour gérer la soumission
  void _handleSubmit() {
    if (_nom.text.isEmpty || _prix.text.isEmpty || _Conditionement.text.isEmpty || _forme.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuillez remplir tous les champs obligatoires."),
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('liste des produits')
        .add({
      'Nom Commercial': _nom.text,
      'Principes Actifs': _principe.text,
      'Prix privée': _prix.text,
      'Classe médicamenteuse': _classe.text,
      'Forme et Dosage': _forme.text,
      'Laboratoire': _laboratoire.text,
      'Conditionement': _Conditionement.text,
      'isActive': true,
    }).then((value) {
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


  // Dialogues pour succès et erreur
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle_rounded, color: Colors.green),
          title: const Text(
            "Succès",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          content: const Text("Informations Enregistrées"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicamentManagementPage()));
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error, color: Colors.red),
          title: const Text("Erreur", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          content: Text("Erreur lors de l'ajout du produit : $error"),
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
