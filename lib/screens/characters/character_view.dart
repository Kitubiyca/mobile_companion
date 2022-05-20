import 'dart:ui';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../data/character/character.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {

  // TODO добавить сложность заклинания и её характеристику

  // TODO добавить предмет магической фокусировки

  final PageController _controller = PageController(initialPage: 1);

  Set<String> _chosenStats = {};

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(controller: _controller, children: [
      ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: AlignmentDirectional(0, 0),
                fit: BoxFit.cover,
                image: AssetImage("resources/paper.jpg")
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView.builder(
              itemCount: character.weaponHotkeys.length + 1,
              itemBuilder: (context, index){
                if(index == 0){
                  return InkWell(
                    onTap: (){showCreator(context, character);},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54, width: 2),
                      ),
                      child: const Center(child: Text("+", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
                    ),
                  );
                }
                return ListTile(
                  title: Text(character.weaponHotkeys.elementAt(index - 1).name),
                  subtitle: Text(character.weaponHotkeys.elementAt(index - 1).weapon.name + " / " + character.weaponHotkeys.elementAt(index - 1).weapon.damage.first.name),
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        "Броски атаки: " + (Dice(1, 20).roll().first + character.getStatBonus(character.weaponHotkeys.elementAt(index - 1).characteristic.getText())).toString() + " и " +
                            (Dice(1, 20).roll().first + character.getStatBonus(character.weaponHotkeys.elementAt(index - 1).characteristic.getText())).toString() + "      Бросок урона: " +
                          (character.weaponHotkeys.elementAt(index - 1).weapon.damage.elementAt(0).roll().first + character.getStatBonus(character.weaponHotkeys.elementAt(index - 1).characteristic.getText())).toString()
                      ),
                    ));
                  },
                );
              },
            ),
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  repeat: ImageRepeat.repeatY,
                  alignment: AlignmentDirectional(0, 0),
                  fit: BoxFit.fitHeight,
                  image: AssetImage("resources/paper.jpg")
                ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xffFFD700)),
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                alignment: AlignmentDirectional(0, 0),
                                fit: BoxFit.fitHeight,
                                image:
                                    AssetImage("resources/backgrounds/filler.jpg")),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5, color: const Color(0xff58007D)),
                                  borderRadius: BorderRadius.circular(20),
                                  image: (character.name == "Астерион" ? const DecorationImage(
                                      alignment: AlignmentDirectional(0, 0),
                                      fit: BoxFit.fitHeight,
                                      image: AssetImage(
                                          "resources/portraits/human_test.jpg")) : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Хиты: ", style: TextStyle(fontSize: 16, color: Colors.grey, fontStyle: FontStyle.italic),),
                            Text("6/6", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                          ],
                        )
                      ],
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
                            (character.characterClass.length > 1 ? character.name + " уровня " + _getFullLevel(character).toString() : character.name),
                            style: const TextStyle(fontSize: 24),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            character.race.name,
                            style: const TextStyle(
                                fontSize: 20, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.only(),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: character.characterClass.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.characterClass.keys
                                          .elementAt(index)
                                          .name +
                                      " уровня " +
                                      character.characterClass.values
                                          .elementAt(index)
                                          .toString(),
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
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text((character.getProficiencyBonus().abs() < 0 ? "- " : "+ ") + character.getProficiencyBonus().abs().toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        const Text("бонус", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        const Text("мастерства", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                      ]
                    ),
                    Column(
                        children: [
                          Text(character.race.speed.toString() + " фт.", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("скорость", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("передвижения", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                    Column(
                        children: [
                          Text((character.getInitiativeBonus() < 0 ? "- " : "+ ") + character.getInitiativeBonus().abs().toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("бонус", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("инициативы", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                    Column(
                        children: [
                          Text(character.getArmorClass().toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("класс", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("Брони", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statWidget(character, "str", "Сила"),
                    _statWidget(character, "dex", "Ловкость"),
                    _statWidget(character, "con", "Телосложение"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statWidget(character, "int", "Интеллект"),
                    _statWidget(character, "wis", "Мудрость"),
                    _statWidget(character, "cha", "Харизма"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  const Text("Пассивная мудрость (Внимательность)", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(child: Text(character.getSkillCheckResult(SkillCheck("Внимательность", Characteristic.wisdom, true), fixed: true).toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                  ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                ],),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  const Text("Пассивный интеллект (Анализ)", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(child: Text(character.getSkillCheckResult(SkillCheck("Анализ", Characteristic.intelligence, true), fixed: true).toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                  ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                ],),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  const Text("Пассивная мудрость (Проницательность)", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(child: Text(character.getSkillCheckResult(SkillCheck("Проницательность", Characteristic.wisdom, true), fixed: true).toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                ],),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              ],
            ),
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: AlignmentDirectional(0, 0),
              fit: BoxFit.fitHeight,
              image: AssetImage("resources/paper.jpg")),
        ),
        child: Container(),
      ),
    ]),
    );
  }

  Widget _statWidget(Character character, String identifier, String name){
    Color color = const Color(0x00000000);
    bool chosen = false;
    if(character.characterClass.keys.elementAt(0).savingChecks.contains(identifier)) {
      color = const Color(0xff000000);
    }
    if(_chosenStats.contains(identifier)) {
      color = const Color(0xffffffff);
      chosen = true;
    }
    int num = character.getStatBonus(identifier) + (chosen ? character.getProficiencyBonus() : 0);
    return Column(
      children: [
        (chosen ? const Text("- спас.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),) :
        const Text("", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)),
        Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
        InkWell(
          onTap: (){
            int roll = Dice(1, 20).roll().first;
            String symbol = (num < 0 ? "-" : "+");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(roll.toString() + symbol + num.abs().toString() + "=" + (roll + num).toString() + " (D20 + " + identifier + " modifier)"),
            ));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5, color: Colors.black54),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text((num < 0 ? "- " : "+ ") + num.abs().toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),)
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
        InkWell(
          onTap: (){
            setState(() {
              if(chosen){
                _chosenStats.remove(identifier);
              } else if(character.characterClass.keys.elementAt(0).savingChecks.contains(identifier)){
                _chosenStats.add(identifier);
              }
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5, color: Colors.black54),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Text((character.stats[identifier] ?? 0).toString(), style: const TextStyle(fontSize: 22),)
            ),
          ),
        ),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
                width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }

  int _getFullLevel(Character character){
    int ret = 0;
    for(int obj in character.characterClass.values){
      ret += obj;
    }
    return ret;
  }








  TextEditingController controller = TextEditingController();
  Weapon? value;
  Characteristic? value2 = Characteristic.strength;

  void showCreator(BuildContext context, Character character) {

    //Weapon? value;
    //String? value2 = "str";

    value ??= character.inventory.keys.first as Weapon;

    List<DropdownMenuItem<Weapon>> weapons = [];
    for(Item item in character.inventory.keys){
      weapons.add(DropdownMenuItem<Weapon>(value: item as Weapon, child: Text(item.name),));
    }

    print(character.inventory.toString());

    Widget cancelButton = TextButton(
      child: const Text("Назад"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget createButton = TextButton(
      child: const Text("Сохранить"),
      onPressed: () {
        if (controller.text.isNotEmpty && value != null && value2 != Characteristic.none) {
          setState(() {
            character.weaponHotkeys.add(WeaponHotkey.smart(name: controller.text, weapon: value!, characteristic: value2!));
          });
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Ошибка"),
          ));
        }
      },
    );

    Widget textField = TextField(
      controller: controller,
      autofocus: true,
      maxLength: 20,
      decoration: const InputDecoration(labelText: "Название категории"),
    );

    Widget picker = StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          DropdownButton<Weapon>(
            value: value,
            onChanged: (Weapon? selectedValue){
              setState(() {
                value = selectedValue;
              });
            },
            items: weapons,),
          DropdownButton<Characteristic>(
            value: value2,
            onChanged: (Characteristic? selectedValue){
              setState(() {
                value2 = selectedValue ?? Characteristic.none;
              });
            },
            items: const [
            DropdownMenuItem<Characteristic>(child: Text("Сила"), value: Characteristic.strength,),
            DropdownMenuItem<Characteristic>(child: Text("Ловкость"), value: Characteristic.dexterity,),
            DropdownMenuItem<Characteristic>(child: Text("Выносливость"), value: Characteristic.constitution,),
            DropdownMenuItem<Characteristic>(child: Text("Интеллект"), value: Characteristic.intelligence,),
            DropdownMenuItem<Characteristic>(child: Text("Мудрость"), value: Characteristic.wisdom,),
            DropdownMenuItem<Characteristic>(child: Text("Харизма"), value: Characteristic.charisma,),
          ],),
        ],
      );
    });

    AlertDialog info = AlertDialog(
      title: textField,
      content: picker,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [cancelButton, createButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return info;
        });
  }

}
