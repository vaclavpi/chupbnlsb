import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = ["welcome-1.png", "welcome-2.png", "welcome-3.png",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index){
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/img/"+images[index]
              ),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            margin: const EdgeInsets.only(top:150, left:20, right: 20),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppLargeText(text: "Chytrý průvodce"),
                    AppBoldText(text: "Brandýsem nad Labem", size: 20),
                    AppBoldText(text: "- Starou Boleslaví", size: 20),
                    SizedBox(height: 25,),
                    Container(
                      width: 250,
                      child: AppText(
                        text:"Objevte kouzlo Brnadýsa nad Labem - Staré Boleslavi s Vaším chytrým průvodcem, který Vás provede tajemnými zákoutími této historické perly.",
                        size: 18,),
                    ),
                    SizedBox(height: 40,),
                    GestureDetector(
                      onTap: (){
                        BlocProvider.of<AppCubits>(context).getData();
                      },
                      child: Container(
                        width: 200,
                        child: Row(children:[ResponsiveButton(width: 120,)])),
                    )
                  ],
                ),
                Column(
                  children: List.generate(3, (indexDots){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      width: 8,
                      height: index==indexDots?25:8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index==indexDots?AppColors.fourthColor.withOpacity(1.0):AppColors.fourthColor.withOpacity(0.3),
                      ),
                    );
                  }),
                )
              ],
            )
          ),
        );
      }),
    );
  }
}