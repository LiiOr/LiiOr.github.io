import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minijeux/games/scores.dart';

/*class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  int tries = 0;
  int score = 0;
  int highScore = 0;
  List<Icon>? listImg;
  List<Icon> icons = [
    //Icons.anchor,
    const Icon(Icons.restaurant, color: Colors.white, size: 60.5),
    const Icon(Icons.favorite, color: Colors.white, size: 60.5),
    const Icon(Icons.airplanemode_on, color: Colors.white, size: 60.5),
    const Icon(Icons.alarm, color: Colors.white, size: 60.5),
    const Icon(Icons.person, color: Colors.white, size: 60.5),
    const Icon(Icons.light_mode_outlined, color: Colors.white, size: 60.5),
    const Icon(Icons.star, color: Colors.white, size: 60.5),
    const Icon(Icons.headset_rounded, color: Colors.white, size: 60.5),
    const Icon(Icons.directions_bike_rounded, color: Colors.white, size: 60.5),
    const Icon(Icons.anchor, color: Colors.white, size: 60.5),
    const Icon(Icons.anchor, color: Colors.white, size: 60.5),
    const Icon(Icons.restaurant, color: Colors.white, size: 60.5),
    const Icon(Icons.favorite, color: Colors.white, size: 60.5),
    const Icon(Icons.airplanemode_on, color: Colors.white, size: 60.5),
    const Icon(Icons.alarm, color: Colors.white, size: 60.5),
    const Icon(Icons.person, color: Colors.white, size: 60.5),
    const Icon(Icons.light_mode_outlined, color: Colors.white, size: 60.5),
    const Icon(Icons.star, color: Colors.white, size: 60.5),
    const Icon(Icons.headset_rounded, color: Colors.white, size: 60.5),
    const Icon(Icons.directions_bike_rounded, color: Colors.white, size: 60.5),
  ];
  List<Map<int, Icon>> matchingPairs = [];
  List<bool> itemsOpened = [];
  bool hasStarted = false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    icons.shuffle();
    var list = List.generate((icons).length,
        (index) => const Icon(Icons.question_mark, color: Colors.white));
    list.shuffle(Random());

    setState(() {
      // on commence la partie en affichant les cards pdt 5 secondes
      listImg = list;
      itemsOpened = List<bool>.filled(list.length, true);
    });

    Timer(const Duration(seconds: 5), () {
      // puis on les retourne et le joueur peut commencer
      setState(() {
        itemsOpened = List<bool>.filled(list.length, false);
        hasStarted = true;
      });
    });
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
          content: Text('Tu as marqué $score points ! Veux tu rejouer?',
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
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
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
                      child: /*AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: (hasStarted)? 1.0 : 0.0,
                        child:*/ Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.purple,
                              Colors.pink,
                            ],
                          )),
                          //color: Colors.pink, //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child: SizedBox(
                            width: cardSize,
                            height: cardSize * 1.2,
                            child: itemsOpened[index]? icons[index]:listImg![index],
                          ),
                        ),
                      /*),*/
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
}*/

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  Timer? gameLoopTimer;
  int score = 0;
  int highScore = 0;

  List<int> items = [];
  List<bool> itemsOpened = [];
  int previousIndex = -1;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    final random = Random();
    List<int> allItems = List.generate(20, (index) => index % 10);
    allItems.shuffle(random);

    setState(() {
      items = allItems;
      itemsOpened = List<bool>.filled(allItems.length, true);
    });

    gameLoopTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        itemsOpened = List<bool>.filled(allItems.length, false);
      });
    });
  }

  void onItemClick(int index) {
    if (!isProcessing && !itemsOpened[index]) {
      setState(() {
        itemsOpened[index] = true;
      });

      if (previousIndex == -1) {
        previousIndex = index;
      } else {
        isProcessing = true;
        Timer(const Duration(seconds: 1), () {
          if (items[previousIndex] != items[index]) {
            setState(() {
              itemsOpened[previousIndex] = false;
              itemsOpened[index] = false;
            });
          }
          previousIndex = -1;
          isProcessing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    gameLoopTimer
        ?.cancel(); // Annuler la minuterie avant que le widget soit supprimé
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M E M O R Y'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onItemClick(index),
                  child: Container(
                    color: itemsOpened[index] ? Colors.pink : Colors.grey,
                    child: Center(
                      child: itemsOpened[index]
                          ? Text(
                              '${items[index]}',
                              style: const TextStyle(fontSize: 24.0),
                            )
                          : const Icon(
                              Icons.question_mark,
                              size: 32.0,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          GameScore(game: 'MEMORY', score: score, highScore: score)
        ],
      ),
    );
  }
}
