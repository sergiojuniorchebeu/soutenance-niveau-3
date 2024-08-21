import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../AppWidget.dart';
import 'Home Page patient.dart';
import 'Notifications patient.dart';
import 'Profile Patient.dart';
import 'Screen Phramacy.dart';

class NavigationPatient extends StatefulWidget {
  const NavigationPatient({super.key});

  @override
  State<NavigationPatient> createState() => _NavigationPatientState();
}

class _NavigationPatientState extends State<NavigationPatient> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const DashboardPatient(),
    const NavBarPharmacy(),
    const NotificationsPatient(),
    const ProfilePatient(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Appwidget.customGreen,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Appwidget.customGreen,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
        ),
        backgroundColor: Colors.white,
        elevation: 8,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet, size: 30),
            label: 'Pharmacies',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell, size: 30),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
