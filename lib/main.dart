import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetsout/firebase_options.dart';
import 'AppWidget.dart';
import 'New Ui and app/New UI/Admin/Landing Page Admin.dart';
import 'New Ui and app/New UI/Landing Page.dart';
import 'New Ui and app/New UI/Patient/Landing Page.dart';

 Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Appwidget.customGreen),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Poppins",
        appBarTheme: const AppBarTheme(
          backgroundColor: Appwidget.customGreen,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  const LandingUserPage(),
       //'home' : (context)=> HomePage()
      },
    );
  }
}