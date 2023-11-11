import 'package:flutter/material.dart';
import 'package:minijeux/games/scores.dart';
import 'package:minijeux/toolkit/chatbot.dart';
import 'package:minijeux/games/colorbook.dart';
import 'package:minijeux/tests/filepickerpage.dart';
import 'package:minijeux/tests/image_picker.dart';
import 'package:minijeux/toolkit/loginpage.dart';
import 'package:minijeux/games/memory_game.dart';
import 'package:minijeux/games/pong_game.dart';
import 'package:minijeux/games/snake_game.dart';
import 'package:minijeux/games/tamagotchi_game.dart';
import 'package:minijeux/games/tetris_game.dart';
import 'package:minijeux/games/tictactoe_game.dart';
import 'games/flappy_game.dart';

class MiniGame {
  final String title;
  final Widget gameWidget;
  final Icon? icon;

  MiniGame({required this.title, required this.gameWidget, this.icon});
}

List<MiniGame> games = [
  /*MiniGame(
      title: "COLOR BOOK",
      gameWidget: const ColorBook(),
      icon: const Icon(Icons.memory, color: Colors.white)),*/
  MiniGame(
      title: "MEMORY",
      gameWidget: const MemoryGame(),
      icon: const Icon(Icons.memory, color: Colors.white)),
  MiniGame(
      title: "SNAKE",
      gameWidget: const SnakeGame(),
      icon: const Icon(Icons.turn_right, color: Colors.white)),
  MiniGame(
      title: "PONG",
      gameWidget: const PongGame(),
      icon: const Icon(Icons.sports_tennis, color: Colors.white)),
  MiniGame(
      title: "FLAPPY",
      gameWidget: const FlappyGame(),
      icon: const Icon(Icons.flight, color: Colors.white)),
 /* MiniGame(
      title: "TIC TAC TOE",
      gameWidget: const TicTacToeGame(),
      icon: const Icon(Icons.close, color: Colors.white)),
  MiniGame(
      title: "TETRIS",
      gameWidget: const TetrisGame(),
      icon: const Icon(Icons.sort, color: Colors.white)),*/
  MiniGame(
      title: "TAMAGOTCHI",
      gameWidget: const TamagotchiGame(),
      icon: const Icon(Icons.pets, color: Colors.white)),
  MiniGame(
      title: "SCORE BOARD",
      gameWidget: ScoreBoardScreen(),
      icon: const Icon(Icons.scoreboard, color: Colors.white)),
];

class PackageTest {
  final String title;
  final Widget testWidget;
  final Icon? icon;

  PackageTest({required this.title, required this.testWidget, this.icon});
}

List<PackageTest> packagestests = [
  PackageTest(
      title: "IMAGE PICKER",
      testWidget: const ImagePickerScreen(),
      icon: const Icon(Icons.image, color: Colors.white)),
  PackageTest(
      title: "FILE PICKER",
      testWidget: const FilepickerPage(),
      icon: const Icon(Icons.file_present, color: Colors.white)),
];

class Tool {
  final String title;
  final Widget toolWidget;
  final Icon? icon;

  Tool({required this.title, required this.toolWidget, this.icon});
}

List<Tool> toolkit = [
  Tool(
      title: "LOGIN PAGE",
      toolWidget: const LoginScreen(),
      icon: const Icon(Icons.login, color: Colors.white)),
  Tool(
      title: "CHAT BOT",
      toolWidget: const ChatbotGame(),
      icon: const Icon(Icons.chat, color: Colors.white)),
];

class Link {
  final String title;
  final String link;
  final Icon? icon;

  Link({required this.title, required this.link, this.icon});
}

List<Link> favoritelinks = [
  Link(
      title: "APP ICON GENERATOR",
      link: "https://icon.kitchen",
      icon: const Icon(Icons.draw, color: Colors.white)),
  Link(
      title: "HUMAAANS",
      link: "https://blush.design/",
      icon: const Icon(Icons.emoji_people, color: Colors.white)),
  Link(
      title: "HUGGING FACE",
      link: "https://huggingface.co/",
      icon: const Icon(Icons.computer, color: Colors.white)),
];

double screenWidth = 0.0;
double screenHeight = 0.0;
const headingStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const scoreStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

