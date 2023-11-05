import 'package:flutter/material.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key});

  _launchCoffeeWebsite() async {
    const url = 'https://buymeacoffee.com/vapi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/bmc_qr.png', 
              width: 200,
              height: 200, 
            ),
            SizedBox(height: 16),
            Text(
              "Podpořte vývoj aplikace 😉",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchCoffeeWebsite,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fourthColor, // Barva tlačítka
              ),
              child: Text("Chci podpořit!", style: TextStyle(fontSize: 24),),
            ),
          ],
        ),
      ),
    );
  }
}
