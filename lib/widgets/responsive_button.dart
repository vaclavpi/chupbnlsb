import 'package:flutter/cupertino.dart';
import 'package:honest_guide/misc/colors.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({super.key, this.width, this.isResponsive=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.fourthColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/img/button-arrow.png"),
        ],
      ),
    );
  }
}