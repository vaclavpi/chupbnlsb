import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(
                        text: "Prozkoumej",
                        size: 35,
                        color: AppColors.fourthColor,
                      ),
                      AppBoldText(
                        text: "Brandýs nad Labem-Starou Boleslav",
                        size: 16,
                        color: AppColors.fourthColor,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/img/logoTB.png',
                    width: 107,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Akce po kliknutí na tlačítko
                },
                child: Text('Přihlásit se'),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('O aplikaci'),
              onTap: () {
                // Navigate to another screen
                launch('https://github.com/vaclavpi/chupbnlsb/');
              },
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Nahlášení chyby nebo tip na vylepšení'),
              onTap: () {
                // Navigate to another screen
                launch('https://github.com/vaclavpi/chupbnlsb/issues');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Přidat nové místo'),
              onTap: () {
                // Navigate to another screen
                launch('https://github.com/vaclavpi/chupbnlsb/issues');
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Stránky vývojáře'),
              onTap: () {
                // Navigate to another screen
                launch('https://vaclavpi.github.io/');
              },
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('Podmínky služby'),
              onTap: () {
                // Akce po kliknutí na položku
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Ochrana osobních údajů'),
              onTap: () {
                // Akce po kliknutí na položku
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Dárkové poukazy'),
              onTap: () {
                // Akce po kliknutí na položku
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: 3,
            onTap: (int index) {
              final appCubits = BlocProvider.of<AppCubits>(context);
              if (index == 0) {
                appCubits.goHome();
              } else if (index == 1) {
                appCubits.MapPage();
              } else if (index == 2) {
                appCubits.MapPage();
              } else if (index == 3) {
                appCubits.goAbout();
              }
            },
            selectedItemColor: AppColors.fourthColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.place,
                  color: AppColors.thirdColor,
                ),
                label: 'Místa',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                  color: AppColors.thirdColor,
                ),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.thirdColor,
                ),
                label: 'Oblíbené',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.more_horiz,
                  color: AppColors.thirdColor,
                ),
                label: 'Více',
              ),
            ],
          );
        },
      ),
    );
  }
}
