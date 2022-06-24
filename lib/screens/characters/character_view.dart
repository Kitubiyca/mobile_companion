import 'dart:math';
import 'dart:ui';
import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/armor.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:dnd_companion/main.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import '../../data/character/character.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({Key? key}) : super(key: key);

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {

  // TODO добавить сложность заклинания и её характеристику

  // TODO добавить предмет магической фокусировки

  Offset? _tapPos;
  Offset? _tapPosItems;
  Offset? _tapPosSpells;
  final PageController _controller = PageController(initialPage: 2);
  //_controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.ease);

  Function _callback = ((){});
  Set<Characteristic> _chosenStats = {};
  int _pageNum = 4;

  @override
  Widget build(BuildContext context) {
    Character character =
        (ModalRoute.of(context)!.settings.arguments as List).elementAt(0) as Character;
    _callback = (ModalRoute.of(context)!.settings.arguments as List).elementAt(1) as Function;
    return Scaffold(
      floatingActionButton: Utils.diceOverlayMenu(context),
      resizeToAvoidBottomInset: false,
      body: PageView(controller: _controller, children: [
      _skillsPage(context, character),
      _spellsPage(context, character),
      _overViewPage(context, character),
      _inventoryPage(context, character),
    ]),
    );
  }

  Widget _spellsPage(BuildContext context, Character character){
    return GestureDetector(
      onLongPressDown: (details) => setState(() => _tapPosSpells = details.globalPosition),
      onTapDown: (details) => setState(() => _tapPosSpells = details.globalPosition),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: AlignmentDirectional(0, 0),
                  fit: BoxFit.fitHeight,
                  image: AssetImage("resources/paper.jpg")),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _navigationRow("Книга заклинаний"),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Expanded(child: Divider(thickness: 1.5, color: Colors.black45, indent: 16,)),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("Модификаторы", style: TextStyle(fontSize: 20),),
                    ),
                    Expanded(child: Divider(thickness: 1.5, color: Colors.black45, endIndent: 16,)),
                  ],
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        children: [
                          Text(character.getSpellCastingAbility().getText().substring(0, 3).capitalize(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("характеристика", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("накладывания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("заклинания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                    Column(
                        children: [
                          Text((character.getSpellAttackMod() < 0 ? "- " : "+ ") + character.getSpellAttackMod().toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("модификатор", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("накладывания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("заклинания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                    Column(
                        children: [
                          Text(character.getDC().toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          const Text("сложность", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("накладывания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                          const Text("заклинания", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),),
                        ]
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(child: Divider(thickness: 1.5, color: Colors.black45, indent: 16,)),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("Ячейки заклинаний", style: TextStyle(fontSize: 20),),
                    ),
                    InkWell(
                        onTap: () {
                          if(_tapPosSpells != null){
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(_tapPosSpells!.dx, _tapPosSpells!.dy, _tapPosSpells!.dx, 0),
                              items: const [
                                PopupMenuItem(
                                  child: Text("Восстановить ячейки"),
                                  value: true,
                                )
                              ],
                              elevation: 8.0,
                            ).then((value){
                              if(value == true){
                                character.fillSpellSlots();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ячейки восстановлены"),));
                                setState(() {});
                                return;
                              }
                            });
                          }
                        },
                        child: const Icon(Icons.add_rounded, size: 40,)),
                    const SizedBox(width: 10,),
                    const Expanded(child: Divider(thickness: 1.5, color: Colors.black45, endIndent: 16,)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getSpellSlot(character, 1),
                      _getSpellSlot(character, 2),
                      _getSpellSlot(character, 3),
                      _getSpellSlot(character, 4),
                      _getSpellSlot(character, 5),
                      _getSpellSlot(character, 6),
                      _getSpellSlot(character, 7),
                      _getSpellSlot(character, 8),
                      _getSpellSlot(character, 9),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(child: Divider(thickness: 1.5, color: Colors.black45, indent: 16,)),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text("Заклинания", style: TextStyle(fontSize: 20),),
                    ),
                    InkWell(
                        onTap: () async {
                          Box<Spell> spellBox = await Hive.openBox<Spell>("Spells");
                          List<Spell> spells = spellBox.values.toList();
                          spellBox.close();
                          if(_tapPosSpells != null){
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(_tapPosSpells!.dx, _tapPosSpells!.dy, _tapPosSpells!.dx, 0),
                              items: (spells..removeWhere((element) => character.knownSpells.contains(element))).map((e) => PopupMenuItem(child: Text(e.name), value: e,)).toList(),
                              elevation: 8.0,
                            ).then((value){
                              if(value != null){
                                character.knownSpells.add(value);
                                character.save();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заклинание записано"),));
                                setState(() {});
                                return;
                              }
                            });
                          }
                        },
                        child: const Icon(Icons.add_rounded, size: 40,)),
                    const SizedBox(width: 10,),
                    const Expanded(child: Divider(thickness: 1.5, color: Colors.black45, endIndent: 16,)),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: character.knownSpells.length,
                        itemBuilder: (context, index){
                          Spell spell = character.knownSpells.elementAt(index);
                          int? level;
                          if(spell.impact.isNotEmpty){
                            if(spell.level == 0){
                              level = spell.getStringImpact().keys.lastWhere((element) => element <= character.level);
                            } else {
                              level = spell.getStringImpact().keys.first;
                            }
                          }
                          return InkWell(
                            onTap: () async {
                              if(_tapPosSpells != null){
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(_tapPosSpells!.dx, _tapPosSpells!.dy, _tapPosSpells!.dx, 0),
                                  items: const [
                                    PopupMenuItem(
                                      child: Text("Применить"),
                                      value: true,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Стереть"),
                                      value: false,
                                    ),
                                  ],
                                  elevation: 8.0,
                                ).then((value){
                                  if(value == true){
                                    if(spell.impact.isNotEmpty){
                                      if(spell.level == 0){
                                        Map<String, int> ret = {};
                                        for(DamageType dt in spell.impact[level]!.keys){
                                          for(Dice dice in spell.impact[level]![dt]!){
                                            ret[dt.getText() + " " + dice.name] = dice.roll().first;
                                          }
                                        }
                                        Utils.showAlertRoll(context, spell.name, ret);
                                      } else {
                                        List<PopupMenuItem> menus = [];
                                        for(int i = spell.level; i < 10; i++){
                                          menus.add(PopupMenuItem(value: i, child: Text("Уровень " + i.toString()),));
                                        }
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(_tapPosSpells!.dx, _tapPosSpells!.dy, _tapPosSpells!.dx, 0),
                                          items: menus,
                                          elevation: 8.0,
                                        ).then((levelValue){
                                          Map<String, int> ret = {};
                                          for(DamageType dt in spell.impact[levelValue]!.keys){
                                            for(Dice dice in spell.impact[levelValue]![dt]!){
                                              ret[dt.getText() + " " + dice.name] = dice.roll().first;
                                            }
                                          }
                                          if(character.spellSlots[levelValue - 1] > 0) character.spellSlots[levelValue - 1] = character.spellSlots[levelValue - 1] - 1;
                                          setState(() {});
                                          character.save();
                                          Utils.showAlertRoll(context, spell.name, ret);
                                        });
                                      }
                                      return;
                                    } else {
                                      if(spell.level == 0){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заговор применён"),));
                                      } else {
                                        if(character.spellSlots[spell.level - 1] > 0) character.spellSlots[spell.level - 1] = character.spellSlots[spell.level - 1] - 1;
                                        setState(() {});
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заклинание применено"),));
                                      }
                                      return;
                                    }
                                  }
                                  if(value == false){
                                    character.knownSpells.remove(spell);
                                    character.save();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заклинание стёрто"),));
                                    setState(() {});
                                    return;
                                  }
                                });
                              }
                            },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 115),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(spell.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                            Text(spell.school.capitalize() + ", " + spell.getStringLevel(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                            Text("Время накладывания: " + spell.getCastingTime(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                            Text("Дистанция: " + spell.range, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45,)),
                                            Text("Компоненты: " + spell.getComponents(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45,)),
                                            Text("Длительность: " + spell.getDuration(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                            (spell.ritual ? const Text("Ритуал", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, color: Colors.black45),) : Container()),
                                            (level != null ? Text(spell.getStringImpact()[level].toString(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black45),) : Container()),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,),
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSpellSlot(Character character, int index){
    return InkWell(
      enableFeedback: character.checkSpellSlot(index),
      onTap: (){
        if(_tapPosSpells != null && character.checkSpellSlot(index)){
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(_tapPosSpells!.dx, _tapPosSpells!.dy, _tapPosSpells!.dx, 0),
            items: [
              PopupMenuItem(
                enabled: character.spellSlots.elementAt(index - 1) < 4,
                child: Text("добавить"),
                value: true,
              ),
              PopupMenuItem(
                enabled: character.spellSlots.elementAt(index - 1) > 0,
                child: Text("убавить"),
                value: false,
              ),
            ],
            elevation: 8.0,
          ).then((value){
            if(value != null){
              if(value){
                character.spellSlots[index - 1] = character.spellSlots[index - 1] + 1;
                character.save();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Получена ячейка"),));
                setState(() {});
              } else {
                character.spellSlots[index - 1] = character.spellSlots[index - 1] - 1;
                character.save();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Потеряна ячейка"),));
                setState(() {});
              }
              return;
            }
          });
        }
      },
      child: Visibility(
        visible: character.checkSpellSlot(index),
        maintainSize: true,
        maintainState: true,
        maintainAnimation: true,
        child: Column(
          children: [
            Text(_getRomanNumerical(index), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            const SizedBox(height: 10,),
            Text((character.spellSlots.asMap().keys.contains(index - 1) ? character.spellSlots.elementAt(index - 1) : 0).toString(), style: const TextStyle(fontSize: 24),)
          ],
        ),
      ),
    );
  }

  String _getRomanNumerical(int num){
    switch(num){
      case 1: return "I";
      case 2: return "II";
      case 3: return "III";
      case 4: return "IV";
      case 5: return "V";
      case 6: return "VI";
      case 7: return "VII";
      case 8: return "VIII";
      case 9: return "IX";
      default: return "0";
    }
  }

  Widget _skillsPage(BuildContext context, Character character){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: AlignmentDirectional(0, 0),
                fit: BoxFit.cover,
                image: AssetImage("resources/paper.jpg")
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              _navigationRow("Умения"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: character.knownSkills.length,
                  itemBuilder: (context, index){
                    Skill skill = character.knownSkills.keys.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff3f3f3f),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Center(child: Text(skill.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),),
                              ),
                              Text(skill.description,
                                style: const TextStyle(fontSize: 18),),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inventoryPage(BuildContext context, Character character){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: GestureDetector(
        onLongPressDown: (details) => setState(() => _tapPosItems = details.globalPosition),
        onTapDown: (details) => setState(() => _tapPosItems = details.globalPosition),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                repeat: ImageRepeat.repeatY,
                  alignment: AlignmentDirectional(0, 0),
                  fit: BoxFit.cover,
                  image: AssetImage("resources/paper.jpg")),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _navigationRow("Инвентарь"),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Expanded(child: Divider(thickness: 1.5, color: Colors.black45,)),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text("Экипированные предметы", style: TextStyle(fontSize: 20),),
                          ),
                          Expanded(child: Divider(thickness: 1.5, color: Colors.black45,)),
                        ],
                      ),
                      GestureDetector(
                        onLongPressDown: (details) => setState(() => _tapPosItems = details.globalPosition),
                        onTapDown: (details) => setState(() => _tapPosItems = details.globalPosition),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                            itemCount: character.equippedItems.length,
                            itemBuilder: (context, index){
                              Item item = character.equippedItems.elementAt(index);
                              if(item is Weapon){
                                return InkWell(
                                  onTap: (){_handleEquippedWeapon(context, character, item, _tapPosItems);},
                                  child: SizedBox(
                                    height: 115,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                  Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                  Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Row(
                                                    children: [
                                                      Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                      Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                            const Spacer(),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(item.getStringDamage(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Visibility(visible: item.versatileDamage.isNotEmpty, child: Text("Фехт: " + item.getStringVersatileDamage(), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: true, child: Text(item.getFeatures().split(", ").join("\n"), textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                ]
                                            ),
                                            const SizedBox(width: 20,),
                                          ],
                                        ),
                                        Visibility(visible: index < character.equippedItems.length - 1, child: Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,)),                                    ],
                                    ),
                                  ),
                                );
                              }
                              if(item is Armor){
                                return InkWell(
                                  onTap: (){_handleEquippedItems(character, item, _tapPosItems);},
                                  child: SizedBox(
                                    height: 115,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                  Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                  Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Row(
                                                    children: [
                                                      Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                      Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                            const Spacer(),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text("КД: " + item.AC.toString(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Visibility(visible: item.ACModifier != Characteristic.none, child: Text("Мод: " + item.ACModifier.getText().substring(0, 3), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: item.noise, child: const Text("Шум", style: TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: item.requirement > 0, child: Text("Треб: " + item.requirement.toString(), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                ]
                                            ),
                                            const SizedBox(width: 20,),
                                          ],
                                        ),
                                        Visibility(visible: index < character.equippedItems.length - 1, child: Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,)),                                    ],
                                    ),
                                  ),
                                );
                              }
                              return InkWell(
                                onTap: (){_handleEquippedItems(character, item, _tapPosItems);},
                                child: SizedBox(
                                  height: 115,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                Row(
                                                  children: [
                                                    Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                    Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                  ],
                                                ),
                                              ]
                                          ),
                                          const Spacer(),
                                          const SizedBox(width: 20,),
                                        ],
                                      ),
                                      Visibility(visible: index < character.equippedItems.length - 1, child: Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Expanded(child: Divider(thickness: 1.5, color: Colors.black45,)),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text("Все предметы", style: TextStyle(fontSize: 20),),
                          ),
                          InkWell(
                            onTap: () async {
                              Box<Item> itemBox = await Hive.openBox<Item>("Items");
                              List<Item> items = itemBox.values.toList();
                              itemBox.close();
                              if(_tapPosItems != null){
                                showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(_tapPosItems!.dx, _tapPosItems!.dy, _tapPosItems!.dx, 0),
                                  items: items.map((e) => PopupMenuItem(child: Text(e.name), value: e,)).toList(),
                                  elevation: 8.0,
                                ).then((value){
                                  if(value != null){
                                    character.addItem(value, 1);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Получен предмет"),));
                                    setState(() {});
                                    return;
                                  }
                                });
                              }
                            },
                              child: const Icon(Icons.add_rounded, size: 40,)),
                          const SizedBox(width: 10,),
                          const Expanded(child: Divider(thickness: 1.5, color: Colors.black45,)),
                        ],
                      ),
                      GestureDetector(
                        onLongPressDown: (details) => setState(() => _tapPosItems = details.globalPosition),
                        onTapDown: (details) => setState(() => _tapPosItems = details.globalPosition),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: character.inventory.length,
                            itemBuilder: (context, index){
                              Item item = character.inventory.keys.elementAt(index);
                              int quantity = character.inventory.values.elementAt(index);
                              if(item is Weapon){
                                return InkWell(
                                  onTap: (){_handleAllItems(character, item, _tapPosItems);},
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 115),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                  Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                  Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Row(
                                                    children: [
                                                      Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                      Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                            const Spacer(),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(quantity.toString(), style: const TextStyle(fontSize: 22, color: Colors.black),),
                                                  Text(item.getStringDamage(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Visibility(visible: item.versatileDamage.isNotEmpty, child: Text("Фехт: " + item.getStringVersatileDamage(), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: true, child: Text(item.getFeatures().split(", ").join("\n"), textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                ]
                                            ),
                                            const SizedBox(width: 20,),
                                          ],
                                        ),
                                        Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              if(item is Armor){
                                return InkWell(
                                  onTap: (){_handleAllItems(character, item, _tapPosItems);},
                                  child: Container(
                                    height: 115,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                  Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                  Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Row(
                                                    children: [
                                                      Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                      Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                            const Spacer(),
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(quantity.toString(), style: const TextStyle(fontSize: 22, color: Colors.black),),
                                                  Text("КД: " + item.AC.toString(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                  Visibility(visible: item.ACModifier != Characteristic.none, child: Text("Мод: " + item.ACModifier.getText().substring(0, 3), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: item.noise, child: const Text("Шум", style: TextStyle(fontSize: 16, color: Colors.black45),)),
                                                  Visibility(visible: item.requirement > 0, child: Text("Треб: " + item.requirement.toString(), style: const TextStyle(fontSize: 16, color: Colors.black45),)),
                                                ]
                                            ),
                                            const SizedBox(width: 20,),
                                          ],
                                        ),
                                        Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return InkWell(
                                onTap: (){_handleAllItems(character, item, _tapPosItems);},
                                child: Container(
                                  height: 115,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, color: Colors.black),),
                                                Text(item.getType(), style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                Text(item.rare.getText(), style: TextStyle(fontSize: 16, color: item.rare.getColor()),),
                                                Text(item.weight.toString() + " фнт.", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                Row(
                                                  children: [
                                                    Text(item.cost.toString() + "  ", style: const TextStyle(fontSize: 16, color: Colors.black45),),
                                                    Image.asset("resources/icons/gold.png", width: 15, height: 15,),
                                                  ],
                                                ),
                                              ]
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(quantity.toString(), style: const TextStyle(fontSize: 22, color: Colors.black),),
                                            ]
                                          ),
                                          const SizedBox(width: 20,),
                                        ],
                                      ),
                                      Divider(thickness: 1, color: Colors.black45, endIndent: MediaQuery.of(context).size.width * 0.3,),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  void _handleEquippedItems(Character character, Item item, Offset? pos) async {
    if(pos != null){
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(pos.dx, pos.dy, pos.dx, 0),
        items: [
          const PopupMenuItem(
            child: Text("Снять"),
            value: true,
          ),
        ],
        elevation: 8.0,
      ).then((value){
        if(value == true){
          if (character.unEquipItem(item)) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Предмет убран в инвентарь"),));
          setState(() {});
          return;
        }
      });
    }
  }

  void _handleEquippedWeapon(BuildContext context, Character character, Weapon item, Offset? pos) async {
    if(pos != null){
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(pos.dx, pos.dy, pos.dx, 0),
        items: [
          PopupMenuItem(
            child: Text("Атака" + (item.features.contains(WeaponFeature.fencing) ? " (Сил)" : "")),
            value: 1,
          ),
          PopupMenuItem(
            enabled: item.features.contains(WeaponFeature.fencing) || item.throwableDistance.isNotEmpty,
            child: Text("Атака (Лов)"),
            value: 2,
          ),
          PopupMenuItem(
            child: Text("Урон: " + item.getStringDamage()),
            value: 3,
          ),
          PopupMenuItem(
            enabled: item.versatileDamage.isNotEmpty,
            child: Text("Урон: " + item.getStringVersatileDamage()),
            value: 4,
          ),
          const PopupMenuItem(
            child: Text("Снять"),
            value: 5,
          ),
        ],
        elevation: 8.0,
      ).then((value){
        if(value == 1){
          Utils.showAlertRoll(context, item.name + " - атака", item.getAttackMap(character, false));
          setState(() {});
          return;
        }
        if(value == 2){
          Utils.showAlertRoll(context, item.name + " - атака", item.getAttackMap(character, true));
          setState(() {});
          return;
        }
        if(value == 3){
          Utils.showAlertRoll(context, item.name + " - урон", {item.damage.values.first.name: item.damage.values.first.roll().first});
          setState(() {});
          return;
        }
        if(value == 4){
          Utils.showAlertRoll(context, item.name + " - урон", {item.versatileDamage.values.first.name: item.versatileDamage.values.first.roll().first});
          setState(() {});
          return;
        }
        if(value == 5){
          if (character.unEquipItem(item)) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Предмет убран в инвентарь"),));
          setState(() {});
          return;
        }
      });
    }
  }

  void _handleAllItems(Character character, Item item, Offset? pos) async {
      if(pos != null){
        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(pos.dx, pos.dy, pos.dx, 0),
          items: [
            const PopupMenuItem(
              child: Text("Экипировать"),
              value: true,
            ),
            const PopupMenuItem(
              child: Text("Выбросить"),
              value: false,
            ),
          ],
          elevation: 8.0,
        ).then((value){
          if(value == true){
            if (character.equipItem(item)) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Предмет экипирован"),));
            setState(() {});
            return;
          }
          if(value == false){
            if (character.removeItem(item, 1)) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Предмет удалён"),));
            setState(() {});
            return;
          }
        });
      }
  }

  Widget _overViewPage(BuildContext context, Character character){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints:
        BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                repeat: ImageRepeat.repeatY,
                alignment: AlignmentDirectional(0, 0),
                fit: BoxFit.cover,
                image: AssetImage("resources/paper.jpg")
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              _navigationRow("Обзор персонажа"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onLongPressDown: (details) => setState(() => _tapPos = details.globalPosition),
                        onTapDown: (details) => setState(() => _tapPos = details.globalPosition),
                        child: InkWell(
                          onTap: () async {
                            if(_tapPos != null){
                              await showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(_tapPos!.dx, _tapPos!.dy, _tapPos!.dx, 0),
                                items: [
                                  const PopupMenuItem(
                                    child: Text("Провести отдых"),
                                    value: true,
                                  ),
                                  const PopupMenuItem(
                                    child: Text("Повысить уровень"),
                                    value: false,
                                  ),
                                ],
                                elevation: 8.0,
                              ).then((value){
                                if(value == true){
                                  character.rest();
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Вы хорошо отдохнули"),));
                                }
                                if(value == false){
                                  character.levelUp();
                                  setState(() {});
                                  _callback();
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Уровень повышен"),));
                                }
                              });
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: const Color(0xff5c5c5c),
                              border: Border.all(
                                  width: 2, color: const Color(0xffFFD700)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        alignment: const AlignmentDirectional(0, 0),
                                        fit: BoxFit.cover,
                                        image: character.getImage()),
                                  ),
                                ),
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
                        children: [
                          const Text("Хиты: ", style: TextStyle(fontSize: 16, color: Colors.grey, fontStyle: FontStyle.italic),),
                          Text(character.hits.toString() + "/" + character.maxHits.toString() + (character.additionalHits > 0 ? " + " + character.additionalHits.toString() : ""), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ),
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
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  _statWidget(character, Characteristic.strength, "Сил"),
                  _statWidget(character, Characteristic.dexterity, "Лов"),
                  _statWidget(character, Characteristic.constitution, "Тел"),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statWidget(character, Characteristic.intelligence, "Инт"),
                  _statWidget(character, Characteristic.wisdom, "Муд"),
                  _statWidget(character, Characteristic.charisma, "Хар"),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statWidget(Character character, Characteristic identifier, String name){
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
        (chosen ? const Text("- спас.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),) :
        const Text("", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)),
        Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        InkWell(
          onTap: (){
            Map<String, int> result = {};
            result["к20"] = Dice(1, 20, 0).roll().first;
            result[name.substring(0, 3).toLowerCase()] = character.getStatBonus(identifier);
            if(chosen) result["бонус"] = character.getProficiencyBonus();
            Utils.showAlertRoll(context, (chosen ? "Спасбросок " : "Проверка ") + name.substring(0, 3).toLowerCase(), result);
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

  Widget _navigationRow(String title){
    return Row(
      children: [
        const SizedBox(width: 20,),
        Visibility(visible: title != "Умения", maintainSize: true, maintainState: true, maintainAnimation: true, child: InkWell(child: const Icon(Icons.arrow_back, size: 50,), onTap: (){_controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);},)),
        const Spacer(),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Spacer(),
        Visibility(visible: title != "Инвентарь", maintainSize: true, maintainState: true, maintainAnimation: true, child: InkWell(child: const Icon(Icons.arrow_forward, size: 50,), onTap: (){_controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);},)),
        const SizedBox(width: 20,),
      ],
    );
  }

}
