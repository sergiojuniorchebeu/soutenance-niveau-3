import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/App%20Services/Recup%C3%A9ration%20des%20ID.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/choix%20du%20type%20de%20compte.dart';
import '../../../App Services/Gestion Users.dart';
import 'Ajout Pharmacies.dart';


class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}
class _UserManagementPageState extends State<UserManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final IDRecup _idRecup = IDRecup();
  final UserManagementController _gestion = UserManagementController();
  final FirebaseAuth _c = FirebaseAuth.instance;


  String? _adminName;
  late Future<List<Map<String, dynamic>>> _allUsersFuture;
  late Future<List<Map<String, dynamic>>> _pharmaciesFuture;
  late Future<List<Map<String, dynamic>>> _patientsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAdminName();
    _fetchUserData();
  }

  Future<void> _fetchAdminName() async {
    String? adminName = await _idRecup.getAdminName();
    setState(() {
      _adminName = adminName;
    });
  }

  Future<void> _fetchUserData() async {
    // Assuming admin email is available or can be fetched similarly
    String currentAdminEmail = _c.currentUser.toString();

    setState(() {
      _allUsersFuture = _gestion.listUsersExcludingAdmin(currentAdminEmail);
      _pharmaciesFuture = _gestion.listPharmacies();
      _patientsFuture = _gestion.listPatients();
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
              const SizedBox(width: 10),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/img/admin.png'),
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
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _allUsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Appwidget.loading());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No users found.'));
                    } else {
                      return _buildUserList(context, snapshot.data!);
                    }
                  },
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _pharmaciesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Appwidget.loading());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/img/page-not-found.png", height: 100,),
                          SizedBox(height: 10,),
                          const Text('Pas de Pharmacies Trouvées.'),
                        ],
                      ));
                    } else {
                      return _buildUserList(context, snapshot.data!);
                    }
                  },
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _patientsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No patients found.'));
                    } else {
                      return _buildUserList(context, snapshot.data!);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChoixTypeCompte())),
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

  Widget _buildUserList(BuildContext context, List<Map<String, dynamic>> users) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Users',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              rows: List.generate(users.length, (index) {
                final user = users[index];
                return DataRow(cells: [
                  DataCell(Text(user['Nom'] ?? '')),
                  DataCell(Text(user['Email'] ?? '')),
                  DataCell(Text(user['Rôle'] ?? '')),
                  DataCell(Text(user['Statut'] ?? '')),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditUserDialog(context, user['Name'] ?? ''),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmation(context, user['Email'] ?? ''),
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

  void _showDeleteConfirmation(BuildContext context, String userEmail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete user with email: $userEmail?'),
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

