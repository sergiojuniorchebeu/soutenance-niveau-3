import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Pharmacies/Ajout%20medicament.dart';
import 'Details medicament.dart';

class MedicamentManagementPage extends StatefulWidget {
  const MedicamentManagementPage({super.key});

  @override
  _MedicamentManagementPageState createState() => _MedicamentManagementPageState();
}

class _MedicamentManagementPageState extends State<MedicamentManagementPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getMedicamentStream() {
    String currentUserId = _auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('liste des produits')
        .snapshots();
  }

  void _toggleActivation(String medicamentId, bool currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(currentStatus ? "Désactiver le médicament ?" : "Activer le médicament ?"),
          content: Text(currentStatus
              ? "Voulez-vous vraiment désactiver ce médicament ?"
              : "Voulez-vous vraiment activer ce médicament ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirmer"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .collection('liste des produits')
                    .doc(medicamentId)
                    .update({'isActive': !currentStatus}).then((_) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMedicament(String medicamentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Supprimer le médicament"),
          content: const Text("Êtes-vous sûr de vouloir supprimer ce médicament ? Cette action est irréversible."),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Supprimer"),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .collection('liste des produits')
                    .doc(medicamentId)
                    .delete().then((_) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Gestion des Médicaments',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getMedicamentStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Aucun médicament trouvé.'));
                  }

                  List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      var medicament = documents[index];
                      return ListTile(
                        title: Text(medicament['Nom Commercial'] ?? 'Sans nom'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: medicament['isActive'] ?? true,
                              onChanged: (value) {
                                _toggleActivation(medicament.id, medicament['isActive'] ?? true);
                              },
                              activeColor: Appwidget.customGreen,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteMedicament(medicament.id);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigation vers la page de détails avec les informations du médicament
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicamentDetailsPage(
                                medicamentData: medicament.data() as Map<String, dynamic>,
                              ),
                            ),
                          );
                        },
                        leading: Image.asset('assets/img/boite-a-pilules.png'),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AjouterProduit())),
              icon: const Icon(
                Icons.add,
                size: 24.0, // Taille de l'icône
              ),
              label: const Text(
                'Ajouter un Médicament',
                style: TextStyle(
                  fontSize: 16.0, // Taille du texte
                  fontWeight: FontWeight.bold, // Poids du texte
                  color: Colors.white, // Couleur du texte
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Appwidget.customGreen,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Coins arrondis
                ),
                elevation: 5.0, // Ombre portée
                shadowColor: Colors.black.withOpacity(0.3), // Couleur de l'ombre
              ),
            )
          ],
        ),
      ),
    );
  }
}
