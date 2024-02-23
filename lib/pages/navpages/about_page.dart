import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final List<Map<String, String>> socialData = [
    {
      "name": "Facebook",
      "icon": "assets/img/facebook.png",
      "url": "https://www.facebook.com"
    },
    {
      "name": "Web",
      "icon": "assets/img/web.png",
      "url": "https://www.twitter.com"
    },
    {
      "name": "Instagram",
      "icon": "assets/img/instagram.png",
      "url": "https://www.instagram.com"
    },
    // Add more social networks as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chytrý upřímný průvodce Brandýsem nad Labem - Starou Boleslaví',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: socialData.map((social) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _launchURL(social['url']!),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            social['icon']!,
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            social['name']!,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'O projektu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tento projekt je výsledkem ročníkové práce Václava Pisingera, a je podporována městem Brandýs nad Labem - Stara Boleslav.\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Co je Chytrý upřímný průvodce?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chytrý upřímný průvodce Brandýsem nad Labem - Starou Boleslaví je nejen mobilní aplikace navržená k poskytování užitečných informací a tipů návštěvníkům a obyvatelům Brandýsa nad Labem - Staré Boleslavi. Tento kapesní průvodce nabízí širokou škálu funkcí a možností prozkoumávání města a objevování jeho zajímavostí.\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Funkce aplikace',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Interaktivní mapy: 🗺️ Podrobné mapy města s označením turistických atrakcí, restaurací, obchodů a dalších zajímavých míst.\n'
                'Užitečné informace: ℹ️ Kompletní informace o historii, kultuře a zajímavostech města.\n'
                'Tipy a doporučení: 💡 Doporučení od místních obyvatel a tipy na místa, která byste neměli při návštěvě města minout.\n'
                'Možnost zpětné vazby: 📝 Možnost sdílet své zážitky a hodnocení míst přímo v aplikaci.\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dostupnost',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chytrý upřímný průvodce je aktuálně dostupný ve třech verzích:\n'
                'Android aplikace: 📱 Stáhněte si aplikaci z Google Play Store.\n'
                'Windows aplikace: 💻 Stažení dostupné na stránce Windows Store.\n'
                'Webová stránka: www.example.com pro přístup k aplikaci z libovolného prohlížeče.\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kontakt',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          'Pro více informací o aplikaci nebo pokud máte dotazy, kontaktujte mě na ',
                    ),
                    TextSpan(
                      text: 'emailová adresa',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('mailto:info@example.com');
                        },
                    ),
                    TextSpan(
                      text: ' nebo navštivte mé ',
                    ),
                    TextSpan(
                      text: 'webové stránky.',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('vaclavpi.github.io');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Function that is called when the button is pressed
          // Here you can add the code to navigate back to the homescreen
          BlocProvider.of<AppCubits>(context).goHome();
        },
        backgroundColor: Colors.blue, // Blue color
        child: Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
