import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylabs/globals.dart';
import 'package:mylabs/games/scores.dart';

class PongGame extends StatefulWidget {
  const PongGame({super.key});

  @override
  State<PongGame> createState() => _PongGameState();
}

class _PongGameState extends State<PongGame> {
  double ballX = 200;
  double ballY = 300;
  double ballSpeedX = 2;
  double ballSpeedY = 2;

  double paddleX = 180;
  double paddleY = 500;
  double paddleWidth = 100;

  int score = 0;
  int highScore = 0;

  Timer? gameLoopTimer;

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }

  void startGameLoop() {
    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      updateGame();
    });
  }

  void updateGame() {
    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;

      if (ballX <= 0 || ballX >= screenWidth) {
        ballSpeedX = -ballSpeedX;
      }

      if (ballY <= 0 || ballY >= screenHeight - 50) {
        ballSpeedY = -ballSpeedY;
      }

      if (ballY >= paddleY - 10 &&
          ballX >= paddleX &&
          ballX <= paddleX + paddleWidth) {
        ballSpeedY = -ballSpeedY;
        score++;
        if (score > highScore) {
          highScore = score;
          var scoreboard =
              GameScore(game: 'PONG', score: score, highScore: highScore);
          scoreboard.setScore();
        }
      }
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      paddleX += details.delta.dx;
      if (paddleX < 0) {
        paddleX = 0;
      } else if (paddleX > screenWidth - paddleWidth) {
        paddleX = screenWidth - paddleWidth;
      }
    });
  }

  void movePaddle(double dx) {
  setState(() {
    paddleX += dx;
    if (paddleX < 0) {
      paddleX = 0;
    } else if (paddleX > screenWidth - paddleWidth) {
      paddleX = screenWidth - paddleWidth;
    }
  });
}

  @override
  void dispose() {
    gameLoopTimer?.cancel();
    var scoreboard =
        GameScore(game: 'PONG', score: score, highScore: highScore);
    scoreboard.setScore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P O N G'),
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            movePaddle(10.0);
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            movePaddle(-10.0);
          }
        }
      },
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragUpdate: onDragUpdate,
                child: Stack(
                  children: [
                    Positioned(
                      left: ballX,
                      top: ballY,
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.yellow,
                      ),
                    ),
                    Positioned(
                      left: paddleX,
                      top: paddleY,
                      child: Container(
                        width: paddleWidth,
                        height: 20,
                        color: Colors.pink[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GameScore(game: 'PONG', score: score, highScore: score)
          ],
        ),
      ),
    );
  }
}
