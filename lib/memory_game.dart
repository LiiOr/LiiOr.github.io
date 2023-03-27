import 'dart:async';
import 'dart:html';
import 'package:minijeux/character.dart';
import 'package:flutter/material.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  int score = 0;
  int highScore = 0;
  final List<IconData> icons = [
        Icons.anchor,
        Icons.door_back_door,
        Icons.favorite,
        Icons.airplanemode_on,
        Icons.alarm,
        Icons.person,
        Icons.light_mode_outlined,
        Icons.star,
        Icons.headset_rounded,
        Icons.delete,
        Icons.audiotrack_rounded,
        Icons.visibility,
        Icons.beach_access_rounded,
        Icons.downhill_skiing_rounded,
        Icons.directions_bike_rounded,
        Icons.directions_boat_rounded,
        Icons.lunch_dining_rounded,
        Icons.restaurant,
        Icons.shopping_cart_rounded,
        Icons.sports_esports_rounded,
      ];
  
  @override
  void initState() {
    super.initState();
  }

  
  Future<void> showLoseDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink[800],
          title: const Text('G A M E  O V E R',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Text(
              'Bravo, tu as marqué ${score} points ! Veux tu rejouer?',
              style: const TextStyle(color: Colors.white)),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Retour au menu',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('REJOUER',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                   // setInitialValues();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Memory'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex:2,
              child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
              children: List.generate(icons.length, (index) {
                return Card(
                  color: Colors.pink,
                  child: Icon(Icons.question_mark, color: Colors.white)
                  //child: Icon(icons[index], color: Colors.white),
                  
                );
              })),
            ),
            Expanded(
              flex: 1,
                child: Container(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('SCORE',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          const SizedBox(height: 10),
                                  Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.pink, size: 90),
                              Text(score.toString(), style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('RECORD',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          const SizedBox(height: 10),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.favorite, color: Colors.amber, size: 90),
                              Text(highScore.toString(), style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ]
        ),
    );
  }
}
