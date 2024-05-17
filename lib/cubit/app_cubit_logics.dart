import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/pages/detail_page.dart';
import 'package:honest_guide/pages/home_page.dart';
import 'package:honest_guide/pages/navpages/map_page.dart';
import 'package:honest_guide/pages/welcome_page.dart';
import 'package:honest_guide/pages/navpages/about_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is DetailState) {
            return const DetailPage();
          }
          if (state is WelcomeState) {
            return const WelcomePage();
          }
          if (state is LoadedState) {
            return const HomePage();
          }
          if (state is AboutPageState) {
            return AboutPage();
          }
          if (state is MapState) {
            return MapPage();
          }
          if (state is LoadingState) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Positioned(
                          top: constraints.maxHeight * 0.005,
                          left: constraints.maxWidth / 2 - 80,
                          child: Image.asset(
                            'assets/img/ckl.png',
                            width: constraints.maxWidth * 0.4,
                          ),
                        );
                      },
                    ),
                    CircularProgressIndicator(
                      color: AppColors.thirdColor,
                    ),
                    SizedBox(height: 20),
                    // Přidejte další vaše Positioned widgety zde podle potřeby
                  ],
                ),
              ),
            );
          }
          return Container(); // Přidejte defaultní stav pro případ, že žádný stav neodpovídá
        },
      ),
    );
  }
}
