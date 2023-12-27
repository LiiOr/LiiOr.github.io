import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mylabs/globals.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  State<ScoreBoardScreen> createState() => ScoreBoardScreenState();
}

class ScoreBoardScreenState extends State<ScoreBoardScreen> {
  final LocalStorage storage = LocalStorage('scores');

  Future<List<Map<String, dynamic>>> getScoresFromLocalStorage() async {
    final List<Map<String, dynamic>> scores = (storage.getItem('scores') as List?)?.cast<Map<String, dynamic>>() ?? [];
    return scores;
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
              return const Center(
                  child:
                      CircularProgressIndicator()); // Affichez un indicateur de chargement en attendant les données.
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Erreur au chargement des scores : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                      'Aucun score n\'a été trouvé.')); // Ajustez le message en conséquence.
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
                          cells: <DataCell>[
                            DataCell(Text(score['game'])),
                            DataCell(Text(score['best'].toString()))
                          ],
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
  final LocalStorage storage = LocalStorage('scores');
  GameScore(
      {super.key,
      required this.game,
      required this.score,
      required this.highScore});
  final String game;
  final int score;
  final int highScore;

  setScore() async {
    final List<Map<String, dynamic>> currentScores =
        (storage.getItem('scores') as List?)?.cast<Map<String, dynamic>>() ??
            [];
    final index =
        currentScores.indexWhere((element) => element['game'] == game);
    if (index != -1) {
      if (highScore > currentScores[index]['best']) {
        currentScores[index]['best'] = highScore;
      }
    } else {
      currentScores.add({'game': game, 'best': highScore});
    }
    storage.setItem('scores', currentScores);
  }

  Future<int> getBestScore() async {
    final List<Map<String, dynamic>> currentScores = (storage.getItem('scores') as List?)?.cast<Map<String, dynamic>>() ?? [];

    final index = currentScores.indexWhere((element) => element['game'] == game);

    if (index != -1) {
      return int.parse(currentScores[index]['best'].toString());
    } else {
      return 0; // Default value if no score is found
    }
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
                Text('S C O R E : ${score.toString()}',
                    textAlign: TextAlign.center, style: scoreStyle),
                Text('B E S T : ${bestScore.toString()}',
                    textAlign: TextAlign.center, style: scoreStyle),
              ],
            );
          },
        ),
      ),
    );
  }
}
