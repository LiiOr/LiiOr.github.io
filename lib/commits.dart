import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minijeux/globals.dart';
import 'package:minijeux/main.dart';

class CommitInfo {
  final String date;
  final String message;

  CommitInfo(this.date, this.message);
}

class GitCommitsPage extends StatefulWidget {
  const GitCommitsPage({super.key});

  @override
  State<GitCommitsPage> createState() => _GitCommitsPageState();
}

class _GitCommitsPageState extends State<GitCommitsPage> {
  List<CommitInfo> commits = [];

  @override
  void initState() {
    super.initState();
    _fetchCommits();
  }

  Future<void> _fetchCommits() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/LiiOr/liior.github.io/commits'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<CommitInfo> commitList = data
          .map((commit) => CommitInfo(
              commit['commit']['author']['date'], commit['commit']['message']))
          .toList();

      setState(() {
        commits = commitList;
      });
    } else {
      throw Exception('Failed to load commits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return /*Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.pink])),
      child: */Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: Text('L A T E S T  C O M M I T S', style: headingStyle),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: commits.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(commits[index].message),
                    subtitle: Text(commits[index].date),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
                child: Text('Version $numVersion',
                    style: const TextStyle(fontSize: 12))),
            const SizedBox(height: 10),
          ],
        ),
      /*),*/
    );
  }
}
