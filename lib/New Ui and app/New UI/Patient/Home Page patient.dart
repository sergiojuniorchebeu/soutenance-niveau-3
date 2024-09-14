import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/App%20Services/Auth%20Services.dart';
import 'package:projetsout/App%20Services/Recup%C3%A9ration%20des%20ID.dart';
import '../../../AppWidget.dart';
import 'Historique des commandes.dart';
import 'Notifications patient.dart';
import 'Profile Patient.dart';
import 'Screen Phramacy.dart';

class DashboardPatient extends StatelessWidget {
  const DashboardPatient({super.key});

  @override
  Widget build(BuildContext context) {
    IDRecup idRecup= IDRecup();
    AuthService authService= AuthService();

    return Scaffold(
      appBar: Appwidget.appBar(),
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Appwidget.customGreen,
              ),
              child: FutureBuilder<String?>(
                future: idRecup.getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Appwidget.loadingblanc();
                  } else if (snapshot.hasError) {
                    return const Text('//');
                  } else if (!snapshot.hasData) {
                    return const Text('User name not found');
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: Icon(CupertinoIcons.person, color: Colors.white, size: 60)),
                        const SizedBox(height: 10),
                        Text(snapshot.data!,
                            style: Appwidget.styledetexte(
                                couleur: Colors.white,
                                w: FontWeight.bold,
                                taille: 22)),
                      ],
                    );
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Appwidget.customGreen,
              ),
              title: Text("Profile",
                  style: Appwidget.styledetexte(
                      couleur: Colors.black, w: FontWeight.bold, taille: 18)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePatient()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.local_pharmacy,
                color: Appwidget.customGreen,
              ),
              title: Text('Pharmacies Disponible',
                  style: Appwidget.styledetexte(
                      couleur: Colors.black, w: FontWeight.bold, taille: 18)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavBarPharmacy()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                color: Appwidget.customGreen,
              ),
              title: Text('Historiques Commandes',
                  style: Appwidget.styledetexte(
                      couleur: Colors.black, w: FontWeight.bold, taille: 18)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderHistoryPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Appwidget.customGreen,
              ),
              title: Text("Notifications",
                  style: Appwidget.styledetexte(
                      couleur: Colors.black, w: FontWeight.bold, taille: 18)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPatient()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Appwidget.customGreen,
              ),
              title: Text('Aide',
                  style: Appwidget.styledetexte(
                      couleur: Colors.black, w: FontWeight.bold, taille: 18)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: Text('Déconnexion',
                  style: Appwidget.styledetexte(
                      couleur: Colors.red, w: FontWeight.bold, taille: 18)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      icon: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Confirmation',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent)),
                      content: const Text(
                        'Êtes-vous sûr de vouloir vous déconnecter ?',
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Annuler',
                              style: Appwidget.styledetexte(
                                couleur: Appwidget.customGreen,
                              )),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Déconnexion',
                              style: TextStyle(
                                  fontFamily: "Poppins", color: Colors.red)),
                          onPressed: () {
                            authService.signOutUser(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Rechercher',
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Appwidget.customGreen,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                      const BorderSide(color: Appwidget.customGreen),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 16),
              // Section Pharmacies Proches
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pharmacies Proches',
                      style: Appwidget.styledetexte(
                          taille: 24, w: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        'Plus',
                        style: Appwidget.styledetexte(
                            couleur: Appwidget.customGreen,
                            taille: 16,
                            w: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: Appwidget.customGreen,
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('Rôle', isEqualTo: 'Pharmacie')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<DocumentSnapshot> pharmacies = snapshot.data!.docs;
                    if (pharmacies.length > 5) {
                      pharmacies.shuffle(); // Mélange les pharmacies
                      pharmacies = pharmacies.sublist(0, 4);
                    }

                    return ListView.builder(
                      itemCount: pharmacies.length,
                      itemBuilder: (context, index) {
                        var pharmacie = pharmacies[index];
                        return MedicationTile(
                          name: pharmacie['Nom'] ?? 'Pharmacie sans nom',
                          patient: pharmacie['Ville'] ?? 'Ville inconnue',
                          date: pharmacie['Région'] ?? 'Région inconnue',
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Section Pharmacies De Gardes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pharmacies De Gardes',
                      style: Appwidget.styledetexte(
                          taille: 24, w: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        'Plus',
                        style: Appwidget.styledetexte(
                            couleur: Appwidget.customGreen,
                            taille: 16,
                            w: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: Appwidget.customGreen,
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('enGarde', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<DocumentSnapshot> pharmaciesDeGarde = snapshot.data!.docs;
                    if (pharmaciesDeGarde.length > 5) {
                      pharmaciesDeGarde.shuffle(); // Mélange les pharmacies
                      pharmaciesDeGarde = pharmaciesDeGarde.sublist(0, 5);
                    }

                    return ListView.builder(
                      itemCount: pharmaciesDeGarde.length,
                      itemBuilder: (context, index) {
                        var pharmacie = pharmaciesDeGarde[index];
                        return MedicationTile(
                          name: pharmacie['Nom'] ?? 'Pharmacie sans nom',
                          patient: pharmacie['Ville'] ?? 'Ville inconnue',
                          date: pharmacie['Région'] ?? 'Région inconnue',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientCircle extends StatelessWidget {
  final String name;

  const PatientCircle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Appwidget.customGreen,
            child: Text(name[0],
                style:
                    Appwidget.styledetexte(taille: 26, couleur: Colors.white)),
          ),
          const SizedBox(height: 4),
          Text(name, style: Appwidget.styledetexte(taille: 14)),
        ],
      ),
    );
  }
}

class MedicationTile extends StatelessWidget {
  final String name;
  final String patient;
  final String date;

  const MedicationTile({
    super.key,
    required this.name,
    required this.patient,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style:
                      Appwidget.styledetexte(w: FontWeight.bold, taille: 17)),
              Text(patient,
                  style:
                      Appwidget.styledetexte(couleur: Colors.grey, taille: 15)),
            ],
          ),
          Text(date, style: Appwidget.styledetexte(couleur: Colors.grey)),
        ],
      ),
    );
  }
}
