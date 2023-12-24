// Poker table interface
import 'package:flutter/material.dart';

class PokerTable extends StatelessWidget {
  PokerTable({super.key});

  final List<String> deck = [
    '2♠', '3♠', '4♠', '5♠', '6♠', '7♠', '8♠', '9♠', 'T♠', 'J♠', 'Q♠', 'K♠', 'A♠',
    '2♣', '3♣', '4♣', '5♣', '6♣', '7♣', '8♣', '9♣', 'T♣', 'J♣', 'Q♣', 'K♣', 'A♣',
    '2♥', '3♥', '4♥', '5♥', '6♥', '7♥', '8♥', '9♥', 'T♥', 'J♥', 'Q♥', 'K♥', 'A♥',
    '2♦', '3♦', '4♦', '5♦', '6♦', '7♦', '8♦', '9♦', 'T♦', 'J♦', 'Q♦', 'K♦', 'A♦',
  ];

  // Method to define card color
  Color cardColor(String card) {
    if (card.contains('♠') || card.contains('♣')) {
      return Colors.black;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    deck.shuffle();
     String card1 = deck[0];
    String card2 = deck[1];
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        appBar: AppBar(
          title: const Text('P O K E R  T R A I N I N G'),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'SETTINGS',
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // The table
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Outer part of the table
                  Container(
                    width: 260,
                    height: 525,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: const Color.fromARGB(255, 54, 38, 33),
                    ),
                  ),
                  // Inner part of the table
                  Container(
                    width: 235,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      gradient: const RadialGradient(
                        colors: [
                          Color.fromARGB(255, 0, 37, 0),
                          Color.fromARGB(255, 0, 46, 12)
                        ],
                      ),
                      //color: const Color.fromARGB(255, 35, 0, 49),
                    ),
                  ),
                ],
              ),
              // The dealer
              const Positioned(
                top: 0,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('DEALER', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              // player
              Positioned(
                bottom: 0,
                child: Row(
                  children: <Widget>[
                    Transform.rotate(
                      angle: -0.3,
                      child: Container(decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(8)), child: Center(child: Text(card1, style: TextStyle(color: cardColor(card1)))), height: 50, width:35),
                    ),
                    const SizedBox(width: 10),
                    Transform.rotate(
                      angle: 0.3,
                      child: Container(decoration: BoxDecoration( color: Colors.white,
                        borderRadius: BorderRadius.circular(8)), child: Center(child: Text(card2, style: TextStyle(color: cardColor(card2)))), height: 50, width:35),
                    )
                  ],
                )),
              // bots positions
              const Positioned(
                left: 0,
                top: 150,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 1', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const Positioned(
                right: 0,
                top: 150,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 2', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const Positioned(
                left: 0,
                bottom: 150,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 3', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 150,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 4', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const Positioned(
                top: 240,
                left: 0,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 5', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              const Positioned(
                top: 240,
                right: 0,
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    Text('BOT 6', style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          color: const Color.fromARGB(255, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlinedButton(
                child: const Text('R A I S E'),
                onPressed: () {},
              ),
              OutlinedButton(
                child: const Text("C A L L"),
                onPressed: () {},
              ),
              OutlinedButton(
                child: const Text("F O L D"),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
