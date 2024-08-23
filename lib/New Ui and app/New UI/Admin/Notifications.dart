import 'package:flutter/material.dart';

class NotificationPageAdmin extends StatefulWidget {
  const NotificationPageAdmin({super.key});

  @override
  _NotificationPageAdminState createState() => _NotificationPageAdminState();
}

class _NotificationPageAdminState extends State<NotificationPageAdmin> {
  final List<Map<String, String>> _notifications = [
    {
      "title": "Order Confirmation",
      "content": "Your order #1234 has been confirmed."
    },
    {
      "title": "New Feature Release",
      "content": "We have introduced a new feature for better user experience."
    },
    {
      "title": "System Alert",
      "content": "Scheduled maintenance on 01/09. The system will be down."
    },
  ];

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Notifications',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(_notifications[index]['title']!),
                      subtitle: Text(_notifications[index]['content']!),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNotification(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
