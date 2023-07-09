
import 'package:minijeux/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/memory_game.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final deviceHeight = MediaQuery.of(context).size.height;
   // final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.gamepad),
        title: const Text('Mini jeux pour bébé'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const FlappyScreen(),
                        ));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: const Text('Flappy Stella',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MemoryScreen(),
                        ));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: const Text('Memory',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
          color: Colors.black,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.favorite, color: Colors.white, size: 10),
            Text(' Made with love by LD ', style: TextStyle(color: Colors.white)),
            Icon(Icons.favorite, color: Colors.white, size: 10),
          ]) //&#10084;
          ),
    );
  }
}
