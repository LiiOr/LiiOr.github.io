import 'package:flutter/material.dart';
import 'package:minijeux/chatbot_game.dart';
import 'package:minijeux/memory_game.dart';
import 'package:minijeux/pong_game.dart';
import 'package:minijeux/snake_game.dart';
import 'package:minijeux/start.dart';
import 'package:minijeux/tamagotchi_game.dart';
import 'package:minijeux/tetris_game.dart';
import 'package:minijeux/tictactoe_game.dart';

import 'flappy_game.dart';

class MiniGame {
  final String title;
  final Widget gameWidget;
  final Icon? icon;

  MiniGame({required this.title, required this.gameWidget, this.icon});
}

List<MiniGame> games = [
  MiniGame(title: "M E M O R Y", gameWidget: const MemoryGame(), icon: const Icon(Icons.memory, color: Colors.white)),
  MiniGame(title: "S N A K E", gameWidget: const SnakeGame(), icon: const Icon(Icons.turn_right, color: Colors.white)),
  MiniGame(title: "P O N G", gameWidget: const PongGame(), icon: const Icon(Icons.sports_tennis, color: Colors.white)),
  MiniGame(title: "F L A P P Y", gameWidget: const FlappyGame(), icon: const Icon(Icons.flight, color: Colors.white)),
  MiniGame(title: "T I C  T A C  T O E", gameWidget: const TicTacToeGame(), icon: const Icon(Icons.close, color: Colors.white)),
  MiniGame(title: "T E T R I S", gameWidget: const TetrisGame(), icon: const Icon(Icons.sort, color: Colors.white)),
  MiniGame(title: "T A M A G O T C H I", gameWidget: const TamagotchiGame(), icon: const Icon(Icons.pets, color: Colors.white)),
  MiniGame(title: "Q U I Z Z", gameWidget: const ChatbotGame(), icon: const Icon(Icons.chat, color: Colors.white))
];

class Stuff {
  final String title;
  final Widget stuffWidget;
  final Icon? icon;

  Stuff({required this.title, required this.stuffWidget, this.icon});
}

List<Stuff> otherstuff = [
  Stuff(title: "Q U I Z Z", stuffWidget: const ChatbotGame(), icon: const Icon(Icons.science_outlined, color: Colors.white))
];


class Tool {
  final String title;
  final Widget toolWidget;
  final Icon? icon;

  Tool({required this.title, required this.toolWidget, this.icon});
}

List<Tool> toolkit = [
  Tool(title: "C H A T  B O T", toolWidget: const ChatbotGame(), icon: const Icon(Icons.chat, color: Colors.white))
]; 
 
double screenWidth = 0.0;
double screenHeight = 0.0;
const headingStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

