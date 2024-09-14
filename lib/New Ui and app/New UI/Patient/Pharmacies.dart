import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'Details Pharmacies.dart';


class ListePharmacies extends StatelessWidget {
  const ListePharmacies({super.key});

  Stream<QuerySnapshot> getPharmaciesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('Rôle', isEqualTo: 'Pharmacie')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: getPharmaciesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Appwidget.loading()
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune pharmacie trouvée.'));
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var pharmacy = documents[index];


              String pharmacyName = pharmacy['Nom'] ?? 'Sans nom';
              String city = pharmacy['Ville'] ?? 'Ville inconnue';
              String region = pharmacy['Région'] ?? 'Région inconnue';

              return ListTile(
                leading: Image.asset("assets/img/pharmacie (3).png"),
                title: Text(
                  pharmacyName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  '$city, $region',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black54,
                  ),
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PharmacyDetailsPage(pharmacyData: pharmacy.data() as Map<String, dynamic>),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
