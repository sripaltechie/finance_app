import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/routes_name.dart';
import '../view_model/theme_changer_view_model.dart';
import '../view_model/user_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late bool _isDarkModeEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<MyAppState>(context);
    final themeChanger = Provider.of<ThemeChanger>(context);
    _isDarkModeEnabled =
        (Theme.of(context).brightness == Brightness.dark) ? true : false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Toggle the switch to change the app theme'),
            value: _isDarkModeEnabled,
            onChanged: (value) {
              setState(() {
                _isDarkModeEnabled = value;
                if (_isDarkModeEnabled) {
                  themeChanger.setTheme(ThemeMode.dark);
                } else {
                  themeChanger.setTheme(ThemeMode.light);
                }
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log out"),
            onTap: () {
              Provider.of<UserViewModel>(context, listen: false).remove();
              Navigator.of(context).pushReplacementNamed(
                RoutesName.login,
                // arguments: 'Hello there from the first page!',
              );
            },
          ),
        ],
      ),
    );
  }
}
