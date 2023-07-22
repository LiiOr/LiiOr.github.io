import 'package:flutter/material.dart';
import 'package:minijeux/splash.dart';

String numVersion =
    const String.fromEnvironment('APP_VERSION', defaultValue: 'DEV');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini jeux',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
        ),
        themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
