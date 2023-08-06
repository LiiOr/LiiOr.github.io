import 'dart:async';
import 'package:flutter/material.dart';

class FlappyGame extends StatefulWidget {
  const FlappyGame({super.key});

  @override
  State<FlappyGame> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyGame> {
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
    Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      height = -4.9 * time * time + 2.0 * time;
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
        //await Future.delayed(const Duration(seconds: 2));
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
              'Bravo, tu as marqué $score points ! Veux tu rejouer?',
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
          title: const Text('F L A P P Y'),
          backgroundColor: Theme.of(context).primaryColor,
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
                  child: MyCharacter(
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
                MyBarrier(
                  barrierX: barrierX[0],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[0][0],
                  isThisBottomBarrier: true,
                ),
                MyBarrier(
                  barrierX: barrierX[0],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[0][1],
                  isThisBottomBarrier: false,
                ),
                MyBarrier(
                  barrierX: barrierX[1],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[1][0],
                  isThisBottomBarrier: true,
                ),
                MyBarrier(
                  barrierX: barrierX[1],
                  barrierWidth: barrierWidth,
                  barrierHeight: barrierHeight[1][1],
                  isThisBottomBarrier: false,
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
                                  Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.favorite, color: Colors.pink, size: 90),
                              Text(score.toString(), style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
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
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.favorite, color: Colors.amber, size: 90),
                              Text(highScore.toString(), style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
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
      child: Image.asset('assets/skye.png',
      width: MediaQuery.of(context).size.height * characterWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * characterHeight / 2,
      fit: BoxFit.fill
      )
    );
  }
}