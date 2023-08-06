
import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';
import 'package:minijeux/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {

  setTheme(val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('darkmode', val);
      isDark = val;
      isDark
          ? MyApp.of(context).changeTheme(ThemeMode.dark)
          : MyApp.of(context).changeTheme(ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
               Color randomColor = generateCardColor(index);
              return Card(
                color: randomColor,
                child: ListTile(
                  leading: games[index].icon,
                  title: Text(games[index].title.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
          )
        ],
          ),
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