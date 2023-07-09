import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final dynamic barrierWidth;
  final dynamic barrierHeight;
  final dynamic barrierX;
  final bool isThisBottomBarrier;
  
  const MyBarrier({super.key, 
    this.barrierHeight,
    this.barrierWidth,
    required this.isThisBottomBarrier,
    this.barrierX
  });

  @override
  Widget build(BuildContext context) {
   return Container(
    alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth), isThisBottomBarrier? 1 : -1),
    child: Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width * barrierWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2)
    );
  }

}