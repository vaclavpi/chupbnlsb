import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:icons_flutter/icons_flutter.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({super.key, this.width, this.isResponsive = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Zarovnání k pravé hraně
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.fourthColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Feather.arrow_right,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
