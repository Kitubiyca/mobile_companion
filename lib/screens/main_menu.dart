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
            _menuButton(context, "Персонажи", "/characters"),
            Container(
              height: 60,
            ),
            _menuButton(context, "Залинания", "/spells"),
            Container(
              height: 60,
            ),
            _menuButton(context, "Предметы", "/items"),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String name, String path) {
    return SizedBox(
        height: 100,
        width: 300,
        child: Material(
          color: Colors.blue,
          child: InkWell(
            splashColor: Colors.blueAccent,
            onTap: () => {Navigator.pushNamed(context, path)},
            child: Center(child: Text(name)),
          ),
        ));
  }
}
