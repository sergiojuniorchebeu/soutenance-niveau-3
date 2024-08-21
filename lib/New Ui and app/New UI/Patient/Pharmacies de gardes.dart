import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../AppWidget.dart';

class PharmaciesDegarde extends StatelessWidget {
  const PharmaciesDegarde({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitRing(
        size: 50,
        color: Appwidget.customGreen,
    ),)
    );
  }
}
