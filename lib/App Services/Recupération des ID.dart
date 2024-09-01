import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IDRecup {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<String?> getUserName() async {
    String? userId = getCurrentUserId();
    if (userId != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userId).get();
      return userDoc['Nom'];
    }
    return null;
  }

  Future<String?> getAdminName() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          if (userDoc['role'] == 'admin') {
            return userDoc['name'];
          }
        }
      } catch (e) {
        print('Erreur lors de la récupération des informations de l\'utilisateur: $e');
      }
    }

    return null;
  }
}
