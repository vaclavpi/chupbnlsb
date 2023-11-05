import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBoldText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
   AppBoldText({super.key,
   this.size=16,
   required this.text,
   this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color:color,
        fontSize: size,
        fontWeight: FontWeight.bold
      ),
    );
  }
}