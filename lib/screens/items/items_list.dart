import 'package:dnd_companion/data/equipment/item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Hive.openBox<Item>('items'),
          builder: (context, box) {
            if (box.hasData) {
              var items = box.data as Box;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, index) =>
                      InkWell(
                        onTap: () => {Navigator.pushNamed(context, "/items/view", arguments: items.getAt(index))},
                        child: ListTile(
                          title: Text(items.getAt(index).name, style: const TextStyle(fontSize: 20),),
                        ),)
              );
            } else {if (box.hasError) {return const Center(child: Text("Loading Error", style: TextStyle(fontSize: 30,)),);} else {
              return const Center(child: CircularProgressIndicator());
            }}}
      ),
    );
  }
}
