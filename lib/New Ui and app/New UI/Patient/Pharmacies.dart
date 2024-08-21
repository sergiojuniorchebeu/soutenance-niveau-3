import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../AppWidget.dart';

class ListePharmacies extends StatelessWidget {
  const ListePharmacies({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Center(
      child: SpinKitRing(
        size: 50,
        color: Appwidget.customGreen,
      ),
    ),
    );
  }
}
