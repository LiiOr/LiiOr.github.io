import 'dart:async';
//import 'dart:ffi';
import 'dart:math';

import 'package:flappypatrol/character.dart';
import 'package:flappypatrol/obstacle.dart';
import 'package:flutter/material.dart';

class FlappyScreen extends StatefulWidget {
  const FlappyScreen({super.key});

  @override
  State<FlappyScreen> createState() => _FlappyScreenState();
}

class _FlappyScreenState extends State<FlappyScreen> {
  static double yPosCharacter = 0;
  double time = 0;
  double height = 0;
  double initialHeight = yPosCharacter;
  bool gameHasStarted = false;
  int score = 0;
  int highScore = 0;
  late Timer scoreTimer;
  Random randomNumber = new Random();
  /* Obstacles */
  //double upperbarrierOneHeight = 0.0;
  double lowerBarrierOneHeight = 0.0;
  //double upperbarrierTwoHeight = 0.0;
  double lowerBarrierTwoHeight = 0.0;
  static double xPosObstacle = 0;
  double obstacle2 = xPosObstacle + 2;
  late double rand;

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yPosCharacter;
    });
  }

  void setInitialValues() {
    setState(() {
      yPosCharacter = 0;
      time = 0;
      height = 0;
      initialHeight = yPosCharacter;
      score = 0;
      xPosObstacle = -2.5;
      obstacle2 = xPosObstacle + 2;
      rand = randomNumber.nextDouble() * 7;
    });
  }

  void startGame() {
    gameHasStarted = true;
    setInitialValues();
    scoreTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (gameHasStarted) {
          setState(() {
            score++;
          });
        }
      },
    );
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.0 * time;
      //height = gravity * time * time + velocity * time
      setState(() {
        yPosCharacter = initialHeight - height;

        if (xPosObstacle > 2) {
          xPosObstacle -= 3.5;
        } else {
          xPosObstacle += 0.05;
        }
        if (obstacle2 > 2) {
          obstacle2 -= 3.5;
        } else {
          obstacle2 += 0.05;
        }
      });
      if (yPosCharacter > 1.1) {
        // si le personnage a touché le sol
        gameHasStarted = false;
        timer.cancel();
        scoreTimer.cancel();
        if (score > highScore) {
          highScore = score;
        }
        setState(() {});
        showLoseDialog();
      }
      // si l'axe X est au centre comme le personnage

      if (xPosObstacle >= -0.20 && xPosObstacle <= 0.20) {
        // si le personnage est sur le l'axe Y de l'obstacle
        if (yPosCharacter >= 0.8) {
          timer.cancel();
          scoreTimer.cancel();
          gameHasStarted = false;
          if (score > highScore) {
            highScore = score;
          }
          setState(() {});
          showLoseDialog();
        }
      }
    });
  }

  Future<void> showLoseDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink[800],
          title: const Text('G A M E  O V E R',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text(
              'Bravo, tu as marqué ${score} points ! Veux tu rejouer?',
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Retour au menu',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('REJOUER',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setInitialValues();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  //double random = Random(10) as double;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    lowerBarrierOneHeight = screenHeight / 2.5;
    lowerBarrierTwoHeight = screenHeight / 5;
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flappy Game'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Stack(children: [
                AnimatedContainer(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Colors.blue,
                    ],
                  )),
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(0, yPosCharacter),
                  //color: Colors.blue,
                  child: myCharacter(),
                ),
                Container(
                  alignment: const Alignment(0, 0.3),
                  child: gameHasStarted
                      ? const Text('')
                      : const Text(
                          'CLIQUE POUR JOUER',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 0),
                  alignment: Alignment(xPosObstacle, rand),
                  child: myObstacle(size: lowerBarrierOneHeight),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 0),
                  alignment: Alignment(obstacle2, rand),
                  child: myObstacle(size: lowerBarrierTwoHeight),
                ),
              ]),
            ),
            Container(height: 15, color: Colors.green),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('SCORE',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          const SizedBox(height: 10),
                          Text(score.toString(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('BEST',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          const SizedBox(height: 10),
                          Text(highScore.toString(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
