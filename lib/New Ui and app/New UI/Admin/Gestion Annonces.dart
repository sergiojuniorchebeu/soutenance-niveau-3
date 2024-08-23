import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class AnnouncementManagementPage extends StatefulWidget {
  const AnnouncementManagementPage({super.key});

  @override
  _AnnouncementManagementPageState createState() =>
      _AnnouncementManagementPageState();
}

class _AnnouncementManagementPageState
    extends State<AnnouncementManagementPage> {
  final List<Map<String, String>> _announcements = [
    {"title": "System Maintenance", "content": "Scheduled maintenance on 01/09"},
    {"title": "New Features", "content": "Check out our latest updates."},
  ];

  void _showAddAnnouncementDialog() {
    _showAnnouncementDialog(context, isEdit: false);
  }

  void _showEditAnnouncementDialog(int index) {
    _showAnnouncementDialog(context, isEdit: true, index: index);
  }

  void _showAnnouncementDialog(BuildContext context,
      {bool isEdit = false, int? index}) {
    final titleController = TextEditingController(
        text: isEdit ? _announcements[index!]['title'] : '');
    final contentController = TextEditingController(
        text: isEdit ? _announcements[index!]['content'] : '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Announcement' : 'Add Announcement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(isEdit ? 'Save' : 'Add'),
              onPressed: () {
                setState(() {
                  if (isEdit) {
                    _announcements[index!] = {
                      "title": titleController.text,
                      "content": contentController.text
                    };
                  } else {
                    _announcements.add({
                      "title": titleController.text,
                      "content": contentController.text
                    });
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Announcement'),
          content: Text('Are you sure you want to delete this announcement?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  _announcements.removeAt(index);
                });
                Navigator.of(context).pop();
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
      /*appBar: AppBar(
        title: Text('Announcement Management'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Annonces',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _announcements.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(_announcements[index]['title']!),
                      subtitle: Text(_announcements[index]['content']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _showEditAnnouncementDialog(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _showDeleteConfirmationDialog(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAnnouncementDialog,
        child: Icon(Icons.add),
        backgroundColor: Appwidget.customGreen,
      ),
    );
  }
}
