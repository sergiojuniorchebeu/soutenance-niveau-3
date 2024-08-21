import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../AppWidget.dart';
import 'Pharmacies de gardes.dart';
import 'Pharmacies.dart';

class NavBarPharmacy extends StatefulWidget {
  const NavBarPharmacy({super.key});

  @override
  State<NavBarPharmacy> createState() => _NavBarPharmacyState();
}

class _NavBarPharmacyState extends State<NavBarPharmacy> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _screens = [
    ListePharmacies(),
    PharmaciesDegarde(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Appwidget.customGreen,
          labelColor: Appwidget.customGreen,
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(
              icon: Icon(Icons.medication_liquid, size: 30),
              text: "Pharmacies",
            ),
            Tab(
              icon: Icon(Icons.medical_services_rounded, size: 30),
              text: 'De Garde',
            ),
          ],
        ),
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pharmacare',
                style: Appwidget.styledetexte(
                    couleur: Appwidget.customGreen,
                    taille: 20,
                    w: FontWeight.bold)),
            const SizedBox(width: 10,),
            Image.asset(
              "assets/img/pharmacie (1).png",
              height: 40,
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _screens,
      ),
    );
  }
}
