import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loader'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Text(
                    'Televisa\nUnivision',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      background: Paint()
                        ..shader = LinearGradient(
                          colors: [
                            Color.fromRGBO(228, 19, 141, 0.925),
                            Color.fromRGBO(255, 179, 80, 1),
                          ],
                        ).createShader(Rect.fromLTWH(0, 0, 200.0, 70.0)),
                      foreground: Paint()..color = Colors.transparent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dot(),
                    SizedBox(width: 20),
                    Dot(),
                    SizedBox(width: 20),
                    Dot(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatefulWidget {
  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 1),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Opacity(
        opacity: 0.85,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(228, 19, 141, 0.925),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
