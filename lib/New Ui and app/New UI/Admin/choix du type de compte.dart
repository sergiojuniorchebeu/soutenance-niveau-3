import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/Ajout%20Pharmacies.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/ajout%20admin.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/ajout%20utilisateur.dart';


class ChoixTypeCompte extends StatelessWidget {
  const ChoixTypeCompte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 216.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PharmacyForm()),
                              );
                            },
                            child: _buildCard(
                              imageUrl: 'assets/img/pharmacie (3).png',
                              title: 'Pharmacies',
                              description: 'Cliquez pour ajouter une pharmacie',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddPatient()),
                              );
                            },
                            child: _buildCard(
                              imageUrl: 'assets/img/en-bonne-sante.png',
                              title: 'Utilisateur',
                              description: 'Cliquez pour ajouter un Utilisateur',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddAdmin()),
                              );
                            },
                            child: _buildCard(
                              imageUrl: 'assets/img/admin.png',
                              title: 'Administrateur',
                              description: 'Cliquez pour ajouter un Administrateur',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String imageUrl, required String title, required String description}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
