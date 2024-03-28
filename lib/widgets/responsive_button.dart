import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honest_guide/misc/colors.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({super.key, this.width, this.isResponsive = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // Zarovnání k pravé hraně
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.fourthColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.double_arrow,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
