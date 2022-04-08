import 'package:dnd_companion/data/character/character.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox<Character>('characters'),
          builder: (context, box) {
            if (box.hasData) {
              var characters = box.data as Box;
              return ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, index) =>
                      InkWell(
                        onTap: () => {Navigator.pushNamed(context, "/characters/view", arguments: characters.getAt(index))},
                        child: ListTile(
                          title: Text(characters.getAt(index).name, style: const TextStyle(fontSize: 20),),
                        ),)
              );
            } else {if (box.hasError) {return const Center(child: Text("Loading Error", style: TextStyle(fontSize: 30,)),);} else {
              return const Center(child: CircularProgressIndicator());
            }}}
      ),
    );
  }
}
