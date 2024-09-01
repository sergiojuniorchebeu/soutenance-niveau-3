import 'package:flutter/material.dart';
import 'package:projetsout/AppWidget.dart';

import 'Gestion Annonces.dart';
import 'Gestion Utilisateur.dart';
import 'Notifications.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
         title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Pharmacare',
                 style: Appwidget.styledetexte(
                     couleur: Colors.white,
                     taille: 20,
                     w: FontWeight.bold)
             ),
             const SizedBox(width: 10,),
             Image.asset(
               "assets/img/pharmacie (1).png",
               height: 40,
             )
           ],
         ),
          bottom: TabBar(
            labelStyle: Appwidget.styledetexte(
              couleur: Colors.white, w: FontWeight.bold
            ),
            tabs: const [
              Tab(text: 'Gestion Utilisateur',),
              Tab(text: 'Gestion Annonces'),
              Tab(text: 'Notifications'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserManagementPage(),
            AnnouncementManagementPage(),
            NotificationPageAdmin(),
          ],
        ),
      ),
    );
  }
}