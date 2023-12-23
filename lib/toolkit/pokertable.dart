// Poker table interface
import 'package:flutter/material.dart';

class PokerTable extends StatelessWidget {
  const PokerTable({super.key});

  @override
  Widget build(BuildContext context) {
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
                    width: 350,
                    height: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Color.fromARGB(255, 54, 38, 33),
                    ),
                  ),
                  // Inner part of the table
                  Container(
                    width: 325,
                    height: 675,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      gradient: RadialGradient(
        colors: [Color.fromARGB(255, 35, 0, 49), Color.fromARGB(255, 43, 0, 59)],
      ),
                      //color: const Color.fromARGB(255, 35, 0, 49),
                    ),
                  ),
                ],
              ),
              // The dealer
              const Positioned(
                top: 0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              // Player positions
              const Positioned(
                left: 0,
                top: 150,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                left: 0,
                bottom: 150,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                right: 0,
                top: 150,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                right: 0,
                bottom: 150,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                bottom: 0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                top: 0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                top: 340,
                left: 0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const Positioned(
                top: 340,
                right: 0,
                child: Icon(Icons.person, color: Colors.white),
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
