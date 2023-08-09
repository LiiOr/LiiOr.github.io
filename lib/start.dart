
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
        child: 
        Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('M Y  B R O K E N  G A M E S', style: headingStyle),
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // Color randomColor = generateCardColor(index);
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      generateCardColor(index),
                      generateCardColor(index+1),
                    ],
                  )),
                 // color: randomColor,
                  child: ListTile(
                    leading: games[index].icon,
                    title: Text(games[index].title.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
            ),
           /* Expanded(
              child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(8, (index) {
                return Center(
                  child: Text(
                    games[index].title.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              }),
            ),
            ),*/
            /* ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                 Color randomColor = generateCardColor(index);
                return Container(
                  height: 160,
                  color: randomColor,
                  child: ListTile(
                    leading: games[index].icon,
                    title: Text(games[index].title.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,)),

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
            ),*/
          ],
        )
        ),
      );
  }
}

class MiniGame {
  final String title;
  final Widget gameWidget;
  final Icon? icon;

  MiniGame({required this.title, required this.gameWidget, this.icon});
}

Color generateCardColor(index) {
  final List<Color> customColors = [
    Colors.red,
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.pink,
    Colors.purple,
  ];
  return customColors[index].withOpacity(0.5);
}