import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/HomePage.dart';

class UserManagementController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to list all users except the current admin
  Future<List<Map<String, dynamic>>> listUsersExcludingAdmin(String currentAdminEmail) async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();

    List<QueryDocumentSnapshot> users = querySnapshot.docs.where((doc) {
      return doc['Email'] != currentAdminEmail;
    }).toList();

    List<Map<String, dynamic>> userData = users.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    return userData;
  }

  // Function to list users with role "Patient"
  Future<List<Map<String, dynamic>>> listPatients() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('Rôle', isEqualTo: 'Patient')
        .get();

    List<Map<String, dynamic>> patientData = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    return patientData;
  }

  // Function to list users with role "Pharmacies"
  Future<List<Map<String, dynamic>>> listPharmacies() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('Rôle', isEqualTo: 'Pharmacie')
        .get();

    List<Map<String, dynamic>> pharmacyData = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    return pharmacyData;
  }

  // Function to delete a user account
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // Function to deactivate a user account
  Future<void> deactivateUser(String userId) async {
    await _firestore.collection('users').doc(userId).update({'Statut': 'inactif'});
  }

  // Function to register a new pharmacy
  Future<void> registerPharmacyWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String latitude,
    required String longitude,
    required String region,
    required String city,
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
          'Téléphone': phone,
          'Latitude': latitude,
          'Longitude': longitude,
          'Région': region,
          'Ville': city,
          'Rôle': 'Pharmacie',
          'Date de création': FieldValue.serverTimestamp(),
          'Statut': 'actif',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Compte créé avec succès!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboard()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur, veuillez réessayer')),
      );
    }
  }
}
