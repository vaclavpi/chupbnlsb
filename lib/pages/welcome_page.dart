import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/responsive_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return PageView.builder(
            physics:
                NeverScrollableScrollPhysics(), // Prevent vertical scrolling
            itemBuilder: (_, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/welcome.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.005, // Adjust as needed
                    left: constraints.maxWidth / 2 - 100,
                    child: Image.asset(
                      'assets/img/ckl.png',
                      width: 200,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: constraints.maxHeight / 3,
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
                                  text: "Brandýsem nad Labem-Starou Boleslaví",
                                  color: AppColors.fourthColor,
                                  size: 18,
                                ),
                                SizedBox(height: 15),
                                AppText(
                                  text:
                                      "Objevte kouzlo  Brandýsa nad Labem-Staré Boleslavi s tímto kapesním průvodcem, který Vás provede vybranými místy.",
                                  color: Colors.black,
                                  size: 18,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<AppCubits>(context)
                                        .getData();
                                  },
                                  child: Container(
                                    width: constraints.maxWidth *
                                        0.5, // Adjust as needed
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ResponsiveButton(
                                          width: constraints.maxWidth *
                                              0.5, // Adjust as needed
                                        ),
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
          );
        },
      ),
    );
  }
}
