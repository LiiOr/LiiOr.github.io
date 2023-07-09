import 'dart:async';
import 'package:flutter/material.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  int tries  = 0;
  int score = 0;
  int highScore = 0;
  List<Icon>? listImg;
  final List<Icon> icons = [
        //Icons.anchor,
        const Icon(Icons.restaurant, color: Colors.white),
        const Icon(Icons.favorite, color: Colors.white),
        const Icon(Icons.airplanemode_on, color: Colors.white),
        const Icon(Icons.alarm, color: Colors.white),
        const Icon(Icons.person, color: Colors.white),
        const Icon(Icons.light_mode_outlined, color: Colors.white),
        const Icon(Icons.star, color: Colors.white),
        const Icon(Icons.headset_rounded, color: Colors.white),
        const Icon(Icons.directions_bike_rounded,color: Colors.white),
        const Icon(Icons.anchor, color: Colors.white),
        const Icon(Icons.anchor, color: Colors.white),
        const Icon(Icons.restaurant, color: Colors.white),
        const Icon(Icons.favorite, color: Colors.white),
        const Icon(Icons.airplanemode_on, color: Colors.white),
        const Icon(Icons.alarm, color: Colors.white),
        const Icon(Icons.person, color: Colors.white),
        const Icon(Icons.light_mode_outlined, color: Colors.white),
        const Icon(Icons.star, color: Colors.white),
        const Icon(Icons.headset_rounded, color: Colors.white),
        const Icon(Icons.directions_bike_rounded,color: Colors.white),   
      ];
  List<Map<int, Icon>> matchingPairs = [];

  @override
  void initState() {
    super.initState();
    listImg = List.generate(icons.length, (index) => const Icon(Icons.question_mark, color: Colors.white));
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
          flex: 2,
          child: LayoutBuilder(
            builder: (context, constraint) {
              final double cardSize = constraint.maxWidth / 5 - 4;

              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 1.2,
                children: List.generate(listImg!.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        tries++;
                        listImg![index] = icons[index];
                        matchingPairs.add({index: icons[index]});
                      });
                      if (matchingPairs.length == 2) {
                        if (matchingPairs[0].values.first.toString() ==
                            matchingPairs[1].values.first.toString()) {
                          score += 2;
                          matchingPairs.clear();
                        } else {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              listImg![matchingPairs[0].keys.first] =
                                  const Icon(Icons.question_mark,
                                      color: Colors.white);
                              listImg![matchingPairs[1].keys.first] =
                                  const Icon(Icons.question_mark,
                                      color: Colors.white);
                              matchingPairs.clear();
                            });
                          });
                        }
                      }
                    },
                    child: Card(
                      color: Colors.pink,
                      child: SizedBox(
                        width: cardSize,
                        height: cardSize * 1.2,
                        child: listImg![index],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
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
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.favorite,
                            color: Colors.pink, size: 90),
                        Text(score.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('RECORD',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.favorite,
                            color: Colors.amber, size: 90),
                        Text(highScore.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}
