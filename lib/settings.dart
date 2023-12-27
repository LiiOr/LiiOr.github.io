import 'package:flutter/material.dart';
import 'package:mylabs/faq.dart';
import 'package:mylabs/globals.dart';
import 'package:mylabs/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool dkSwitchVal = isDark;
  String dkSwitchText = isDark ? 'Activé' : 'Désactivé';
  Icon darkIcon = isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode);

  Future<void> setTheme(value) async {
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
                      setTheme(value);
                      if (value == true) {
                        dkSwitchText = 'Activé';
                        darkIcon = const Icon(Icons.dark_mode);
                      } else {
                        dkSwitchText = 'Désactivé';
                        darkIcon = const Icon(Icons.light_mode);
                      }
                    });
                  },
                  secondary: darkIcon,
                ),
                const Divider(),
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
            Center(
                child: Text('Version $numVersion',
                    style: const TextStyle(fontSize: 12)))
          ],
        ),
      ),
    );
  }
}
