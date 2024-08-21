import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../AppWidget.dart';
import 'Patient/Inscription Patient.dart';
import 'Patient/Login Patient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                  child: Image.asset(
                    "assets/img/pharmacie (1).png",
                    height: 55,
                  )),
              Text('Pharmacare',
                  style: Appwidget.styledetexte(
                      couleur: Appwidget.customGreen,
                      taille: 27,
                      w: FontWeight.bold)),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Veuillez choisir une option",
                  style:
                      Appwidget.styledetexte(taille: 17, couleur: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/google.png",
                          width: 30,
                          height: 40,
                        ),
                        const SizedBox(width: 8),
                        Text('Google',
                            style: Appwidget.styledetexte(
                                taille: 18, w: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Appwidget.customGreen,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPatient()));
                  },
                  child: Text('Se Connecter',
                      style: Appwidget.styledetexte(
                          w: FontWeight.w700, couleur: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Appwidget.customGreen,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPatient()));
                  },
                  child: Text('S\'inscrire',
                      style: Appwidget.styledetexte(
                          w: FontWeight.w700, couleur: Colors.white)),
                ),
              ),
              const SizedBox(height: 18),
              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Cliquez pour choisir une option ",
                      style: Appwidget.styledetexte(
                          taille: 17, couleur: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
