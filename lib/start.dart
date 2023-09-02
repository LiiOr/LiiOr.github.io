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
    /* return Center(
        child: SingleChildScrollView(
        child: 
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:20),
            const Text('M Y  B R O K E N  G A M E S', style: headingStyle),
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
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
          ],
        )
        ),
      );*/
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('P E R S O N N A L  T O O L  K I T', style: headingStyle),
        const Divider(),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: toolkit.length,
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
                    Text(toolkit[index].title, style: const TextStyle(fontSize: 10))
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
                    Text(games[index].title, style: const TextStyle(fontSize: 10))
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(),
         const SizedBox(height: 20),
        const Text('O T H E R  S T U F F', style: headingStyle),
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
                    Text(otherstuff[index].title, style: const TextStyle(fontSize: 10))
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
  return customColors[index].withOpacity(0.5);
}
