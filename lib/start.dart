import 'dart:math';

import 'package:minijeux/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/main.dart';
import 'package:minijeux/memory_game.dart';
import 'package:minijeux/pong_game.dart';
import 'package:minijeux/snake_game.dart';
import 'package:minijeux/tetris_game.dart';
import 'package:minijeux/tictactoe_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {

  setTheme(val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('darkmode', val);
      isDark = val;
      isDark
          ? MyApp.of(context).changeTheme(ThemeMode.dark)
          : MyApp.of(context).changeTheme(ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
               Color randomColor = generateCardColor(index);
              return Card(
                color: randomColor,
                child: ListTile(
                  leading: games[index].icon,
                  title: Text(games[index].title.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              games[index].gameWidget,
                        ));
                  },
                ),
              );
            },
            itemCount: games.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          )
        ],
          ),
        ),
      );
  }
}

class MiniGame {
  final String title;
  final Widget gameWidget;
  final Icon? icon;

  MiniGame({required this.title, required this.gameWidget, this.icon});
}

List<MiniGame> games = [
  MiniGame(title: "M E M O R Y", gameWidget: const MemoryGame(), icon: Icon(Icons.memory, color: Colors.white)),
  MiniGame(title: "S N A K E", gameWidget: const SnakeGame(), icon: Icon(Icons.turn_right, color: Colors.white)),
  MiniGame(title: "P O N G", gameWidget: const PongGame(), icon: Icon(Icons.sports_tennis, color: Colors.white)),
  MiniGame(title: "F L A P P Y", gameWidget: const FlappyGame(), icon: Icon(Icons.flight, color: Colors.white)),
  MiniGame(title: "T I C  T A C  T O E", gameWidget: TicTacToeGame(), icon: Icon(Icons.close, color: Colors.white)),
  MiniGame(title: "T E T R I S", gameWidget: const TetrisGame(), icon: Icon(Icons.sort, color: Colors.white)),
];


Color generateCardColor(index) {
  final List<Color> customColors = [
    Colors.red,
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.purple,
  ];
  return customColors[index].withOpacity(0.5);
}