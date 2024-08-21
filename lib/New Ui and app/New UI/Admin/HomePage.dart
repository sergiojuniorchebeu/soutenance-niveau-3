import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardCard(
              icon: Icons.manage_accounts,
              title: 'Manage User Accounts',
              onPressed: () {
                // Navigate to Manage User Accounts Page
              },
            ),
            DashboardCard(
              icon: Icons.announcement,
              title: 'Publish Announcements',
              onPressed: () {
                // Navigate to Publish Announcements Page
              },
            ),
            DashboardCard(
              icon: Icons.settings,
              title: 'Settings',
              onPressed: () {
                // Navigate to Settings Page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const DashboardCard({required this.icon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            Text(title),
          ],
        ),
      ),
    );
  }
}
