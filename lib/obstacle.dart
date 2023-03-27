import 'package:flutter/material.dart';

class myObstacle extends StatelessWidget {
  final double size;
  const myObstacle({required this.size});

  @override
  Widget build(BuildContext context) {
   return Container(
    width: 100,
    height: size,
    decoration: BoxDecoration(
      color: Colors.green,
      border: Border.all(
          width: 4,
          color: Colors.brown,
        ),
      ),
    );
  }

}