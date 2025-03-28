import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mylabs/globals.dart';
import 'package:mylabs/main.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  State<ScoreBoardScreen> createState() => ScoreBoardScreenState();
}

class ScoreBoardScreenState extends State<ScoreBoardScreen> {
  Future<List<Map<String, dynamic>>> getScoresFromLocalStorage() async {
    await initLocalStorage();

    final String? scoresString = localStorage.getItem('scores') as String?;
    if (scoresString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(scoresString));
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('S C O R E B O A R D'),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getScoresFromLocalStorage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: pickedThemeColor)); // Affichez un indicateur de chargement en attendant les données.
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur au chargement des scores : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucun score n\'a été trouvé.')); // Ajustez le message en conséquence.
            } else {
              final List<Map<String, dynamic>> scores = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'G A M E',
                            style: headingStyle,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'B E S T  S C O R E',
                            style: headingStyle,
                          ),
                        )
                      ],
                      rows: scores.map((score) {
                        return DataRow(
                          cells: <DataCell>[DataCell(Text(score['game'])), DataCell(Text(score['best'].toString()))],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

class GameScore extends StatelessWidget {
  GameScore({super.key, required this.game, required this.score, required this.highScore});
  final String game;
  final int score;
  final int highScore;

  Future<void> setScore() async {
    await initLocalStorage();
    // Retrieve existing scores
    final String? scoresString = localStorage.getItem('scores') as String?;
    final List<Map<String, dynamic>> currentScores = scoresString != null ? List<Map<String, dynamic>>.from(jsonDecode(scoresString)) : [];

    // Find the game in the list
    final int index = currentScores.indexWhere((element) => element['game'] == game);

    if (index != -1) {
      // Update the score if the new score is higher
      if (score > currentScores[index]['best']) {
        currentScores[index]['best'] = score;
      }
    } else {
      // Add a new entry for the game
      currentScores.add({'game': game, 'best': score});
    }

    // Save the updated list back to localStorage
    localStorage.setItem('scores', jsonEncode(currentScores));
  }

  Future<int> getBestScore() async {
    await initLocalStorage();
    // Retrieve existing scores
    final String? scoresString = localStorage.getItem('scores');
    if (scoresString != null) {
      final List<Map<String, dynamic>> currentScores = List<Map<String, dynamic>>.from(jsonDecode(scoresString));
      // Find the game in the list
      final int index = currentScores.indexWhere((element) => element['game'] == game);
      if (index != -1) {
        return currentScores[index]['best'] as int;
      }
    }

    return 0; // Return 0 if no score is found
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: screenWidth,
        child: FutureBuilder<int>(
          future: getBestScore(),
          builder: (context, snapshot) {
            final bestScore = snapshot.data ?? 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('S C O R E : ${score.toString()}', textAlign: TextAlign.center, style: scoreStyle),
                Text('B E S T : ${bestScore.toString()}', textAlign: TextAlign.center, style: scoreStyle),
              ],
            );
          },
        ),
      ),
    );
  }
}
