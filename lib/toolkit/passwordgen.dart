import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mylabs/globals.dart';

class PwdGenScreen extends StatefulWidget {
  const PwdGenScreen({super.key});

  @override
  State<PwdGenScreen> createState() => _PwdGenScreenState();
}

class _PwdGenScreenState extends State<PwdGenScreen> {
  int _length = 10;

  String generatePassword(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+?.';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PASSWORD GENERATOR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Password length: $_length',
              style: headingStyle,
            ),
            Slider(
              value: _length.toDouble(),
              min: 1,
              max: 20,
              divisions: 20,
              label: _length.toString(),
              onChanged: (double value) {
                setState(() {
                  _length = value.round();
                });
              },
            ),
            Text(
              generatePassword(_length),
              style: headingStyle
            ),
          ],
        ),
      ),
    );
  }
}
