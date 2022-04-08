import 'package:flutter/material.dart';
import '../../data/character/character.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  @override
  Widget build(BuildContext context) {
    String result = "";
    final Character character = ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                "Имя персонажа: " + character.name,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "Раса: " + character.race.name,
                style: const TextStyle(fontSize: 24),
              ),
              InkWell(
                onTap: (){result = character.weaponHotkeys.elementAt(0).weapon.damage.elementAt(0).roll().toString(); setState(() {});},
                child: Container(
                  width: 250,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text(character.weaponHotkeys.elementAt(0).name))
                ),
              ),
              const SizedBox(height: 20,),
              Text(result)
            ],
          ),
        ));
  }
}
