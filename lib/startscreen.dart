import 'dart:math';

import 'package:flappypatrol/flappy_game.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.gamepad),
        title: Text('Mini jeux pour bébé Lilou'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple,
              Colors.pink,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const FlappyScreen(),
                        ));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: Text('Flappy Game',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.favorite, color: Colors.white, size: 10),
            Text(' Made with love by LD ', style: TextStyle(color: Colors.white)),
            Icon(Icons.favorite, color: Colors.white, size: 10),
          ]) //&#10084;
          ),
    );
  }
}
