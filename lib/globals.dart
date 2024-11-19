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
      icon: Icon(Icons.turn_right, color: pickedThemeColor)),
  MiniGame(
      title: "MEMORY",
      gameWidget: const MemoryGame(),
      icon: Icon(Icons.memory, color: pickedThemeColor)),
  MiniGame(
      title: "PONG",
      gameWidget: const PongGame(),
      icon: Icon(Icons.sports_tennis, color: pickedThemeColor)),
  MiniGame(
      title: "FLAPPY",
      gameWidget: const FlappyGame(),
      icon: Icon(Icons.flight, color: pickedThemeColor)),
  /* MiniGame(
      title: "TIC TAC TOE",
      gameWidget: const TicTacToeGame(),
      icon: Icon(Icons.close, color: pickedThemeColor)),
  MiniGame(
      title: "TETRIS",
      gameWidget: const TetrisGame(),
      icon: Icon(Icons.sort, color: pickedThemeColor)),*/
  MiniGame(
      title: "TAMAGOTCHI",
      gameWidget: const TamagotchiGame(),
      icon: Icon(Icons.pets, color: pickedThemeColor)),
  MiniGame(
      title: "SCORE BOARD",
      gameWidget: const ScoreBoardScreen(),
      icon: Icon(Icons.scoreboard, color: pickedThemeColor)),
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
      icon: Icon(Icons.image, color: pickedThemeColor)),
  PackageTest(
      title: "IMAGE PICKER",
      testWidget: const ImagePickerScreen(),
      icon: Icon(Icons.image, color: pickedThemeColor)),
  PackageTest(
      title: "FILE PICKER",
      testWidget: const FilepickerPage(),
      icon: Icon(Icons.file_present, color: pickedThemeColor)),
  PackageTest(
      title: "IMAGE PICKER DOC",
      testWidget: const ImagePickerDocScreen(),
      icon: Icon(Icons.image, color: pickedThemeColor)),
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
      icon: Icon(Icons.camera, color: pickedThemeColor)),
    Tool(
      title: "STATS",
      toolWidget: const StatsPage(),
      icon: Icon(Icons.bar_chart, color: pickedThemeColor)),
  Tool(
      title: "GPT INTEGRATION",
      toolWidget: const GptScreen(),
      icon: Icon(Icons.bolt, color: pickedThemeColor)),
  Tool(
      title: "PWD GENERATOR",
      toolWidget: const PwdGenScreen(),
      icon: Icon(Icons.lock, color: pickedThemeColor)),
  Tool(
      title: "CHAT BOT",
      toolWidget: const ChatbotGame(),
      icon: Icon(Icons.chat, color: pickedThemeColor)),
  Tool(
      title: "POKER TABLE",
      toolWidget: PokerTable(),
      icon: Icon(Icons.money_outlined, color: pickedThemeColor)),
  Tool(
      title: "LOGIN PAGE",
      toolWidget: const LoginScreen(),
      icon: Icon(Icons.login, color: pickedThemeColor)),
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
      icon: Icon(Icons.draw, color: pickedThemeColor)),
  Link(
      title: "HUMAAANS",
      link: "https://blush.design/",
      icon: Icon(Icons.emoji_people, color: pickedThemeColor)),
  Link(
      title: "HUGGING FACE",
      link: "https://huggingface.co/",
      icon: Icon(Icons.computer, color: pickedThemeColor)),
];

double screenWidth = 0.0;
double screenHeight = 0.0;
const headingStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const scoreStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
