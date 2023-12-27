import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mylabs/globals.dart';
import 'dart:js' as js;

import 'package:mylabs/main.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('P E R S O N A L  T O O L  K I T', style: headingStyle),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: toolkit.length,
              itemBuilder: (context, index) {
                var idColor = Random().nextInt(8);
                return Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(idColor),
                          generateCardColor(idColor + 1),
                        ],
                      )),
                  width: 130,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: toolkit[index].icon,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    toolkit[index].toolWidget,
                              ));
                        },
                      ),
                      Text(toolkit[index].title,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('P A C K A G E S  T E S T S', style: headingStyle),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: packagestests.length,
              itemBuilder: (context, index) {
                //var idColor = Random().nextInt(8);
                return Container(
                  decoration: const BoxDecoration(
                   // border: Border(bottom: BorderSide(color: Colors.black), top: BorderSide(color: Colors.black), left: BorderSide(color: Colors.black), right: BorderSide(color: Colors.black)),
                    color: Color.fromARGB(255, 22, 22, 22),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    /* gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(idColor),
                          generateCardColor(idColor + 1),
                        ],
                      )*/
                  ),
                  width: 130,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: packagestests[index].icon,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    packagestests[index].testWidget,
                              ));
                        },
                      ),
                      Text(packagestests[index].title,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('U S E F U L  L I N K S', style: headingStyle),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favoritelinks.length,
              itemBuilder: (context, index) {
                var idColor = Random().nextInt(8);
                return Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 22, 22),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(idColor),
                          generateCardColor(idColor + 1),
                        ],
                      )),
                  width: 130,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: favoritelinks[index].icon,
                        onTap: () {
                          js.context
                              .callMethod('open', [favoritelinks[index].link]);
                        },
                      ),
                      Text(favoritelinks[index].title,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('B R O K E N  G A M E S', style: headingStyle),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: games.length,
              itemBuilder: (context, index) {
              //  var idColor = Random().nextInt(8);
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 22, 22, 22),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    /*gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(idColor),
                          generateCardColor(idColor + 1),
                        ],
                      )*/
                  ),
                  width: 130,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: games[index].icon,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    games[index].gameWidget,
                              ));
                        },
                      ),
                      Text(games[index].title,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Center(
              child: Text('Version $numVersion',
                  style: const TextStyle(fontSize: 12))),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Color generateCardColor(index) {
  final List<Color> customColors = [
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.lime,
    Colors.orange,
    Colors.red,
  ];
  Color c = isDark
      ? customColors[index].withOpacity(0.5)
      : customColors[index].withOpacity(0.8);
  return c;
}
