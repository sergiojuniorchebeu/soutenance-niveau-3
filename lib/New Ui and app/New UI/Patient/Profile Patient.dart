import 'package:flutter/material.dart';
import '../../../AppWidget.dart';

class ProfilePatient extends StatelessWidget {
  const ProfilePatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _ProfileHeader(),
            const SizedBox(height: 20),
            _ProfileInfoSection(),
            const SizedBox(height: 20),
            _ProfileActions(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
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
            'Sergio Junior Chebeu',
            style: Appwidget.styledetexte(
              taille: 22,
              w: FontWeight.bold,
              couleur: Colors.black,
            ),
          ),
          Text(
            'Yaounde',
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _ProfileInfoTile(
            icon: Icons.email,
            title: 'Email',
            value: 'sergio@example.com',
          ),
          _ProfileInfoTile(
            icon: Icons.phone,
            title: 'Téléphone',
            value: '+237 123 456 789',
          ),
          _ProfileInfoTile(
            icon: Icons.location_on,
            title: 'Adresse',
            value: '123 Rue de la Pharmacie, Yaounde',
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Logic to edit profile
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Appwidget.customGreen,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Modifier Profil',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
