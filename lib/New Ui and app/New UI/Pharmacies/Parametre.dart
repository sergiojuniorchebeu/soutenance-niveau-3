import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class PharmacyProfilePage extends StatefulWidget {
  const PharmacyProfilePage({super.key});

  @override
  _PharmacyProfilePageState createState() => _PharmacyProfilePageState();
}

class _PharmacyProfilePageState extends State<PharmacyProfilePage> {
  String pharmacyName = "Pharmacie Santé Plus";
  String city = "Yaoundé";
  String longitude = "11.5167";
  String latitude = "3.8667";

  void _editField(String fieldName, String currentValue, Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier $fieldName'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: fieldName,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Appwidget.customGreen),
              child: Text('Enregistrer', style: Appwidget.styledetexte(
                couleur: Colors.white, w: FontWeight.bold
              ),),
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
            const CircleAvatar(
              radius: 50,
              backgroundColor: Appwidget.customGreen,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildProfileItem('Nom de la Pharmacie', pharmacyName, (newValue) {
              setState(() {
                pharmacyName = newValue;
              });
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Ville', city, (newValue) {
              setState(() {
                city = newValue;
              });
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Longitude', longitude, (newValue) {
              setState(() {
                longitude = newValue;
              });
            }),
            const SizedBox(height: 16.0),
            _buildProfileItem('Latitude', latitude, (newValue) {
              setState(() {
                latitude = newValue;
              });
            }),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Logique pour supprimer le compte
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Supprimer le compte'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, Function(String) onSave) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label : $value',
          style: const TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Appwidget.customGreen),
          onPressed: () => _editField(label, value, onSave),
        ),
      ],
    );
  }
}
