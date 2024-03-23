import 'package:flutter/material.dart';

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {

  
  /*@override
  void dispose() {
    gameLoopTimer?.cancel(); 
    var scoreboard = GameScore(game: 'MEMORY', score: score, highScore: highScore);
    scoreboard.setScore();
    super.dispose();
  }*/

    @override
  Widget build(BuildContext context) {
  return Scaffold(appBar: AppBar(
          title: const Text('T E T R I S'),
        ),
    body: const Center(child: Text('Coming soon.. :)')));
  }
}