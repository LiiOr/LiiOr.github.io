import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:minijeux/globals.dart';

class ScoreBoardScreen extends StatefulWidget {
  const ScoreBoardScreen({super.key});

  @override
  State<ScoreBoardScreen> createState() => ScoreBoardScreenState();
}

class ScoreBoardScreenState extends State<ScoreBoardScreen> {
  final LocalStorage storage = LocalStorage('scores');

  Future<List<Map<String, dynamic>>> getScoresFromLocalStorage() async {
    final scores = storage.getItem('scores') ?? <Map<String, dynamic>>[];
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
                child: FittedBox(
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
                          'B E S T  S C O R E',
                          style: headingStyle,
                        ),
                      )
                    ],
                    rows: scores.map((score) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(score['game'])),
                          DataCell(Text(score['highScore']))
                        ],
                      );
                    }).toList(),
                  ),
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
    final currentscores = storage.getItem('scores') ?? <Map<String, dynamic>>[];
    var nouvScore = {
      'game': game.toString(),
      'score': score.toString(),
      'highScore': highScore.toString()
    };
    currentscores.add(nouvScore);
    storage.setItem('scores', currentscores);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('S C O R E : ${score.toString()}',
                  textAlign: TextAlign.center, style: scoreStyle),
              Text('B E S T : ${highScore.toString()}',
                  textAlign: TextAlign.center, style: scoreStyle),
            ],
          )),
    );
  }
}
