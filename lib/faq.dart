import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('F A Q'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
                'Just a simple PWA that I use as my personal lab to test stuff and explore the wonderful world of Flutter.'),
           // Divider(),
            //Text('')
          ]),
        ));
  }
}
