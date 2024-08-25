import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projetsout/AppWidget.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Landing%20Page.dart';
import 'package:projetsout/New%20Ui%20and%20app/New%20UI/Patient/Login%20Patient.dart';

class LandingUserPage extends StatefulWidget {
  const LandingUserPage({super.key});

  @override
  State<LandingUserPage> createState() => _LandingUserPageState();
}

class _LandingUserPageState extends State<LandingUserPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/img/pharmacie (1).png",
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Pharmacare",
                    style: Appwidget.styledetexte(
                      couleur: Appwidget.customGreen,
                      taille: 30,
                      w: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Appwidget.loading()
          ),
        ],
      ),
    );
  }
}
