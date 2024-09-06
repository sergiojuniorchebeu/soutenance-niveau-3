import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/App%20Services/Recup%C3%A9ration%20des%20ID.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Admin/choix%20du%20type%20de%20compte.dart';
import '../../../App Services/Gestion Users.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}
class _UserManagementPageState extends State<UserManagementPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final IDRecup _idRecup = IDRecup();
  final UserManagementController _gestion = UserManagementController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _adminName;
  late Future<List<Map<String, dynamic>>> _allUsersFuture;
  Future<List<Map<String, dynamic>>> _pharmaciesFuture = Future.value([]);
  Future<List<Map<String, dynamic>>> _patientsFuture = Future.value([]);

  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  String _searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAdminName();
    _fetchUserData();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _filterUsers();
      });
    });
  }

  Future<void> _fetchAdminName() async {
    String? adminName = await _idRecup.getAdminName();
    setState(() {
      _adminName = adminName;
    });
  }

  Future<void> _fetchUserData() async {
    String currentAdminEmail = _auth.currentUser?.email ?? '';
    print('Current Admin Email: $currentAdminEmail');

    try {
      List<Map<String, dynamic>> allUsers = await _gestion.listUsersExcludingAdmin(currentAdminEmail);
      List<Map<String, dynamic>> pharmacies = await _gestion.listPharmacies();
      List<Map<String, dynamic>> patients = await _gestion.listPatients();

      setState(() {
        _allUsers = allUsers;
        _filteredUsers = allUsers; // Initially, show all users
        _pharmaciesFuture = Future.value(pharmacies);
        _patientsFuture = Future.value(patients);
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _pharmaciesFuture = Future.value([]);
        _patientsFuture = Future.value([]);
      });
    }
  }

  void _filterUsers() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = _allUsers;
    } else {
      _filteredUsers = _allUsers.where((user) {
        return user['Nom']?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false ||
            user['Email']?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 300,
            child: TextField(
              controller: _searchController,
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
                _buildUserList(context, _filteredUsers),
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
                          Image.asset("assets/img/page-not-found.png", height: 100),
                          const SizedBox(height: 10),
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
                      return Center(child: Appwidget.loading());
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                        onPressed: () => _showEditUserDialog(
                          context,
                          user['UID'] ?? '', // Passer l'ID correct ici
                          user['Nom'] ?? '',
                          user['Statut'] ?? '',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmation(
                          context,
                          user['UID'] ?? '', // Passer l'ID correct ici
                          user['Email'] ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
            }),
          ),
        ),
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, String userId, String userName, String currentStatus) {
    String newStatus = currentStatus == 'actif' ? 'inactif' : 'actif';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $userName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Change status to: $newStatus'),
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
              child: const Text('Save Changes'),
              onPressed: () async {
                try {
                  if (userId.isNotEmpty) {
                    await _gestion.toggleUserStatus(userId, newStatus);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User status updated successfully.')),
                    );
                    Navigator.of(context).pop();
                    _fetchUserData(); // Refresh data
                  } else {
                    throw Exception('Invalid User ID.');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, String userId, String userEmail) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to delete user with email: $userEmail?'),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Enter admin password'),
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
              child: Text('Delete'),
              onPressed: () async {
                try {
                  if (userId.isNotEmpty) {
                    await _gestion.deleteUser(userId, passwordController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User deleted successfully.')),
                    );
                    Navigator.of(context).pop();
                    _fetchUserData(); // Refresh data
                  } else {
                    throw Exception('Invalid User ID.');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
