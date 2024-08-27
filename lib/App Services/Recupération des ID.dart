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
}
