import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

import 'Edit profile.dart';

class ProfilePatient extends StatefulWidget {
  const ProfilePatient({super.key});

  @override
  _ProfilePatientState createState() => _ProfilePatientState();
}

class _ProfilePatientState extends State<ProfilePatient> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser!.uid).get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  Future<void> _resetPassword() async {
    if (currentUser?.email != null) {
      await _auth.sendPasswordResetEmail(email: currentUser!.email!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lien de réinitialisation du mot de passe envoyé à votre email.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        appBar: Appwidget.appBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _ProfileHeader(userData: userData!),
            const SizedBox(height: 20),
            _ProfileInfoSection(userData: userData!),
            const SizedBox(height: 20),
            _ProfileActions(
              onResetPassword: _resetPassword,
              onEditProfile: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(userData: userData!),
                  ),
                ).then((_) => _loadUserData());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> userData;

  const _ProfileHeader({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Appwidget.customGreen,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userData['Nom'] ?? 'Utilisateur',
            style: Appwidget.styledetexte(
              taille: 22,
              w: FontWeight.bold,
              couleur: Colors.black,
            ),
          ),
          Text(
            userData['Ville'] ?? 'Ville inconnue',
            style: Appwidget.styledetexte(
              taille: 16,
              couleur: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  final Map<String, dynamic> userData;

  const _ProfileInfoSection({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _ProfileInfoTile(
            icon: Icons.email,
            title: 'Email',
            value: userData['Email'] ?? 'Email non défini',
          ),
          _ProfileInfoTile(
            icon: Icons.location_on,
            title: 'Adresse',
            value: userData['Adresse'] ?? 'Adresse non définie',
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Appwidget.customGreen,
      ),
      title: Text(
        title,
        style: Appwidget.styledetexte(
          taille: 16,
          w: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: Appwidget.styledetexte(
          taille: 14,
          couleur: Colors.black87,
        ),
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  final VoidCallback onResetPassword;
  final VoidCallback onEditProfile;

  const _ProfileActions({
    required this.onResetPassword,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onEditProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appwidget.customGreen,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Modifier Profil',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onResetPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Réinitialiser le mot de passe',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
