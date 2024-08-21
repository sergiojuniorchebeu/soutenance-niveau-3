import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class MedicamentManagementPage extends StatefulWidget {
  const MedicamentManagementPage({super.key});

  @override
  _MedicamentManagementPageState createState() => _MedicamentManagementPageState();
}

class _MedicamentManagementPageState extends State<MedicamentManagementPage> {
  List<Medicament> medicaments = [
    Medicament('Paracétamol', true),
    Medicament('Ibuprofène', false),
    Medicament('Amoxicilline', true),
    Medicament('Efféralgant', false),
    Medicament('Malacure', false),
    Medicament('Bactrim', true),
    Medicament('MixaGrip', true),
    Medicament('Doliprane', true),
    Medicament('Amoxicilline', true),
  ];

  void toggleActivation(int index) {
    setState(() {
      medicaments[index].isActive = !medicaments[index].isActive;
    });
  }

  void addMedicament() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newMedicamentName = '';
        return AlertDialog(
          title: const Text('Ajouter un Médicament'),
          content: TextField(
            onChanged: (value) {
              newMedicamentName = value;
            },
            decoration: const InputDecoration(hintText: "Nom du Médicament"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () {
                if (newMedicamentName.isNotEmpty) {
                  setState(() {
                    medicaments.add(Medicament(newMedicamentName, true));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void removeMedicament(int index) {
    setState(() {
      medicaments.removeAt(index);
    });
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
              child: ListView.builder(
                itemCount: medicaments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medicaments[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: medicaments[index].isActive,
                          onChanged: (value) => toggleActivation(index),
                          activeColor: Appwidget.customGreen,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeMedicament(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: addMedicament,
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
                foregroundColor: Colors.white, backgroundColor: Appwidget.customGreen,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Espacement interne
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

class Medicament {
  String name;
  bool isActive;

  Medicament(this.name, this.isActive);
}
