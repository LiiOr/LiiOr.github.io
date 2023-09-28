import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:minijeux/globals.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ScoresScreen extends StatelessWidget {
  ScoresScreen({super.key, Key? key});
  Scoreboard scoreboard = Scoreboard(score: 0, highScore: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: scoreboard.getScoresFromLocalStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Affichez un indicateur de chargement en attendant les données.
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Aucun score n\'a été trouvé.'); // Ajustez le message en conséquence.
        } else {
          final List<Map<String, dynamic>> scores = snapshot.data!;
          return SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'G A M E',
                    style: headingStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'B E S T',
                    style: headingStyle,
                  ),
                )
              ],
              rows: scores.map((score) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(score['game'])),
                    DataCell(Text(score['highScore'])),
                  ],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

class Scoreboard extends StatelessWidget {
  final LocalStorage storage = LocalStorage('scores');
  Scoreboard({super.key, required this.score, required this.highScore});
  final int score;
  final int highScore;

 Future<List<Map<String, dynamic>>> getScoresFromLocalStorage() async {
  final String scoresJson = storage.getItem('scores') ?? '{}';
  final Map<String, dynamic> scoresMap = json.decode(scoresJson);
  final List<Map<String, dynamic>> scores = [];
  if (scoresMap.containsKey('scores')) {
    final Map<String, dynamic> gameScores = scoresMap['scores'];
    gameScores.forEach((key, value) {
      scores.add({
        'game': key,
        'score': value['score'].toString(),
        'highScore': value['highScore'].toString(),
      });
    });
  }
  return scores;
}

  setScore() async {
    Map<String, dynamic> mergedData = {};
    Map<String, dynamic>? existingData = storage.getItem('scores');
    if (existingData != null) {
      mergedData.addAll(existingData);
    }
    mergedData
        .addAll({"game":"SNAKE","score":"$score","highScore":"$highScore"});
    await storage.setItem('scores', mergedData);
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
            Text('S C O R E : ${score.toString()}',
                textAlign: TextAlign.center, style: headingStyle),
            Text('B E S T : ${highScore.toString()}',
                textAlign: TextAlign.center, style: headingStyle),
          ],
        ));
  }
}
