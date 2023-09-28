import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';
import 'package:minijeux/scores.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  List<Offset> snake = [const Offset(100, 100)];
  Offset food = const Offset(200, 200);
  Direction direction = Direction.right;
  double gestureDetectorHeight = 0.0;
  int score = 0;
  int highScore = 0;

  Timer? gameLoopTimer;

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  void startGameLoop() {
    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      moveSnake();
      checkCollisions();
    });
  }

  @override
  void dispose() {
    var scoreboard = Scoreboard(score: score, highScore: highScore);
    scoreboard.setScore();
    //score = snake.length;
    gameLoopTimer
        ?.cancel(); // Annuler la minuterie avant que le widget soit supprimé
    super.dispose();
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snake.insert(0, Offset(snake.first.dx, snake.first.dy - 20));
          break;
        case Direction.down:
          snake.insert(0, Offset(snake.first.dx, snake.first.dy + 20));
          break;
        case Direction.left:
          snake.insert(0, Offset(snake.first.dx - 20, snake.first.dy));
          break;
        case Direction.right:
          snake.insert(0, Offset(snake.first.dx + 20, snake.first.dy));
          break;
      }
      if (snake.first != food) {
        snake.removeLast();
      } else {
        score++;
        generateFood();
      }
    });
  }

  void generateFood() {
    final random = Random();
    int x = random.nextInt(18) * 20;
    int y = random.nextInt(30) * 20;
    /*int x = random.nextInt(screenWidth as int);
    int y = random.nextInt(screenHeight - AppBar().preferredSize.height as int);
    print('screenWidth : $screenWidth');
    print('screenHeigth: $screenHeight');
    print(x.toString() +','+ y.toString());*/
    setState(() {
      food = Offset(x.toDouble(), y.toDouble());
    });
  }

  void checkCollisions() {
    if (snake.first.dx < 0 ||
        snake.first.dx >= screenWidth ||
        snake.first.dy < 0 ||
        snake.first.dy >= (gestureDetectorHeight) ||
        snake.sublist(1).contains(snake.first)) {
      setState(() {
        snake = [const Offset(100, 100)];
        if (highScore < score) highScore = score;
        score = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S N A K E'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                gestureDetectorHeight = constraints.maxHeight;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onVerticalDragUpdate: (details) {
                    if (direction != Direction.up && details.delta.dy > 0) {
                      direction = Direction.down;
                    } else if (direction != Direction.down &&
                        details.delta.dy < 0) {
                      direction = Direction.up;
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (direction != Direction.left && details.delta.dx > 0) {
                      direction = Direction.right;
                    } else if (direction != Direction.right &&
                        details.delta.dx < 0) {
                      direction = Direction.left;
                    }
                  },
                  child: SizedBox(
                    child: Stack(
                      children: [
                        Positioned(
                          left: food.dx,
                          top: food.dy,
                          child: Container(
                            width: 20,
                            height: 20,
                            color: Colors.brown,
                          ),
                        ),
                        ...snake.map(
                          (pos) => Positioned(
                            left: pos.dx,
                            top: pos.dy,
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          BottomAppBar(
              child: Scoreboard(score: score, highScore: highScore,)),
        ],
      ),
    );
  }
}

enum Direction { up, down, left, right }
