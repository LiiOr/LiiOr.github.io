import 'package:flutter/material.dart';

class MyCharacter extends StatelessWidget {
  final dynamic characterY;
  final double characterWidth;
  final double characterHeight;

  const MyCharacter({super.key, 
    this.characterY,
    required this.characterWidth,
    required this.characterHeight
  });

  //final characterpos = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * characterY + characterHeight) / ( 2 - characterHeight)),
      child: Image.asset('skye.png',
      width: MediaQuery.of(context).size.height * characterWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * characterHeight / 2,
      fit: BoxFit.fill
      )
    );
  }
}