import 'package:flutter/material.dart';

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
    @override
  Widget build(BuildContext context) {
  return Scaffold(appBar: AppBar(
          title: const Text('T E T R I S'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
    body: const Center(child: Text('Coming soon.. :)')));
  }
}