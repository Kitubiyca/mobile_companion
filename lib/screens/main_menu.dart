import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DnD companion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
            ),
            _menuButton("characters", "somePath"),
            Container(
              height: 60,
            ),
            _menuButton("npcs", "somePath"),
            Container(
              height: 60,
            ),
            _menuButton("spells", "somePath"),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(String name, String path) {
    return SizedBox(
        height: 100,
        width: 300,
        child: Material(
          color: Colors.blue,
          child: InkWell(
            splashColor: Colors.blueAccent,
            onTap: () => null,
            child: Center(child: Text(name)),
          ),
        ));
  }
}
