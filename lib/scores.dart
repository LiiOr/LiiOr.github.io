import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //return Container(child: const Text('Coming soon...'),);
    return SingleChildScrollView(
      child: DataTable(
         // horizontalMargin: 0.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'G A M E',
                  style: headingStyle,
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'B E S T',
                  style: headingStyle,
                ),
              ),
            )
          ],
          rows: List.generate(
            games.length,
            (index) => DataRow(
              cells: <DataCell>[
                DataCell(Text(games[index].title)),
                const DataCell(Text('-')),
              ],
            ),
          )),
    );
  }
}

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key, required this.score, required this.highScore});
  final int score;
  final int highScore;

 /* @override
  String toString() {
    return '{"game":"SNAKE","score":"$score","highScore":"$highScore"}';
  }*/

  setScore() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> mergedData = [];
      List<String>? existingData = prefs.getStringList('scores');
      if (existingData != null) {
        mergedData.addAll(existingData);
      }
      mergedData.add('{"game":"SNAKE","score":"$score","highScore":"$highScore"}');
      await prefs.setStringList('scores', mergedData);

    //await prefs.setStringList('scores', <String>['SNAKE', score.toString(), highScore.toString()]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth,
        padding: const EdgeInsets.all(10.0),
        color: Theme.of(context).primaryColorDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('S C O R E : ${score.toString()}', textAlign: TextAlign.center, style: headingStyle),
            Text('B E S T : ${highScore.toString()}', textAlign: TextAlign.center, style: headingStyle),
          ],
        ));
  }
}
