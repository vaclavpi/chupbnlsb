import 'package:flutter/material.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final String instagramUrl = 'https://www.instagram.com/vena.vapi/';
  final String facebookUrl = 'https://www.facebook.com';
  final String githubUrl = 'https://www.github.com';
  final String buymeacoffeeUrl = 'https://www.buymeacoffee.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Václav Pisinger'),
        backgroundColor: AppColors.navColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildGlassmorphicContainer(
                child: Text(
                  'Tuto aplikaci jsem vytvořil a následně publikoval (2024) jako svůj ročníkový projekt na gymnaziálním bojišti. Teď tento géniovský projekt usnadňuje objevování místa, kde se skrývají nejen dramatické příběhy a legendy, ale i několik zapomenutých zvratů a momentů, které by dokázaly okouzlit i samotného Harryho Pottera.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildClickableImage(
                      'assets/img/instagram.png', instagramUrl),
                  _buildClickableImage('assets/img/facebook.png', facebookUrl),
                  _buildClickableImage('assets/img/web.png', githubUrl),
                  _buildClickableImage(
                      'assets/img/coffee-cup.png', buymeacoffeeUrl),
                ],
              ),
              SizedBox(height: 20),
              _buildGlassmorphicContainer(
                child: Text(
                  'Rozvoj této aplikace podporuje město Brandýs nad Labem - Stará Boleslav.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Nelze otevřít $url';
    }
  }

  Widget _buildGlassmorphicContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.1),
        border: Border.all(
          color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 16,
            color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildClickableImage(String imagePath, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
    );
  }
}
