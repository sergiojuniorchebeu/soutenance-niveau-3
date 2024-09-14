import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final Map<String, dynamic> pharmacyData;

  const PharmacyDetailsPage({super.key, required this.pharmacyData});

  @override
  Widget build(BuildContext context) {
    String pharmacyName = pharmacyData['Nom'] ?? 'Sans nom';
    String city = pharmacyData['Ville'] ?? 'Ville inconnue';
    String region = pharmacyData['Région'] ?? 'Région inconnue';
    String phoneNumber = pharmacyData['Téléphone'] ?? 'Numéro inconnu';
    String latitude = pharmacyData['Latitude'] ?? '0.0';
    String longitude = pharmacyData['Longitude'] ?? '0.0';

    return Scaffold(
      appBar: Appwidget.appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                pharmacyName,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            Center(
              child: Image.asset("assets/img/pharmacie.png", width: 300,),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.location_city, 'Ville', city),
                    const Divider(),
                    _buildInfoRow(Icons.map, 'Région', region),
                    const Divider(),
                    _buildInfoRow(Icons.phone, 'Téléphone', phoneNumber),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // Boutons d'actions
            Column(
              children: [
                _buildActionButton(
                  icon: Icons.list,
                  label: 'Liste des produits',
                  onPressed: () {
                    // Logique pour afficher la liste des produits spécifiques
                  },
                ),
                const SizedBox(height: 16.0),
                _buildActionButton(
                  icon: Icons.map,
                  label: 'Voir sur Google Maps',
                  onPressed: () async {
                    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                    if (await canLaunch(googleMapsUrl)) {
                      await launch(googleMapsUrl);
                    } else {
                      throw 'Could not open Google Maps';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                _buildActionButton(
                  icon: Icons.phone,
                  label: 'Appeler',
                  onPressed: () async {
                    final phoneUrl = 'tel:$phoneNumber';
                    if (await canLaunch(phoneUrl)) {
                      await launch(phoneUrl);
                    } else {
                      throw 'Could not make a call';
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les informations
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Appwidget.customGreen),
        const SizedBox(width: 16.0),
        Text(
          '$label : ',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18.0, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Widget pour les boutons d'action
  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 28.0),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appwidget.customGreen,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 5.0,
        ),
      ),
    );
  }
}
