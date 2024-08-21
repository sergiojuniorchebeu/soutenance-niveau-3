import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../AppWidget.dart';
import '../Home Page.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Bienvenue sur Pharmacare',
      description: 'Trouver des médicaments plus rapidement.',
      imagePath: 'assets/img/boite-a-pilules.png',
    ),
    OnboardingItem(
      title: 'Identifier des pharmacies',
      description: 'Retrouver des pharmacies plus proches de vous',
      imagePath: 'assets/img/pharmacie (1).png',
    ),
    OnboardingItem(
      title: 'Commander en ligne',
      description: 'Faites vous livrer vos médicaments à domicile',
      imagePath: 'assets/img/pharmacie.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          const SizedBox(height: 40),
          SmoothPageIndicator(
            controller: _controller,
            count: onboardingItems.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Appwidget.customGreen,
              dotColor: Colors.grey,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  item: onboardingItems[index],
                  isLastPage: index == onboardingItems.length - 1,
                  onGetStarted: () {
                   Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final bool isLastPage;
  final VoidCallback onGetStarted;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.isLastPage,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(item.imagePath, height: 150),
          const SizedBox(height: 20),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Appwidget.customGreen
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          if (isLastPage)
            ElevatedButton(
              onPressed: onGetStarted,
              style: ElevatedButton.styleFrom(
                backgroundColor: Appwidget.customGreen,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Get Started',
                style: Appwidget.styledetexte(
                  couleur: Colors.white,
                  w: FontWeight.w700,
                  taille: 19,
                ),
              ),
            ),
          const SizedBox(height: 20),
          Text(
              '© 2024 SergioJuniorChebeu',
              style: Appwidget.styledetexte(
                  taille:14, couleur: Colors.grey
              )
          ),
        ],
      ),
    );
  }
}