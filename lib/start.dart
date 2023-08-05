import 'package:minijeux/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/main.dart';
import 'package:minijeux/memory_game.dart';
import 'package:minijeux/navbar.dart';
import 'package:minijeux/pong_game.dart';
import 'package:minijeux/snake_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  bool dkSwitchVal = isDark;
  /* Icon darkIcon =
      isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode);*/

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
        child: Container(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(games[index].title.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
        )),
      );
  }
}

class MiniGame {
  final String title;
  final Widget gameWidget;

  MiniGame({required this.title, required this.gameWidget});
}

List<MiniGame> games = [
  MiniGame(title: "Flappy Bird", gameWidget: const FlappyGame()),
  MiniGame(title: "Memory Game", gameWidget: const MemoryGame()),
  MiniGame(title: "Snake Game", gameWidget: const SnakeGame()),
  MiniGame(title: "Pong Game", gameWidget: const PongGame()),
];
