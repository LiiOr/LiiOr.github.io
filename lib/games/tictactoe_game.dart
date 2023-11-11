import 'package:flutter/material.dart';
import 'dart:math';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = [];
  String currentPlayer = "";
  String computer ="";
  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    board = List.generate(3, (_) => List.generate(3, (_) => ''));
    currentPlayer = 'X';
    computer = 'O';
    gameEnded = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && !checkWin(currentPlayer) && !checkWin(computer)) {
      setState(() {
        board[row][col] = currentPlayer;
        if (!checkWin(currentPlayer) && !checkWin(computer)) {
          computerMove();
        }
      });
    }
  }

  void computerMove() {
    List<int> availableMoves = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          availableMoves.add(i * 3 + j);
        }
      }
    }

    if (availableMoves.isNotEmpty) {
      int randomIndex = Random().nextInt(availableMoves.length);
      int move = availableMoves[randomIndex];
      int row = move ~/ 3;
      int col = move % 3;

      setState(() {
        board[row][col] = computer;
      });
    }
  }

   bool checkWin(String player) {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
      if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
        return true;
      }
    }
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
      return true;
    }
    return false;
  }

  Widget buildTile(int row, int col) {
    return GestureDetector(
      onTap: () {
        makeMove(row, col);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        alignment: Alignment.center,
        child: Text(
          board[row][col],
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }

  /*@override
  void dispose() {
    gameLoopTimer?.cancel(); 
    var scoreboard = GameScore(game: 'MEMORY', score: score, highScore: highScore);
    scoreboard.setScore();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int row = 0; row < 3; row++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int col = 0; col < 3; col++)
                    buildTile(row, col),
                ],
              ),
            SizedBox(height: 20.0),
            if (gameEnded)
              Text(
                'Player $currentPlayer wins!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startNewGame();
        },
        child: Icon(Icons.refresh),
      ),
    );*/
  return Scaffold(appBar: AppBar(
          title: const Text('T I C  T A C  T O E'),
        ),
    body: const Center(child: Text('Coming soon.. :)')));
  }
}
