import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../App Services/Auth Services.dart';
import '../../../AppWidget.dart';
import 'Inscription Patient.dart';

class LoginPatient extends StatefulWidget {
  const LoginPatient({super.key});

  @override
  State<LoginPatient> createState() => _LoginPatientState();
}

class _LoginPatientState extends State<LoginPatient> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Fonction de validation
  String? _validateInput() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty) {
      return 'L\'email est requis.';
    } else if (!EmailValidator.validate(email)) {
      return 'Adresse email invalide.';
    } else if (password.isEmpty) {
      return 'Le mot de passe est requis.';
    }
    return null;
  }

  // Fonction pour se connecter
  Future<void> _login() async {
    final validationMessage = _validateInput();
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationMessage)),
      );
    } else {
      setState(() {
        _isLoading = true;
      });

      // Appel de la méthode de connexion
      try {
        await AuthService().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la connexion.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      "assets/img/pharmacie (1).png",
                      height: 55,
                    ),
                  ),
                  Text(
                    'Pharmacare',
                    style: Appwidget.styledetexte(
                        couleur: Appwidget.customGreen,
                        taille: 27,
                        w: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Veuillez remplir ce formulaire",
                      style: Appwidget.styledetexte(
                          taille: 17, couleur: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Email*",
                        style: Appwidget.styledetexte(taille: 15),
                      ),
                    ],
                  ),
                  CupertinoTextField(
                    controller: _emailController,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    placeholder: 'Entrez votre email',
                    placeholderStyle: Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                    prefix: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(CupertinoIcons.mail),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey),
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
                    controller: _passwordController,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    placeholder: 'Entrez votre mot de passe',
                    placeholderStyle: Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                    obscureText: !_isPasswordVisible,
                    prefix: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(CupertinoIcons.lock),
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _isPasswordVisible
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: Appwidget.customGreen,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: _login,
                      child: Text(
                        'Connexion',
                        style: Appwidget.styledetexte(
                            w: FontWeight.w800, couleur: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pas encore inscrit ? ",
                        style: Appwidget.styledetexte(taille: 17, couleur: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const InscriptionPatient()),
                          );
                        },
                        child: Text(
                          'S\'inscrire',
                          style: Appwidget.styledetexte(
                              couleur: Appwidget.customGreen, taille: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child:Appwidget.loading(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
