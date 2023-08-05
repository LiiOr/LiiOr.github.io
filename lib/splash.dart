import 'package:flutter/material.dart';
import 'package:minijeux/main.dart';
import 'package:minijeux/navbar.dart';
import 'package:minijeux/start.dart';

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
     // backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.gamepad, size: 40),
            const SizedBox(height: 30),
            const Text('Mini Games for babies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 10),
            Text('Version $numVersion', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 45),
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(color: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
