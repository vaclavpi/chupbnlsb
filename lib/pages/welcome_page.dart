import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (_, index) {
          return Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/welcome-2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Image.asset(
                  'assets/img/znak.png',
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                              text: "Šikovný průvodce",
                              color: AppColors.fourthColor,
                              size: 25,
                            ),
                            AppBoldText(
                              text: "Brandýsem nad Labem - Starou Boleslaví",
                              color: AppColors.fourthColor,
                              size: 18,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AppText(
                              text:
                                  "Objevte kouzlo Brandýsa nad Labem - Staré Boleslavi s tímto kapesním průvodcem, který Vás provede vybranými místy.",
                              color: Colors.black,
                              size: 18,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context).getData();
                              },
                              child: Container(
                                width: 350,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Align the button to the right
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ResponsiveButton(
                                        width: 200,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
