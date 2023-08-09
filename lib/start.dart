
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
           /* Text('S T U F F', style: headingStyle),
            const Divider(),*/
            const Text('B R O K E N  G A M E S', style: headingStyle),
            const Divider(),
            ListView.separated(
              //scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                 Color randomColor = generateCardColor(index);
                return Card(
                  color: randomColor,
                  child: ListTile(
                    leading: games[index].icon,
                    title: Text(games[index].title.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            /*fontWeight: FontWeight.bold*/)),
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
    Colors.pink,
    Colors.purple,
  ];
  return customColors[index].withOpacity(0.5);
}