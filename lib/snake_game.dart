import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  List<Offset> snake = [const Offset(100, 100)];
  Offset food = const Offset(200, 200);
  Direction direction = Direction.right;

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
        generateFood();
      }
    });
  }

  void generateFood() {
    final random = Random();
    int x = random.nextInt(20) * 20;
    int y = random.nextInt(30) * 20;
    setState(() {
      food = Offset(x.toDouble(), y.toDouble());
    });
  }

  void checkCollisions() {
    if (snake.first.dx < 0 ||
        snake.first.dx >= screenWidth ||
        snake.first.dy < 0 ||
        snake.first.dy >= screenHeight ||
        snake.sublist(1).contains(snake.first)) {
      setState(() {
        snake = [const Offset(100, 100)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: (details) {
          if (direction != Direction.up && details.delta.dy > 0) {
            direction = Direction.down;
          } else if (direction != Direction.down && details.delta.dy < 0) {
            direction = Direction.up;
          }
        },
        onHorizontalDragUpdate: (details) {
          if (direction != Direction.left && details.delta.dx > 0) {
            direction = Direction.right;
          } else if (direction != Direction.right && details.delta.dx < 0) {
            direction = Direction.left;
          }
        },
        child: Container(
         /* decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 1, 31, 2),
                      Color.fromARGB(255, 14, 87, 16),
                    ],
                  )),*/
          height: screenHeight - AppBar().preferredSize.height,
          child: Stack(
            children: [
              Positioned(
                left: food.dx,
                top: food.dy,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
              ),
              ...snake.map(
                (pos) => Positioned(
                  left: pos.dx,
                  top: pos.dy,
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Direction { up, down, left, right }
