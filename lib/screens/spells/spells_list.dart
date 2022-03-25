import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/screens/spells/spell_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SpellList extends StatefulWidget {
  const SpellList({Key? key}) : super(key: key);

  @override
  State<SpellList> createState() => _SpellListState();
}

class _SpellListState extends State<SpellList> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox<Spell>('spells'),
          builder: (context, box) {
            if (box.hasData) {
              var spells = box.data as Box;
              return ListView.builder(
                  itemCount: spells.length,
                  itemBuilder: (BuildContext context, index) =>
                  InkWell(
                    onTap: () => {Navigator.pushNamed(context, "/spells/view", arguments: spells.getAt(index))},
                    child: ListTile(
                    title: Text(spells.getAt(index).name, style: const TextStyle(fontSize: 20),),
                  ),)
                      );
            } else {if (box.hasError) {return const Center(child: Text("Loading Error", style: TextStyle(fontSize: 30,)),);} else {
              return const Center(child: CircularProgressIndicator());
            }}}
      ),
    );
  }
}
