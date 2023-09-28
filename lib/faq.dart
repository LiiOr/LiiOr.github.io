import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body : Center(
        child: Column(children: [
          Text('Just a simple PWA that I use as my personal lab to test stuff and explore the wonderful world of Flutter.'),
          Divider(),
         //Text('')
        ]),
      )
    );
  }

}