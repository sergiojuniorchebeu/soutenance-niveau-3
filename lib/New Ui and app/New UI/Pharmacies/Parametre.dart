import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class PharmacyProfilePage extends StatefulWidget {
  const PharmacyProfilePage({super.key});

  @override
  _PharmacyProfilePageState createState() => _PharmacyProfilePageState();
}

class _PharmacyProfilePageState extends State<PharmacyProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String pharmacyName = '';
  String city = '';
  String longitude = '';
  String latitude = '';
  String email = '';
  String phoneNumber = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Fonction pour charger les données de profil depuis Firebase
  void _loadProfileData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnapshot =
      await _firestore.collection('users').doc(currentUser.uid).get();

      setState(() {
        pharmacyName = userSnapshot['Nom'] ?? 'Sans nom';
        city = userSnapshot['Ville'] ?? 'Sans ville';
        longitude = userSnapshot['Longitude'] ?? '0.0';
        latitude = userSnapshot['Latitude'] ?? '0.0';
        email = currentUser.email ?? 'Email non disponible';
        phoneNumber = userSnapshot['Téléphone'] ?? 'Téléphone non disponible';
        isLoading = false;
      });
    }
  }

  // Fonction pour mettre à jour les données dans Firebase
  void _updateField(String field, String newValue) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser.uid).update({field: newValue});
      _loadProfileData();
    }
  }

  // Fonction pour afficher une boîte de dialogue pour l'édition
  void _editField(String fieldName, String currentValue, Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier $fieldName'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: fieldName,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Appwidget.customGreen),
              child: Text(
                'Enregistrer',
                style: Appwidget.styledetexte(couleur: Colors.white, w: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour réinitialiser le mot de passe
  void _resetPassword() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null && email.isNotEmpty) {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Un e-mail de réinitialisation a été envoyé à votre adresse.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: isLoading
          ? Center(child: Appwidget.loading())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: Appwidget.customGreen,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildProfileItem('Nom de la Pharmacie', pharmacyName, (newValue) {
              _updateField('nom', newValue);
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Ville', city, (newValue) {
              _updateField('ville', newValue);
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Longitude', longitude, (newValue) {
              _updateField('longitude', newValue);
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Latitude', latitude, (newValue) {
              _updateField('latitude', newValue);
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Email', email, (_) {}),
            const SizedBox(height: 16.0),
            _buildProfileItem('Téléphone', phoneNumber, (newValue) {
              _updateField('telephone', newValue);
            }),
            const SizedBox(height: 30.0),
            ElevatedButton.icon(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Appwidget.customGreen, padding: const EdgeInsets.all(12)),
              icon: const Icon(Icons.lock_reset, color: Colors.white),
              label: const Text(
                'Réinitialiser le mot de passe',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Logique pour supprimer le compte
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Supprimer le compte'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher un élément du profil
  Widget _buildProfileItem(String label, String value, Function(String) onSave) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$label : $value',
            style: const TextStyle(fontSize: 18.0, color: Colors.black87),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Appwidget.customGreen),
          onPressed: () => _editField(label, value, onSave),
        ),
      ],
    );
  }
}
