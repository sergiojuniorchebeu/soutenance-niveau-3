import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../App Services/Auth Services.dart';
import '../../../AppWidget.dart';
import 'Login Patient.dart';

class InscriptionPatient extends StatefulWidget {
  const InscriptionPatient({super.key});

  @override
  _InscriptionPatientState createState() => _InscriptionPatientState();
}

class _InscriptionPatientState extends State<InscriptionPatient> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? _errorMessage;


  bool _validateInputs() {
    setState(() {
      _errorMessage = null;
    });

    if (_nameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer votre nom.';
      });
      return false;
    }

    if (_emailController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer votre email.';
      });
      return false;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _errorMessage = 'Veuillez entrer un email valide.';
      });
      return false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer votre mot de passe.';
      });
      return false;
    }

    if (_passwordController.text.length < 6) {
      setState(() {
        _errorMessage = 'Le mot de passe doit contenir au moins 6 caractères.';
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
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
                  height: 50,
                ),
              ),
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
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Nom*",
                    style: Appwidget.styledetexte(taille: 15),
                  ),
                ],
              ),
              CupertinoTextField(
                controller: _nameController,
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                placeholder: 'Entrez votre nom',
                placeholderStyle:
                Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(CupertinoIcons.person),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
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
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                placeholder: 'Entrez votre mot de passe',
                placeholderStyle:
                Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
                obscureText: !_authService.isPasswordVisible,
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(CupertinoIcons.lock),
                ),
                suffix: IconButton(
                  icon: Icon(_authService.isPasswordVisible
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                  onPressed: () {
                    setState(() {
                      _authService.togglePasswordVisibility();
                    });
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              // Affichage du message d'erreur
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              isLoading
                  ? Appwidget.loading()
                  : SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Appwidget.customGreen,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: () async {
                    if (_validateInputs()) {
                      setState(() {
                        isLoading = true;
                      });
                      await _authService.registerWithEmailAndPassword(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Text('S\'inscrire',
                      style: Appwidget.styledetexte(
                          w: FontWeight.w700, couleur: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Déjà un compte? ',
                      style: Appwidget.styledetexte(
                          taille: 17, couleur: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPatient()));
                    },
                    child: Text('Se Connecter',
                        style: Appwidget.styledetexte(
                            couleur: Appwidget.customGreen, taille: 16)),
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
