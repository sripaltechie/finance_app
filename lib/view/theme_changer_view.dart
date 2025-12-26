import 'package:chanda_finance/view_model/theme_changer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ThemeChangerView extends StatefulWidget {
  const ThemeChangerView({super.key});

  @override
  State<ThemeChangerView> createState() => _ThemeChangerViewState();
}

class _ThemeChangerViewState extends State<ThemeChangerView> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Change Theme"),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
              title: const Text("Light Mode"),
              value: ThemeMode.light,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
          RadioListTile<ThemeMode>(
              title: const Text("Dark Mode"),
              value: ThemeMode.dark,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
          RadioListTile<ThemeMode>(
              title: const Text("System Mode"),
              value: ThemeMode.system,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
        ],
      ),
    );
  }
}
