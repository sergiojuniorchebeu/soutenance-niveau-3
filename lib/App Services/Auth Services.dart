import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import '../New Ui and app/New UI/Patient/Screen Manage Patient.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Création du compte en cours...')),
      );

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'Nom': name,
          'Email': email,
          'Rôle': 'Patient',
          'Date de création': FieldValue.serverTimestamp(),
          'Statut': 'actif',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compte créé avec succès!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPatient()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  //Connexion
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion en cours...')),
      );
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          String role = userDoc.get('Rôle');
          if (role == 'Patient') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.grey[300],
                  content: Text('Connexion réussie!', style: Appwidget.styledetexte(
                    couleur: Appwidget.customGreen, taille: 14, w: FontWeight.bold
                  ),)),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavigationPatient()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erreur: Vous n\'êtes pas un patient.')),
            );
            await _auth.signOut();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur: Utilisateur non trouvé.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  bool isPasswordVisible = false;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
}
