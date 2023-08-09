import 'package:minijeux/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:minijeux/splash.dart';

String numVersion =
    const String.fromEnvironment('APP_VERSION', defaultValue: 'DEV');
bool isDark = true;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  late ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    checkThemeMode();
  }

  Future<void> checkThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('darkmode') ?? true;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  setTheme(val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('darkmode', val);
      isDark = val;
      isDark
          ? MyApp.of(context).changeTheme(ThemeMode.dark)
          : MyApp.of(context).changeTheme(ThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Mini games',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          primaryColor: Colors.pink[800]),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          primaryColor: Colors.black),
      themeMode: _themeMode,
      home: const SplashScreen(),
    );
  }
}
