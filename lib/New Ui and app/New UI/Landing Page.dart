import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../AppWidget.dart';
import 'Home Page.dart';
import 'Visiteur/Presentation Page.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        actions: [
          IconButton(
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()));
          }, icon: const Icon(CupertinoIcons.info_circle_fill, color: Appwidget.customGreen, size: 24,))
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 5),
                    child: Text(
                        'PharmaCare',
                        style: Appwidget.styledetexte(
                            couleur: Appwidget.customGreen,
                            taille: 27,
                            w: FontWeight.bold
                        )
                    ),
                ),
                // sergiojuniorchebeu@gmail.com

                Container(
                  decoration: BoxDecoration(
                    color: Appwidget.customGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  height: 300,
                  width: double.infinity,
                  child: Image.asset('assets/img/pharmacie (1).png'),

                ),
                // Subtitle
                Text(
                    'Your Health, Our Priority',
                    style: Appwidget.styledetexte(
                        taille: 27, w: FontWeight.w500
                    )
                ),
                // Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      'Trouver des pharmacies en un clic',
                      textAlign: TextAlign.center, style: Appwidget.styledetexte(
                      taille: 17, w: FontWeight.w400
                  )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: Appwidget.customGreen,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                      },
                      child: Text(
                          'Get Started',
                          style: Appwidget.styledetexte(
                            w: FontWeight.w500, couleur: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}