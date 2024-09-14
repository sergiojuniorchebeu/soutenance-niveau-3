import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projetsout/AppWidget.dart';
import 'Assistance IA.dart';
import 'Gestion Commande.dart';
import 'Gestion liste produit.dart';
import 'Parametre.dart';
import 'Statut de garde.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appwidget.appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const HeaderSection(),
            const VisitorChart(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1,
                children: <Widget>[
                  DashboardCard(
                    icon: Icons.list,
                    title: 'Liste de Produits',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MedicamentManagementPage()));
                    },
                  ),
                  DashboardCard(
                    icon: Icons.shopping_cart,
                    title: 'Liste des Reservations',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const CommandeManagementPage()));
                    },
                  ),
                  DashboardCard(

                    icon: Icons.hourglass_bottom,
                    title: 'Paramatre de garde',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const GardePharmaciePage()));
                    },
                  ),
                  DashboardCard(
                    icon: Icons.support,
                    title: 'Assistance IA',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatGPTInterface()));
                    },
                  ),
                  DashboardCard(
                    icon: Icons.settings,
                    title: 'Paramètres',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PharmacyProfilePage()));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26.0),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  Future<Map<String, dynamic>> _getPharmacyInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      }
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getPharmacyInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Appwidget.loading();
        } else if (snapshot.hasError) {
          return const Text('Erreur de chargement');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final pharmacyData = snapshot.data!;
          final String pharmacyName = pharmacyData['Nom'] ?? 'Nom inconnu';
          final String city = pharmacyData['Ville'] ?? 'Ville inconnue';
          final String region = pharmacyData['Région'] ?? 'Région inconnue';

          return Row(
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundColor: Appwidget.customGreen,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pharmacyName,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '$city, $region',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('Pharmacie non trouvée');
        }
      },
    );
  }
}


class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const DashboardCard({super.key, required this.icon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shadowColor: Appwidget.customGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 60.0, color: Appwidget.customGreen), // Adjust icon size to fit smaller card
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class VisitorChart extends StatelessWidget {
  const VisitorChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shadowColor: Colors.tealAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Évaluation Mensuelle des Visiteurs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200.0,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: Colors.black26),
                      left: BorderSide(color: Colors.black26),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Jan', style: style);
                            case 1:
                              return const Text('Feb', style: style);
                            case 2:
                              return const Text('Mar', style: style);
                            case 3:
                              return const Text('Apr', style: style);
                            case 4:
                              return const Text('May', style: style);
                            case 5:
                              return const Text('Jun', style: style);
                            case 6:
                              return const Text('Jul', style: style);
                            case 7:
                              return const Text('Aug', style: style);
                            case 8:
                              return const Text('Sep', style: style);
                            case 9:
                              return const Text('Oct', style: style);
                            case 10:
                              return const Text('Nov', style: style);
                            case 11:
                              return const Text('Dec', style: style);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: const [
                        FlSpot(0, 500),
                        FlSpot(1, 700),
                        FlSpot(2, 900),
                        FlSpot(3, 1100),
                        FlSpot(4, 1300),
                        FlSpot(5, 1500),
                        FlSpot(6, 1700),
                        FlSpot(7, 1900),
                        FlSpot(8, 2100),
                        FlSpot(9, 2300),
                        FlSpot(10, 2500),
                        FlSpot(11, 2700),
                      ],
                      color:Appwidget.customGreen,
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
