import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
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
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          labelStyle: Appwidget.styledetexte(
            couleur: Colors.white, w: FontWeight.bold,
          ),
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tout'),
            Tab(text: 'Pharmacies'),
            Tab(text: 'Patient'),
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
                _buildUserList(context, 'Tout les Users'),
                _buildUserList(context, 'Pharmacies'),
                _buildUserList(context, 'Patient'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUserDialog(context),
        backgroundColor: Appwidget.customGreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              'Admin Pannel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSidebarItem(Icons.dashboard, 'Dashboard'),
          _buildSidebarItem(Icons.person, 'User Management', isActive: true),
          //_buildSidebarItem(Icons.announcement, 'Announcements'),
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
      onTap: () {},
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
            child: ListView.builder(
              itemCount: 10, // Replace with dynamic user count
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('User $index'),
                    subtitle: Text('user$index@example.com'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: _buildUserForm(),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add User'),
              onPressed: () {
                // Add user logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter user email',
          ),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text('Active'),
          value: true, // Replace with actual status
          onChanged: (bool value) {},
        ),
      ],
    );
  }
}
