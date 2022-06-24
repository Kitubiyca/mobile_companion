import 'dart:ui';
import 'package:dnd_companion/data/equipment/armor.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:dnd_companion/main.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
        floatingActionButton: Utils.diceOverlayMenu(context),
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    repeat: ImageRepeat.repeatY,
                    alignment: AlignmentDirectional(0, 0),
                    fit: BoxFit.fitHeight,
                    image: AssetImage("resources/paper.jpg")),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: const Color(0xFF5c5c5c),
                                border: Border.all(
                                    width: 4, color: item.rare.getColor()),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(image: item.getImage()),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Text(
                                    item.getType(),
                                    style: const TextStyle(
                                        fontSize: 20, fontStyle: FontStyle.italic),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      (item is Weapon
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Text.rich(
                                TextSpan(
                                    text: "Свойства: ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                    children: [
                                      TextSpan(
                                          text: item.getFeatures(),
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                                    ]),
                              ),
                            )
                          : Container()),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: "Стоимость: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: (item.cost/100).toStringAsFixed(2) + " ",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                                  ]),
                            ),
                            Image.asset("resources/icons/gold.png", width: 20, height: 20,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "Вес: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: item.weight.toString() + " фнт.",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "Редкость: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: item.rare.getText(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      ),
                      (item is Weapon
                          ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "Урон: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: item.getStringDamage(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      )
                          : Container()),
                      ((item is Armor && item.AC != 0)
                          ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "КД: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: item.AC.toString() + (item.ACModifier!=Characteristic.none ? (" + модификатор " + item.ACModifier.getText().substring(0, 3).capitalize() + (item.maxModifier > 0 ? (" (макс. " + item.maxModifier.toString() + ")") : "")) : ""),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      )
                          : Container()),
                      (item is Armor && item.requirement > 0
                          ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "Требование: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: "Сил " + item.requirement.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      )
                          : Container()),
                      (item is Armor && item.noise
                          ? const Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: "Скрытность: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              children: [
                                TextSpan(
                                    text: "помеха",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                              ]),
                        ),
                      )
                          : Container()),
                    ],
                  ),
                  (item.description != "" ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff3f3f3f), // 73160f // 5c5c5c
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.description, style: const TextStyle(fontSize: 18),),
                        ),
                      ),
                    ),
                  ) : Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

}
