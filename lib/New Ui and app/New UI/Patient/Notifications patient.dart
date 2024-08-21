import 'package:flutter/material.dart';
import '../../../AppWidget.dart';

class NotificationsPatient extends StatelessWidget {
  const NotificationsPatient({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications data
    final List<Map<String, String>> notifications = [
      {
        'title': 'Réception de Commande',
        'message': 'Votre commande #1234 a été reçue avec succès.',
        'date': 'August 18, 2024',
      },
      {
        'title': 'Rappel de Médicament',
        'message': 'Il est temps de prendre votre médicament prescrit.',
        'date': 'August 17, 2024',
      },
      {
        'title': 'Nouvelle Promotion',
        'message': 'Profitez de 20% de réduction sur les médicaments en ligne.',
        'date': 'August 15, 2024',
      },
    ];

    return Scaffold(
      appBar:Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationTile(
              title: notification['title']!,
              message: notification['message']!,
              date: notification['date']!,
            );
          },
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String date;

  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: Appwidget.styledetexte(
            taille: 16,
            w: FontWeight.bold,
            couleur: Appwidget.customGreen,
          ),
        ),
        subtitle: Text(
          message,
          style: Appwidget.styledetexte(
            taille: 14,
            couleur: Colors.black87,
          ),
        ),
        trailing: Text(
          date,
          style: Appwidget.styledetexte(
            taille: 12,
            couleur: Colors.grey,
          ),
        ),
      ),
    );
  }
}
