import 'package:flutter/material.dart';
import 'package:mylabs/main.dart';
import 'package:mylabs/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
       Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyNavigationBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.science_outlined, size: 40),
            const SizedBox(height: 30),
            const Text('My personal Labs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 10),
            Text('Version $numVersion', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(color: pickedThemeColor),
            )
          ],
        ),
      ),
    );
  }
}
