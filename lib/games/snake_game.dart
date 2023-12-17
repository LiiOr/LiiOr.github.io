import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minijeux/globals.dart';
import 'package:minijeux/games/scores.dart';

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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
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
    var scoreboard =
        GameScore(game: 'SNAKE', score: score, highScore: highScore);
    scoreboard.setScore();
    _focusNode.dispose();
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
    double appBarHeight = AppBar().preferredSize.height;
    double bottomBarHeight =
        kBottomNavigationBarHeight; // Default bottom bar height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double usableHeight = screenHeight - appBarHeight - bottomBarHeight;
    final random = Random();

    // Ensure that the food's position is a multiple of 20 and within the screen bounds
    int x = (random.nextInt((screenWidth / 20).floor()) * 20).toInt();
    int y = (random.nextInt((usableHeight / 20).floor()) * 20).toInt();

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

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.runtimeType.toString() == 'RawKeyDownEvent') {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
          direction != Direction.down) {
        direction = Direction.up;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
          direction != Direction.up) {
        direction = Direction.down;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
          direction != Direction.right) {
        direction = Direction.left;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          direction != Direction.left) {
        direction = Direction.right;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    double bottomBarHeight =
        kBottomNavigationBarHeight;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double usableHeight = screenHeight - appBarHeight - bottomBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('S N A K E'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        autofocus: true,
        child: Column(
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
            GameScore(game: 'SNAKE', score: score, highScore: highScore),
          ],
        ),
      ),
    );
  }
}

enum Direction { up, down, left, right }
