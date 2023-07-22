
import 'package:minijeux/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/main.dart';
import 'package:minijeux/memory_game.dart';
import 'package:minijeux/pong_game.dart';
import 'package:minijeux/snake_game.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static List<Widget> games = [
    const FlappyGame(),
    const MemoryGame(),
    const SnakeGame(),
    const PongGame()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.gamepad),
        title: const Text('Mini games for babies'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.dark_mode),
          )
        ],
      ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(' Version $numVersion ', style: const TextStyle(color: Colors.white)),
          ]) //&#10084;
          ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.purple,
              Colors.pink,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                    title: Text(games[index].toString(), style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                games[index],
                          ));
                    },
                                  ),
                  );
                }, itemCount: games.length, separatorBuilder: (BuildContext context, int index) { return const Divider(); },)
            ],
          ),
        )),
      ),
    );
  }
}
