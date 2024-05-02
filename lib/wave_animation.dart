import 'dart:async';
import 'package:flutter/material.dart';

class CarAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  CarAnimation({required this.child, required this.duration});

  @override
  _CarAnimationState createState() => _CarAnimationState();
}

class _CarAnimationState extends State<CarAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // Iniciar la animación
    _controller.repeat(reverse: true);

    // Detener la animación en un punto específico
    Timer(Duration(seconds: widget.duration.inSeconds ~/ 2), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: Transform.translate(
              offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0.0),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Animation Example'),
      ),
      body: Center(
        child: Column(
          children: [
            CarAnimation(
              duration: Duration(seconds: 5), // Duración total de la animación
              child: Image.asset('assets/car.png'), // Reemplaza esto con la imagen de un auto
            ),
            Text(
              'EXPRESS PARKING',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
