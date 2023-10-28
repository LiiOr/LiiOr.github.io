import 'package:flutter/material.dart';
import 'package:minijeux/commits.dart';
import 'package:minijeux/main.dart';
import 'package:minijeux/settings.dart';
import 'package:minijeux/start.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const StartScreen(),
    const GitCommitsPage(),
    const SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:15.0, right:15.0),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.science),
            icon: Icon(Icons.science_outlined),
            label: 'L A B S',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.commit),
            icon: Icon(Icons.commit_outlined),
            label: 'C O M M I T S',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'S E T T I N G S',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: isDark? Colors.pink[300] : Colors.white,
        unselectedItemColor: isDark? Colors.grey[300] : Colors.grey[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
