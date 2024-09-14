import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'Details Pharmacies.dart';


class PharmaciesDeGardePage extends StatelessWidget {
  const PharmaciesDeGardePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('enGarde', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune pharmacie de garde actuellement.'));
          }

          List<DocumentSnapshot> pharmacies = snapshot.data!.docs;

          return ListView.builder(
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              var pharmacie = pharmacies[index];
              return ListTile(
                title: Text(pharmacie['Nom'] ?? 'Pharmacie sans nom'),
                subtitle: Text('${pharmacie['Ville']}, ${pharmacie['Région']}'),
                leading: Image.asset("assets/img/pharmacie (2).png"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PharmacyDetailsPage(
                        pharmacyData: pharmacie.data() as Map<String, dynamic>,
                      ),
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
