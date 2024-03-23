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
  String _password = "";

  String generatePassword(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+?.';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  // Function to advise user than a password under 12 characters is not secure
  pwdLengthWarning(int length) {
    if (length < 12) {
      return const Text('Your password is not secure', style: TextStyle(color: Colors.red));
    } else {
      return const Text('Your password is secure', style: TextStyle(color: Colors.green));
    }
  }

@override
  void initState() {
    super.initState();
    _password = generatePassword(_length); // Generate initial password
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
            pwdLengthWarning(_length),
            Slider(
              value: _length.toDouble(),
              min: 8,
              max: 20,
              divisions: 12,
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
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: const Text('Generate New Password'),
              onPressed: () {
                setState(() {
                  _password = generatePassword(_length); // Generate new password
                });
              }, icon: const Icon(Icons.refresh)
            ),
          ],
        ),
      ),
    );
  }
}
