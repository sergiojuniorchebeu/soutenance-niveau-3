import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/HomePage.dart';

class UserManagementController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Function to verify admin password
  Future<bool> verifyAdminPassword(String password) async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: password,
        );
        await currentUser.reauthenticateWithCredential(credential);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  // Function to delete a user account
  Future<void> deleteUser(String userId, String adminPassword) async {
    if (await verifyAdminPassword(adminPassword)) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        String email = userDoc['Email'];
        if (email != 'sergiojuniorchebeu@gmail.com') {
          await _firestore.collection('users').doc(userId).delete();
        } else {
          throw Exception('This user cannot be deleted.');
        }
      }
    } else {
      throw Exception('Incorrect password.');
    }
  }

  // Function to deactivate/activate a user account
  Future<void> toggleUserStatus(String userId, String newStatus) async {
    await _firestore.collection('users').doc(userId).update({'Statut': newStatus});
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

  // Function to register an administrator
  Future<void> registerAdminWithEmailAndPassword({
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
          'Rôle': 'Admin',
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

  // Function to register a new user
  Future<void> registerUserWithEmailAndPassword({
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
