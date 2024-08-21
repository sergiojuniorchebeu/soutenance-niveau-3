import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Appwidget {
  static const Color customGreen = Color(0xFF009966);

  static styledetexte({FontWeight? w, double? taille, Color? couleur}) {
    return TextStyle(
        fontSize: taille,
        fontWeight: w ?? FontWeight.normal,
        color: couleur ?? Colors.black);
  }

  static input(String placeholder, IconData icone) {
    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      placeholder: placeholder,
      placeholderStyle:
      Appwidget.styledetexte(taille: 18, couleur: Colors.grey),
      prefix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(icone),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: CupertinoColors.systemGrey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static bouttonvide(String titre){
    return  SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Appwidget.customGreen,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () {},
          child: Center(
            child: Text(
              titre,
              style: Appwidget.styledetexte(
                couleur: Colors.white,
                w: FontWeight.bold,
                taille: 19,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static cuppertinotile(String titre){
    return CupertinoListTile(
      title: Text(titre),
    );
  } 
  static cuppertinotileDrawer(IconData icone , String titre){
    return CupertinoListTile(
      leading: Icon(icone),
      title: Text(titre, style: Appwidget.styledetexte(
          couleur: Colors.black, w: FontWeight.bold, taille: 18)),
    );
  }

  static appBar(){
    return  AppBar(
      backgroundColor: Appwidget.customGreen,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pharmacare',
              style: Appwidget.styledetexte(
                  couleur: Colors.white,
                  taille: 20,
                  w: FontWeight.bold)),
          const SizedBox(width: 10,),
          Image.asset(
            "assets/img/pharmacie (1).png",
            height: 40,
          )
        ],
      ),
    );
  }
}