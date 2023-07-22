import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startGameLoop();
    });
  }

  void startGameLoop() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 10));
      updateGame();
      return true;
    });
  }

  void updateGame() {
    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;

      if (ballX <= 0 || ballX >= 400) {
        ballSpeedX = -ballSpeedX;
      }

      if (ballY <= 0 || ballY >= 600) {
        ballSpeedY = -ballSpeedY;
      }

      if (ballY >= paddleY - 10 && ballX >= paddleX && ballX <= paddleX + paddleWidth) {
        ballSpeedY = -ballSpeedY;
      }
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      paddleX += details.delta.dx;
      if (paddleX < 0) {
        paddleX = 0;
      } else if (paddleX > 400 - paddleWidth) {
        paddleX = 400 - paddleWidth;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pong Game'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: onDragUpdate,
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned(
                left: ballX,
                top: ballY,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: paddleX,
                top: paddleY,
                child: Container(
                  width: paddleWidth,
                  height: 10,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
