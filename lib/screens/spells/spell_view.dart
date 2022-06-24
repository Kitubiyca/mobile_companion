import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpellView extends StatefulWidget {
  const SpellView({Key? key}) : super(key: key);

  @override
  State<SpellView> createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {

  int _level = 0;
  bool _set = false;

  @override
  Widget build(BuildContext context) {
    final Spell spell = ModalRoute
        .of(context)!
        .settings
        .arguments as Spell;
    if(!_set) _level = spell.level;
    return Scaffold(
        floatingActionButton: Utils.diceOverlayMenu(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: MediaQuery
                    .of(context)
                    .size
                    .height),
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
                            padding: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.05,
                                ),
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5c5c5c),
                                    border: Border.all(
                                        width: 4,
                                        color: const Color(0xff3f3f3f)),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: spell.getImage()),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.05,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.02,
                                      ),
                                      Text(
                                        spell.name,
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.01,
                                      ),
                                      Text(
                                        (spell.level == 0
                                            ? "Заговор"
                                            : "Уровень " +
                                            spell.level.toString()) + ", " +
                                            spell.school + (spell.ritual ? ", ритуал" : ""),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.01,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text.rich(
                              TextSpan(
                                  text: "Время накладывания: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: spell.castingTime.toString() + (spell.bonus ? " бонусное" : "") +
                                            (spell.castingTime > 1 ? " действия" : " действие"),
                                        style: const TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text.rich(
                              TextSpan(
                                  text: "Дистанция: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: spell.range,
                                        style: const TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                            ),
                          ),
                          (spell.getComponents().isNotEmpty ? Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text.rich(
                              TextSpan(
                                  text: "Компоненты: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: spell.getComponents(),
                                        style: const TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                            ),
                          ) : Container()),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text.rich(
                              TextSpan(
                                  text: "Длительность: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: (spell.concentration ? "концентрация, " : "") + spell.duration,
                                        style: const TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.normal)),
                                  ]),
                            ),
                          ),
                          (spell.impact.isNotEmpty ? Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text.rich(
                              TextSpan(
                                  text: "Воздействие: ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  children: [
                                    TextSpan(
                                        text: spell.getStringImpact()[_level],
                                        style: const TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                          ) : Container()),
                          (spell.impact.isNotEmpty ? Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Уровень" + (spell.level == 0 ? " персонажа: " : ": "), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                Expanded(child: levelPicker(spell)),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
                              ],
                            ),
                          ) : Container()),
                        ],
                      ),
                      (spell.description != "" ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: MediaQuery
                              .of(context)
                              .size
                              .width - 10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff3f3f3f),
                                // 73160f // 5c5c5c
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(spell.description,
                                style: const TextStyle(fontSize: 18),),
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

  Widget levelPicker(Spell spell){

    Widget pickerOrb(int num){
      return InkWell(
        onTap: (){setState(() {if(spell.level <= num) {
          _set = true;
          _level = num;
        }});},
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: (spell.level == 0 ? null : (_level == num ? const DecorationImage(image: AssetImage("resources/icons/slot.png")) : const DecorationImage(image: AssetImage("resources/icons/slot.png")))),
            color: (spell.level > num ? const Color(0xffccc2c0) : (_level == num ? const Color(0xff6b74ba) : const Color(0xffaae0fa))), //36A366
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Center(child: (spell.level == 0 ? Text((num == 0 ? "1" : num.toString()), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),) : Container()),),
        ),
      );
    }

    if(spell.level != 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          pickerOrb(1),
          pickerOrb(2),
          pickerOrb(3),
          pickerOrb(4),
          pickerOrb(5),
          pickerOrb(6),
          pickerOrb(7),
          pickerOrb(8),
          pickerOrb(9),
        ],
      );
    } else {
      List<Widget> orbs = [];
      for(int level in spell.impact.keys){
        orbs.add(pickerOrb(level));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: orbs,
      );
    }
  }

/*  String getTextRange(Spell spell){
    if(spell.range%5280==0){
      int range = (spell.range/5280).round();
      if(range>14 && range<11 && range%10>1 && range%10<5) return range.toString() + " мили";
      if(range!=11 && range%10==1) return range.toString() + " миля";
      return range.toString() + " миль";
    } else {
      if(spell.range>14 && spell.range<11 && spell.range%10>1 && spell.range%10<5) return spell.range.toString() + " фута";
      if(spell.range!=11 && spell.range%10==1) return spell.range.toString() + " фут";
      return spell.range.toString() + " футов";
    }
  }*/

}
