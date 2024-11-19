import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mylabs/faq.dart';
import 'package:mylabs/globals.dart';
import 'package:mylabs/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Color themeColor = pickedThemeColor;

  bool dkSwitchVal = isDark;
  String dkSwitchText = isDark ? 'Enabled' : 'Disabled';
  Icon darkIcon = isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode);

  Future<void> setThemeMode(value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = value;
      prefs.setBool('darkmode', value);
      if (value == true) {
        MyApp.of(context).changeTheme(ThemeMode.dark);
      } else {
        MyApp.of(context).changeTheme(ThemeMode.light);
      }
    });
  }

  Future<void> setThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('themeColor', color.value);
      themeColor = color;
      MyApp.of(context).changeThemeColor(color);
    });
  }

  Future<void> showColorPicker() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Choose a theme color'),
              content: SizedBox(
                  width: 400,
                  height: 400,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.pink),
                        trailing: pickedThemeColor.value == Colors.pink.value ? const Icon(Icons.check) : null,
                        title: const Text('Pink'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.pink;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.blue),
                        trailing: pickedThemeColor.value == Colors.blue.value ? const Icon(Icons.check) : null,
                        title: const Text('Blue'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.blue;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('Green'),
                        leading: Container(width: 20, height: 20, color: Colors.green),
                        trailing: pickedThemeColor.value == Colors.green.value ? const Icon(Icons.check) : null,
                        onTap: () {
                          setState(() {
                            themeColor = Colors.green;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.yellow),
                        trailing: pickedThemeColor.value == Colors.yellow.value ? const Icon(Icons.check) : null,
                        title: const Text('Yellow'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.yellow;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.red),
                        trailing: pickedThemeColor.value == Colors.red.value ? const Icon(Icons.check) : null,
                        title: const Text('Red'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.red;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.purple),
                        trailing: pickedThemeColor.value == Colors.purple.value ? const Icon(Icons.check) : null,
                        title: const Text('Purple'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.purple;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.orange),
                        trailing: pickedThemeColor.value == Colors.orange.value ? const Icon(Icons.check) : null,
                        title: const Text('Orange'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.orange;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.brown),
                        trailing: pickedThemeColor.value == Colors.brown.value ? const Icon(Icons.check) : null,
                        title: const Text('Brown'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.brown;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                      ListTile(
                        leading: Container(width: 20, height: 20, color: Colors.grey),
                        trailing: pickedThemeColor.value == Colors.grey.value ? const Icon(Icons.check) : null,
                        title: const Text('Grey'),
                        onTap: () {
                          setState(() {
                            themeColor = Colors.grey;
                            setThemeColor(themeColor);
                          });
                        },
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "U S E R   P R E F E R E N C E S",
                      style: headingStyle,
                    ),
                  ],
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Dark mode'),
                  value: dkSwitchVal,
                  subtitle: Text(dkSwitchText),
                  onChanged: (bool value) {
                    setState(() {
                      dkSwitchVal = value;
                      setThemeMode(value);
                      if (value == true) {
                        dkSwitchText = 'Enabled';
                        darkIcon = const Icon(Icons.dark_mode);
                      } else {
                        dkSwitchText = 'Disabled';
                        darkIcon = const Icon(Icons.light_mode);
                      }
                    });
                  },
                  secondary: darkIcon,
                ),
                const Divider(),
                ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: const Text('Theme Color'),
                    subtitle: Text('Selected', style: TextStyle(color: themeColor)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showColorPicker();
                    }),
                const Divider()
              ],
            ),
            const SizedBox(height: 20),
            /*Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Compte", style: headingStyle),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.phonelink_lock_outlined),
                  title: const Text("Modifier mes informations personnelles"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AccountScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Déconnexion"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    logout(context);
                  },
                ),
                const Divider(),
              ],
            ),*/
            const SizedBox(height: 20),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("A B O U T", style: headingStyle),
                  ],
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text("Frequently asked questions"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FAQ(),
                      ),
                    );
                  },
                ),
                const Divider(),
                /* const Divider(),
                ListTile(
                  leading: const Icon(Icons.file_copy_outlined),
                  title: const Text("Termes d'utilisation [TODO]"),
                  onTap: () {
                  },
                ),*/
              ],
            ),
            const SizedBox(height: 30),
            Center(child: Text('Version $numVersion', style: const TextStyle(fontSize: 12)))
          ],
        ),
      ),
    );
  }
}
