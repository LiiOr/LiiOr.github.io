import 'package:flutter/material.dart';
import 'package:minijeux/globals.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //return Container(child: const Text('Coming soon...'),);
    return SingleChildScrollView(
      child: DataTable(
          horizontalMargin: 0.0,
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
                DataCell(Text('-')),
              ],
            ),
          )),
    );
  }
}

class Scoreboard extends StatelessWidget {
  Scoreboard({super.key, required this.score});
  int score;

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
            //Text('B E S T : ${score.toString()}', textAlign: TextAlign.center, style: headingStyle),
          ],
        ));
  }
}
