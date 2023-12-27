import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mylabs/games/scores.dart';

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
          content: Text('Bravo, tu as marqué $score points ! Veux tu rejouer?',
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
  void dispose() {
    var scoreboard = GameScore(game: 'FLAPPY', score: score, highScore: highScore);
    scoreboard.setScore();
    super.dispose();
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
            Container(
                height: 30,
                //color: Colors.brown,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.brown,
                  ],
                ))),
            GameScore(game: 'FLAPPY', score: score, highScore: highScore),
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

  const MyBarrier(
      {super.key,
      this.barrierHeight,
      this.barrierWidth,
      required this.isThisBottomBarrier,
      this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
            isThisBottomBarrier ? 1 : -1),
        child: Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width * barrierWidth / 2,
            height: MediaQuery.of(context).size.height *
                3 /
                4 *
                barrierHeight /
                2));
  }
}

class MyCharacter extends StatelessWidget {
  final dynamic characterY;
  final double characterWidth;
  final double characterHeight;

  const MyCharacter(
      {super.key,
      this.characterY,
      required this.characterWidth,
      required this.characterHeight});

  //final characterpos = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.blue,
            ],
          ),
        ),
        alignment: Alignment(
            0, (2 * characterY + characterHeight) / (2 - characterHeight)),
        child: Image.asset('assets/skye.png',
      width: MediaQuery.of(context).size.height * characterWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * characterHeight / 2,
      fit: BoxFit.fill
      )
        /*child: Container(
          color: Colors.pink,
          width: MediaQuery.of(context).size.height * characterWidth / 2,
          height:
              MediaQuery.of(context).size.height * 3 / 4 * characterHeight / 2,
          child: Text(characterY.toString()),
        )*/);
  }
}
/*import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlappyGame extends StatefulWidget {
  const FlappyGame({Key? key}) : super(key: key);

  @override
  _FlappyGameState createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyGame> {
  double characterY = 0;
  double time = 0;
  bool isJumping = false;
  bool isGameOver = false;
  int score = 0;
  int highScore = 0;

  List<Obstacle> obstacles = [];
  double obstacleSpacing = 2;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      characterY = 0;
      time = 0;
      isJumping = false;
      isGameOver = false;
      score = 0;
      obstacles.clear();
    });

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (isGameOver) {
        timer.cancel();
        if (score > highScore) {
          highScore = score;
        }
        showLoseDialog();
        return;
      }

      moveCharacter();
      moveObstacles();
      checkCollisions();
      updateScore();
    });
  }

  void moveCharacter() {
    setState(() {
      if (isJumping) {
        time = 0;
      }
      characterY = 1 - 4.9 * time * time + 2.0 * time;
    });
  }

  void moveObstacles() {
    for (int i = 0; i < obstacles.length; i++) {
      setState(() {
        obstacles[i].x -= 0.005;
      });
      if (obstacles[i].x < -0.2) {
        obstacles[i] = generateObstacle();
      }
    }
  }

  void jump() {
    if (!isJumping) {
      setState(() {
        isJumping = true;
        time = 1.2;
      });
    }
  }

  Obstacle generateObstacle() {
    double topHeight = Random().nextDouble() * 0.6 + 0.1;
    double bottomHeight = 1 - topHeight - obstacleSpacing;
    return Obstacle(1.5, topHeight, bottomHeight);
  }

  void checkCollisions() {
    for (Obstacle obstacle in obstacles) {
      if (characterY < obstacle.topHeight ||
          characterY > 1 - obstacle.bottomHeight) {
        if (obstacle.x < characterWidth && obstacle.x + barrierWidth > 0) {
          setState(() {
            isGameOver = true;
          });
          return;
        }
      }
    }
  }

  void updateScore() {
    for (Obstacle obstacle in obstacles) {
      if (obstacle.x + barrierWidth < -characterWidth) {
        setState(() {
          score++;
        });
      }
    }
  }

  void showLoseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Score: $score\nHigh Score: $highScore'),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isGameOver) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flappy Bird'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(0, characterY),
                    duration: const Duration(milliseconds: 0),
                    child: MyCharacter(),
                  ),
                  for (Obstacle obstacle in obstacles) ...[
                    MyBarrier(
                      x: obstacle.x,
                      topHeight: obstacle.topHeight,
                      bottomHeight: obstacle.bottomHeight,
                    ),
                  ],
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Container(
              height: 30,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.brown,
                  ],
                ),
              ),
            ),
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Score: $score'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('High Score: $highScore'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBarrier extends StatelessWidget {
  final double x;
  final double topHeight;
  final double bottomHeight;

  const MyBarrier({
    Key? key,
    required this.x,
    required this.topHeight,
    required this.bottomHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, 0),
      child: Column(
        children: [
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width * barrierWidth / 2,
            height:
                MediaQuery.of(context).size.height * topHeight / 2,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width * barrierWidth / 2,
            height:
                MediaQuery.of(context).size.height * bottomHeight / 2,
          ),
        ],
      ),
    );
  }
}

class MyCharacter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * characterWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * characterHeight / 2,
      color: Colors.blue,
    );
  }
}

class Obstacle {
  double x;
  double topHeight;
  double bottomHeight;

  Obstacle(this.x, this.topHeight, this.bottomHeight);
}

double characterWidth = 0.1;
double characterHeight = 0.1;
double barrierWidth = 0.2;*/