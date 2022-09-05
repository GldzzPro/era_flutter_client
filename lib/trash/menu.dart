import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

enum _MenuValues {
  page2,
  settings,
  chickens,
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (c) => '🤔',
      darkTheme: ThemeData.dark(),
      title: '🤔',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    checkOnTheChickens() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('all the chickens are in the coop')));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PopupMenuButton<_MenuValues>(
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Text('Settings'),
              value: _MenuValues.settings,
            ),
            PopupMenuItem(
              child: Text('Page2'),
              value: _MenuValues.page2,
            ),
            PopupMenuItem(
              child: Text('Check on the chickens'),
              value: _MenuValues.chickens,
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case _MenuValues.page2:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => SecondPage()));
                break;
              case _MenuValues.settings:
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => SettingsPage()));
                break;
              case _MenuValues.chickens:
                checkOnTheChickens();
                break;
            }
          },
        ),
      ),
    );
  }
}

class SecondPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('the 2nd page'),
      ),
    );
  }
}

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('settings page'),
      ),
    );
  }
}
