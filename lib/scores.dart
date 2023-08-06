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
        rows: List.generate(games.length, (index) => DataRow(
            cells: <DataCell>[
              DataCell(Text(games[index].title)),
              DataCell(Text('-')),
            ],
          ),)
      ),
    );
  }
}