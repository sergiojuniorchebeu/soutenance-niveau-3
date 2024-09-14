import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class GardePharmaciePage extends StatefulWidget {
  const GardePharmaciePage({super.key});

  @override
  _GardePharmaciePageState createState() => _GardePharmaciePageState();
}

class _GardePharmaciePageState extends State<GardePharmaciePage> {
  bool enGardeStatus = false; // Variable pour suivre le statut actuel
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Récupérer le statut actuel de "garde" au chargement de la page
    _loadGardeStatus();
  }

  // Fonction pour charger le statut actuel de la pharmacie
  void _loadGardeStatus() async {
    String currentUserId = _auth.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();

    setState(() {
      enGardeStatus = snapshot['enGarde'] ?? false;
    });
  }

  // Fonction pour basculer le statut de garde
  void toggleGardeStatus(bool status) {
    String currentUserId = _auth.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
      'enGarde': status,
    });
    setState(() {
      enGardeStatus = status; // Mise à jour immédiate de l'UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Signaler si vous êtes de garde",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Appwidget.customGreen,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Êtes-vous de garde ?'),
              trailing: Switch(
                value: enGardeStatus,
                onChanged: (value) {
                  // Afficher une boîte de dialogue de confirmation
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: Text(value
                            ? 'Voulez-vous signaler que vous êtes de garde ?'
                            : 'Voulez-vous signaler que vous n\'êtes plus de garde ?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () {
                              toggleGardeStatus(value); // Mise à jour du statut
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirmer'),
                          ),
                        ],
                      );
                    },
                  );
                },
                activeColor: Appwidget.customGreen,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Text(
              "Pharmacies de Garde",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Appwidget.customGreen,
              ),
            ),
            const SizedBox(height: 16),
            // Affichage des pharmacies de garde pour les utilisateurs
            Expanded(child: PharmaciesDeGardeList()),
          ],
        ),
      ),
    );
  }
}

class PharmaciesDeGardeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('enGarde', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
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
              leading: const Icon(Icons.local_pharmacy, color: Colors.green),
            );
          },
        );
      },
    );
  }
}
