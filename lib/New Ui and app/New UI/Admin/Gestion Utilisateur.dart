import 'package:flutter/material.dart';
import 'package:projetsout/App%20Services/Recup%C3%A9ration%20des%20ID.dart';
import 'package:projetsout/AppWidget.dart';

import 'Ajout Pharmacies.dart';


class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final IDRecup _idRecup = IDRecup();

  String? _adminName;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAdminName();
  }

  Future<void> _fetchAdminName() async {
    String? adminName = await _idRecup.getAdminName();
    setState(() {
      _adminName = adminName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Notification logic here
                },
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundImage: AssetImage('aassets/img/admin.png'),
              ),
              const SizedBox(width: 8),
              Text(
                _adminName ?? "Chargement",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        bottom: TabBar(
          labelStyle: Appwidget.styledetexte(
            couleur: Colors.white, w: FontWeight.bold,
          ),
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pharmacies'),
            Tab(text: 'Patients'),
          ],
        ),
      ),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUserList(context, 'All Users'),
                _buildUserList(context, 'Pharmacies'),
                _buildUserList(context, 'Patients'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmacyForm())),
        backgroundColor: Appwidget.customGreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            child: Text(
              'Admin Panel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSidebarItem(Icons.dashboard, 'Dashboard'),
          _buildSidebarItem(Icons.person, 'User Management', isActive: true),
          _buildSidebarItem(Icons.notifications, 'Announcements'),
          _buildSidebarItem(Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, {bool isActive = false}) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.green[800] : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isActive ? Colors.green[800] : Colors.black),
      ),
      onTap: () {
        // Handle navigation
      },
    );
  }

  Widget _buildUserList(BuildContext context, String tabName) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$tabName',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: List.generate(10, (index) {
                return DataRow(cells: [
                  DataCell(Text('User $index')),
                  DataCell(Text('user$index@example.com')),
                  DataCell(Text('Role')),
                  DataCell(Text('Active')),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditUserDialog(context, 'User $index'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmation(context),
                        ),
                      ],
                    ),
                  ),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }


  void _showEditUserDialog(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $userName'),
          content: _buildUserForm(userName: userName),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: () {
                // Edit user logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
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
                // Delete user logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserForm({String? userName}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: userName ?? 'Enter user name',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter user email',
          ),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Active'),
          value: true, // Replace with actual status
          onChanged: (bool value) {},
        ),
      ],
    );
  }
}
