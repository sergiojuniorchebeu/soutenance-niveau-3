import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../AppWidget.dart';
import 'Inscription Patient.dart';
import 'Screen Manage Patient.dart';


class LoginPatient extends StatelessWidget {
  const LoginPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    "assets/img/pharmacie (1).png",
                    height: 55,
                  )),
              // sergiojuniorchebeu@gmail.com
              Text('Pharmacare',
                  style: Appwidget.styledetexte(
                      couleur: Appwidget.customGreen,
                      taille: 27,
                      w: FontWeight.bold)),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Veuillez remplir ce formulaire",
                  style: Appwidget.styledetexte(
                      taille: 17, couleur: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Email*",
                    style: Appwidget.styledetexte(taille: 15),
                  ),
                ],
              ),
              CupertinoTextField(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                placeholder: 'Entrez votre email',
                placeholderStyle:
                Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(CupertinoIcons.mail),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Mot de passe*",
                    style: Appwidget.styledetexte(taille: 15),
                  ),
                ],
              ),
              CupertinoTextField(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                placeholder: 'Entrez votre mot de passe',
                placeholderStyle:
                Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                obscureText: true,
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(CupertinoIcons.lock),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Appwidget.customGreen,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationPatient()));
                  },
                  child: Text('Connexion',
                      style: Appwidget.styledetexte(
                          w: FontWeight.w800, couleur: Colors.white)),
                ),
              ),
              const SizedBox(height: 18),
              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas encore inscrit ? ",
                      style: Appwidget.styledetexte(
                          taille: 17, couleur: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPatient()));
                    },
                    child: Text('S\'inscrire',
                        style: Appwidget.styledetexte(
                            couleur: Appwidget.customGreen, taille: 17)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
