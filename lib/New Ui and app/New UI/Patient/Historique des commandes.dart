import 'package:flutter/material.dart';

import '../../../AppWidget.dart';



class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Historique des commandes',
                    style: Appwidget.styledetexte(
                        couleur: Appwidget.customGreen,
                        taille: 25,
                        w: FontWeight.bold),
                  textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Voici la liste de vos commandes passées",
                  style: Appwidget.styledetexte(
                      taille: 17, couleur: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: Text('Commande #123456', style: Appwidget.styledetexte(taille: 16, couleur: Colors.black)),
                trailing: Text('15 Août 2024', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                children: [
                  ListTile(
                    title: Text('Articles:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('Médicament A, Médicament B', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                  ),
                  ListTile(
                    title: Text('Prix total:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('45,00 EUR', style: Appwidget.styledetexte(taille: 15, couleur: Appwidget.customGreen)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
               ExpansionTile(
                title: Text('Commande #789012', style: Appwidget.styledetexte(taille: 16, couleur: Colors.black)),
                trailing: Text('10 Août 2024', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                children: [
                  ListTile(
                    title: Text('Articles:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('Médicament C', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                  ),
                  ListTile(
                    title: Text('Prix total:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('20,00 EUR', style: Appwidget.styledetexte(taille: 15, couleur: Appwidget.customGreen)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ExpansionTile(
                title: Text('Commande #789012', style: Appwidget.styledetexte(taille: 16, couleur: Colors.black)),
                trailing: Text('10 Août 2024', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                children: [
                  ListTile(
                    title: Text('Articles:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('Médicament C', style: Appwidget.styledetexte(taille: 15, couleur: Colors.grey)),
                  ),
                  ListTile(
                    title: Text('Prix total:', style: Appwidget.styledetexte(taille: 15, couleur: Colors.black)),
                    subtitle: Text('20,00 EUR', style: Appwidget.styledetexte(taille: 15, couleur: Appwidget.customGreen)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              /*SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Appwidget.customGreen,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPatient()));
                  },
                  child: Text('Retour à l\'accueil',
                      style: Appwidget.styledetexte(
                          w: FontWeight.w800, couleur: Colors.white)),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
