import 'package:dnd_companion/data/equipment/item.dart';
import 'package:flutter/material.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context)!.settings.arguments as Item;
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
            "Название: " + item.name,
            style: const TextStyle(fontSize: 24),
          ),
          Visibility(
            visible: item.description.isNotEmpty,
            child: Text(
              "Описание: " + item.description,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Text(
            "Вес: " + item.weight.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Стоимость: " + item.cost.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          (item.notes.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Метки:",
                      style: TextStyle(fontSize: 24),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: item.notes.length,
                        itemBuilder: (BuildContext context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.notes.elementAt(index),
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            )),
                  ],
                )
              : Container()),
        ],
      ),
    ));
  }
}
