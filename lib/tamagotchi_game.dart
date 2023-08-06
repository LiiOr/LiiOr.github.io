import 'package:flutter/material.dart';
import 'dart:async';

class TamagotchiGame extends StatefulWidget {
  @override
  _TamagotchiGameState createState() => _TamagotchiGameState();
}

class _TamagotchiGameState extends State<TamagotchiGame> {
 Timer? gameLoopTimer;

  int foodLevel = 100;
  int happinessLevel = 100;

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  void startGameLoop() {
    gameLoopTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (foodLevel > 0 && happinessLevel > 0) {
          foodLevel -= 10;
          happinessLevel -= 5;
        }
      });
    });
  }

  void feedTamagotchi() {
    setState(() {
      if (foodLevel < 100) {
        foodLevel += 20;
      }
    });
  }

  void playWithTamagotchi() {
    setState(() {
      if (happinessLevel < 100) {
        happinessLevel += 15;
      }
    });
  }

  @override
  void dispose() {
    gameLoopTimer
        ?.cancel(); // Annuler la minuterie avant que le widget soit supprimé
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T A M A G O T C H I'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('rubble.png', height:200.0, fit: BoxFit.contain),
            const SizedBox(height: 30),
            Text(
              'Food Level: $foodLevel',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Happiness Level: $happinessLevel',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            ElevatedButton.icon(
              onPressed: feedTamagotchi,
              label: const Text('Feed'),
              icon: const Icon(Icons.restaurant)
            ),
            const SizedBox(width: 15),
            ElevatedButton.icon(
              onPressed: playWithTamagotchi,
              label: const Text('Play'),
              icon: const Icon(Icons.toys)
            ),
            ]),
          ],
        ),
      ),
    );
  }
}
