import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';
import 'dart:js' as js;

import 'package:minijeux/main.dart';

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
                return Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(index),
                          generateCardColor(index + 1),
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
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
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
                return Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(index),
                          generateCardColor(index + 1),
                        //  Colors.purple.withOpacity(0.5),
                         // Colors.pink.withOpacity(0.5)
                        ],
                      )),
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
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('U S E F U L  L I N K S', style: headingStyle),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.draw),
            title: const Text("App Icon Generator"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              js.context.callMethod('open', ['https://icon.kitchen']);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.emoji_people_outlined),
            title: const Text("Humaaans"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              js.context.callMethod('open', ['https://blush.design/']);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text("HuggingFace"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              js.context.callMethod('open', ['https://huggingface.co/']);
            },
          ),
          const Divider(),
//          const SizedBox(height: 20),
          /*const Text('O T H E R  S T U F F', style: headingStyle),
          const Divider(),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: otherstuff.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          generateCardColor(index),
                          generateCardColor(index + 1),
                        ],
                      )),
                  width: 130,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: otherstuff[index].icon,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    otherstuff[index].stuffWidget,
                              ));
                        },
                      ),
                      Text(otherstuff[index].title,
                          style: const TextStyle(fontSize: 10))
                    ],
                  ),
                );
              },
            ),
          ),*/
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
  Color c = isDark ? customColors[index].withOpacity(0.5) : customColors[index].withOpacity(0.8);
  return c;
}
