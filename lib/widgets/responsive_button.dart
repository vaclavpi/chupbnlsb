import 'package:flutter/material.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ResponsiveButton extends StatelessWidget {
  final bool isResponsive;
  final double? width;

  const ResponsiveButton({
    Key? key,
    required this.isResponsive,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Zarovnání k pravé hraně
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        style: ButtonStyle(
          fixedSize: isResponsive
              ? null
              : MaterialStateProperty.all<Size>(
                  Size(width ?? 200, 60),
                ),
          backgroundColor: MaterialStateProperty.all<Color>(
            AppColors.fourthColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
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
