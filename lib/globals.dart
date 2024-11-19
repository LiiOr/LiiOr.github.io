import 'package:flutter/material.dart';
import 'package:mylabs/games/scores.dart';
import 'package:mylabs/main.dart';
import 'package:mylabs/tests/final_image_picker.dart';
import 'package:mylabs/tests/image_picker_doc.dart';
import 'package:mylabs/toolkit/GPT.dart';
import 'package:mylabs/toolkit/chatbot.dart';
import 'package:mylabs/tests/filepickerpage.dart';
import 'package:mylabs/tests/image_picker.dart';
import 'package:mylabs/toolkit/loginpage.dart';
import 'package:mylabs/games/memory_game.dart';
import 'package:mylabs/games/pong_game.dart';
import 'package:mylabs/games/snake_game.dart';
import 'package:mylabs/games/tamagotchi_game.dart';
import 'package:mylabs/toolkit/passwordgen.dart';
import 'package:mylabs/toolkit/plants.dart';
import 'package:mylabs/toolkit/pokertable.dart';
import 'package:mylabs/toolkit/stats.dart';
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
      icon: Icon(Icons.memory, color: pickedThemeColor)),*/
  MiniGame(
      title: "SNAKE",
      gameWidget: const SnakeGame(),
      icon: const Icon(Icons.turn_right)),
  MiniGame(
      title: "MEMORY",
      gameWidget: const MemoryGame(),
      icon: const Icon(Icons.memory)),
  MiniGame(
      title: "PONG",
      gameWidget: const PongGame(),
      icon: const Icon(Icons.sports_tennis)),
  MiniGame(
      title: "FLAPPY",
      gameWidget: const FlappyGame(),
      icon: const Icon(Icons.flight)),
  /* MiniGame(
      title: "TIC TAC TOE",
      gameWidget: const TicTacToeGame(),
      icon: Icon(Icons.close)),
  MiniGame(
      title: "TETRIS",
      gameWidget: const TetrisGame(),
      icon: Icon(Icons.sort)),*/
  MiniGame(
      title: "TAMAGOTCHI",
      gameWidget: const TamagotchiGame(),
      icon: const Icon(Icons.pets)),
  MiniGame(
      title: "SCORE BOARD",
      gameWidget: const ScoreBoardScreen(),
      icon: const Icon(Icons.scoreboard)),
];

class PackageTest {
  final String title;
  final Widget testWidget;
  final Icon? icon;

  PackageTest({required this.title, required this.testWidget, this.icon});
}

List<PackageTest> packagestests = [
  PackageTest(
      title: "FINAL TEST",
      testWidget: const FinalImagePickerScreen(),
      icon: const Icon(Icons.image)),
  PackageTest(
      title: "IMAGE PICKER",
      testWidget: const ImagePickerScreen(),
      icon: const Icon(Icons.image)),
  PackageTest(
      title: "FILE PICKER",
      testWidget: const FilepickerPage(),
      icon: const Icon(Icons.file_present)),
  PackageTest(
      title: "IMAGE PICKER DOC",
      testWidget: const ImagePickerDocScreen(),
      icon: const Icon(Icons.image)),
];

class Tool {
  final String title;
  final Widget toolWidget;
  final Icon? icon;

  Tool({required this.title, required this.toolWidget, this.icon});
}

List<Tool> toolkit = [
   Tool(
      title: "PLANTS RECOGNITION",
      toolWidget: const PlantScreen(),
      icon: const Icon(Icons.camera)),
    Tool(
      title: "STATS",
      toolWidget: const StatsPage(),
      icon: const Icon(Icons.bar_chart)),
  Tool(
      title: "GPT INTEGRATION",
      toolWidget: const GptScreen(),
      icon: const Icon(Icons.bolt)),
  Tool(
      title: "PWD GENERATOR",
      toolWidget: const PwdGenScreen(),
      icon: const Icon(Icons.lock)),
  Tool(
      title: "CHAT BOT",
      toolWidget: const ChatbotGame(),
      icon: const Icon(Icons.chat)),
  Tool(
      title: "POKER TABLE",
      toolWidget: PokerTable(),
      icon: const Icon(Icons.money_outlined)),
  Tool(
      title: "LOGIN PAGE",
      toolWidget: const LoginScreen(),
      icon: const Icon(Icons.login)),
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
      icon: const Icon(Icons.draw)),
  Link(
      title: "HUMAAANS",
      link: "https://blush.design/",
      icon: const Icon(Icons.emoji_people)),
  Link(
      title: "HUGGING FACE",
      link: "https://huggingface.co/",
      icon: const Icon(Icons.computer)),
];

double screenWidth = 0.0;
double screenHeight = 0.0;
const headingStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const scoreStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
