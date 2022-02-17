import 'package:dnd_companion/screens/main_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DnD Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenu(),
    );
  }
}