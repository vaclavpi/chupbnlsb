import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  AppText({
    Key? key,
    required this.text,
    this.color = Colors.white70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / 375; // Zde 375 je referenční šířka

    // Upravíme velikost textu na základě šířky displeje
    double adjustedSize = 16 * scaleFactor;

    return Text(
      text,
      style: TextStyle(
        fontFamily: "BB-UttaraGrotesk",
        color: color,
        fontWeight: FontWeight.w200,
        fontSize: adjustedSize,
      ),
    );
  }
}
