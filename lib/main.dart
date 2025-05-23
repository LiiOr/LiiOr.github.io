import 'package:mylabs/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mylabs/splash.dart';

String numVersion =
    const String.fromEnvironment('APP_VERSION', defaultValue: 'DEV');
bool isDark = true;
Color pickedThemeColor = Colors.purple;

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
    checkThemeColor();
  }

  Future<void> checkThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('darkmode') ?? false;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> checkThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    pickedThemeColor = Color(prefs.getInt('themeColor') ?? 0xFF6A1B9A);
    setState(() {
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void changeThemeColor(Color color) {
    setState(() {
      pickedThemeColor = color;
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
      title: 'My personal Labs',
      theme: ThemeData(
          useMaterial3: true,
         // scaffoldBackgroundColor: Colors.transparent,
          brightness: Brightness.light,
          colorSchemeSeed: pickedThemeColor),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: pickedThemeColor),
      themeMode: _themeMode,
      home: SplashScreen(themeColor: pickedThemeColor),
    );
  }
}
