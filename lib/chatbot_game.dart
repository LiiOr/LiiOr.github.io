import 'package:flutter/material.dart';

class ChatbotGame extends StatefulWidget {
  const ChatbotGame({super.key});
  
  @override
  State<ChatbotGame> createState() => _ChatbotGameState();
  
}

class _ChatbotGameState extends State<ChatbotGame>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
          title: const Text('Q U I Z Z'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
    body: const Center(child: Text('Coming soon.. :)')));
  } 
}