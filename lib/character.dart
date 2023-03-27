import 'package:flutter/material.dart';

class myCharacter extends StatelessWidget {
  myCharacter({super.key});

  //final characterpos = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
     // key: characterpos,
      height: 100,
      width: 100,
      child: Image.asset('skye.png')
    );
  }


}