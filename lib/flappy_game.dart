import 'dart:async';
import 'package:minijeux/character.dart';
import 'package:minijeux/barrier.dart';
import 'package:flutter/material.dart';

class FlappyScreen extends StatefulWidget {
  const FlappyScreen({super.key});

  @override
  State<FlappyScreen> createState() => _FlappyScreenState();
}

class _FlappyScreenState extends State<FlappyScreen> {
  static double characterY = 0;
  double time = 0;
  double height = 0;
  double initialPos = characterY;
  bool gameHasStarted = false;

  int score = 0;
  int highScore = 0;
  late Timer scoreTimer;

  double characterWidth = 0.3;
  double characterHeight = 0.3;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.4;
  List<List<double>> barrierHeight = [
    [0.5, 0.4],
    [0.3, 0.6],
  ];

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = characterY;
    });
  }

  void setInitialValues() {
    setState(() {
      characterY = 0;
      time = 0;
      height = 0;
      initialPos = characterY;
      score = 0;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] += 0.005;
      });
      if (barrierX[i] > 1.5) {
        barrierX[i] -= 3;
      }
    }
  }

  bool isDead() {
    if (characterY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= characterWidth &&
          barrierX[i] + barrierWidth >= -characterWidth &&
          (characterY <= -1 + barrierHeight[i][0] ||
          characterY + characterHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
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
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = -4.9 * time * time + 2.0 * time;
      //height = gravity * time * time + velocity * time
      setState(() {
        characterY = initialPos - height;
      });

      if (isDead()) {
        timer.cancel();
        scoreTimer.cancel();
        gameHasStarted = false;
        if (score > highScore) {
          highScore = score;
        }
        setState(() {});
        showLoseDialog();
      }
      moveMap();
      time += 0.01;
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

  @override
  Widget build(BuildContext context) {
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
                  alignment: Alignment(0, characterY),
                  //color: Colors.blue,
                  child: myCharacter(
                    characterY: characterY,
                    characterWidth: characterWidth,
                    characterHeight: characterHeight,
                  ),
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
                myBarrier(
                  barrierX: barrierX[0],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[0][0],
                  isThisBottomBarrier: false,
                ),
                myBarrier(
                  barrierX: barrierX[0],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[0][1],
                  isThisBottomBarrier: true,
                ),
                myBarrier(
                  barrierX: barrierX[1],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[1][0],
                  isThisBottomBarrier: false,
                ),
                myBarrier(
                  barrierX: barrierX[1],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[1][1],
                  isThisBottomBarrier: true,
                )
              ]),
            ),
            Container(height: 15, color: Colors.green),
            Expanded(
                flex: 1,
                child: Container(
                  //color: Colors.brown,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.brown,
                    ],
                  )),
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
                         /* Text(score.toString(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),*/
                                  Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.pink, size: 90),
                              Text(score.toString(), style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('RECORD',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          const SizedBox(height: 10),
                          /*Text(highScore.toString(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),*/
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.amber, size: 90),
                              Text(highScore.toString(), style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
                            ],
                          )
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
