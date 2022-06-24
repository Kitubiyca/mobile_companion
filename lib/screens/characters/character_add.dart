import 'dart:ui';

import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/character/class/class.dart';
import 'package:dnd_companion/data/character/race.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class CharacterAdd extends StatefulWidget {
  const CharacterAdd({Key? key}) : super(key: key);

  @override
  State<CharacterAdd> createState() => _CharacterAddState();
}

class _CharacterAddState extends State<CharacterAdd> {

  Function() callBack = (){};
  bool _isDataLoaded = false;
  List<Race> _races = [];
  List<Class> _classes = [];
  List<Background> _backgrounds = [];
  TextEditingController _nameController = TextEditingController();
  Race? _race = null;
  Race? _subRace = null;
  Class? _class = null;
  Background? _background = null;
  String? _alignment = null;
  bool? _abilityScoreMethod = null;
  Map<Characteristic, int?> _abilities = {};
  Set<int> _standartAblities = {15, 14, 13, 12, 10, 8};
  List<int> _randomAbilities = [];
  int _abilityPoints = 27;

  void _loadData() async {
    Box<Race> races = await Hive.openBox<Race>("races");
    Box<Class> classes = await Hive.openBox<Class>("classes");
    Box<Background> backgrounds = await Hive.openBox<Background>("backgrounds");
    _races = races.values.toList();
    _classes = classes.values.toList();
    _backgrounds = backgrounds.values.toList();
    //_race = _races.first;
    //if(_race!.subRaces.isNotEmpty) _subRace = _race!.subRaces.first;
    //_class = _classes.first;
    //_background = _backgrounds.first;
    races.close();
    classes.close();
    backgrounds.close();
    _setRandomAbilities();
    _isDataLoaded = true;
    setState(() {});
  }

  void _setRandomAbilities(){
    _randomAbilities.clear();
    for(int i = 0; i < 6; i++) {
      _randomAbilities.add(((<int>[Dice(1, 6, 0).roll().first, Dice(1, 6, 0).roll().first, Dice(1, 6, 0).roll().first, Dice(1, 6, 0).roll().first]..sort())..removeAt(0)).fold(0, (int previousValue, int element) => previousValue + element));
      //_randomAbilities.add(Dice(3, 6, 0).roll().first);
    }
  }

  List<DropdownMenuItem<int>> _getButtons(Characteristic characteristic){
    List<int> ints = [];
    if(_abilityScoreMethod == false) ints = _standartAblities.toList();
    if(_abilityScoreMethod == null) ints = _randomAbilities.toList();
    for(int i = 0; i < _abilities.values.length; i++) {
      if(_abilities.keys.elementAt(i) != characteristic){
        ints.remove(_abilities.values.elementAt(i));
      }
    }
    //ints.removeWhere((element) => _abilities.values.contains(element) && element != _abilities[characteristic]);
    return ints.toSet().map<DropdownMenuItem<int>>((int value) {return DropdownMenuItem<int>(value: value,child: Text(value.toString()));}).toList()..add(const DropdownMenuItem<int>(value: null,child: Text("нет")));
  }

  Widget _getMenuElement(String name, Characteristic characteristic){
    return Row(
      children: [
        Text(
          name + ":  ", style: const TextStyle(fontSize: 16),
        ),
        Listener(
          onPointerDown: (_) => FocusScope.of(context).unfocus(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _abilities[characteristic],
              underline: Container(height: 0.5, color: Colors.black,),
              style: const TextStyle(fontSize: 16, color: Colors.black),
              onChanged: (int? value){
                setState(() {
                  _abilities[characteristic] = value;
                });
              },
              items: _getButtons(characteristic),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getPointElement(String name, Characteristic characteristic){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Text(
            name + ":  ", style: const TextStyle(fontSize: 16),
          ),
          Container(
            //height: MediaQuery.of(context).size.height * 0.04,
            //width: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: const Color(0xffaae0fa),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(width: 1.5, color: Colors.black45),
            ),
            child: Row(
              children: [
                InkWell(
                  child: const Icon(Icons.remove),
                  onTap: (){setState(() {
                    if(_abilities[characteristic]! > 8){
                      _abilityPoints += _abilities[characteristic]! - 8;
                      _abilities[characteristic] = _abilities[characteristic]! - 1;
                    }
                });},),
                const SizedBox(width: 20,),
                Center(child: Text(_abilities[characteristic].toString(), style: const TextStyle(fontSize: 16, overflow: TextOverflow.clip),),),
                const SizedBox(width: 20,),
                InkWell(
                  child: const Icon(Icons.add),
                  onTap: (){setState(() {
                    if(_abilities[characteristic]! < 15){
                      _abilityPoints -= _abilities[characteristic]! - 7;
                      _abilities[characteristic] = _abilities[characteristic]! + 1;
                    }
                  });},),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    callBack = ModalRoute.of(context)!.settings.arguments as Function();
    if(!_isDataLoaded) _loadData();
    return Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    repeat: ImageRepeat.repeatY,
                    alignment: AlignmentDirectional(0, 0),
                    fit: BoxFit.fitHeight,
                    image: AssetImage("resources/paper.jpg")),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "Создание персонажа", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Имя персонажа:", style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold)),
                          TextField(
                            maxLength: 40,
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: "введите имя",
                            ),
                            controller: _nameController,
                            style: const TextStyle(fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Раса персонажа:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<Race>(
                              value: _race,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (Race? value){
                                setState(() {
                                  _race = value;
                                  _subRace = null;
                                });
                              },
                              items: (_races.isNotEmpty ? (_races.map<DropdownMenuItem<Race>>((Race value) {return DropdownMenuItem<Race>(value: value,child: Text(value.name));}).toList()..add(const DropdownMenuItem<Race>(value: null,child: Text("Не выбрано")))) : const [DropdownMenuItem<Race>(value: null,child: Text("Не выбрано"))]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: (_race == null ? false : _race!.subRaces.isNotEmpty) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Разновидность расы:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Listener(
                              onPointerDown: (_) => FocusScope.of(context).unfocus(),
                              child: DropdownButton<Race>(
                                value: _subRace,
                                underline: Container(height: 0.5, color: Colors.black,),
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                onChanged: (Race? value){
                                  setState(() {
                                    _subRace = value;
                                  });
                                },
                                items: ((_race != null && _race!.subRaces.isNotEmpty) ? (_race!.subRaces.map<DropdownMenuItem<Race>>((Race value) {return DropdownMenuItem<Race>(value: value,child: Text(value.name));}).toList()..add(const DropdownMenuItem<Race>(value: null,child: Text("Не выбрано")))) : const [DropdownMenuItem<Race>(value: null,child: Text("Не выбрано"))]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Класс персонажа:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<Class>(
                              value: _class,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (Class? value){
                                setState(() {
                                  _class = value;
                                });
                              },
                              items: (_classes.isNotEmpty ? (_classes.map<DropdownMenuItem<Class>>((Class value) {return DropdownMenuItem<Class>(value: value,child: Text(value.name));}).toList()..add(const DropdownMenuItem<Class>(value: null,child: Text("Не выбрано")))) : [const DropdownMenuItem<Class>(value: null,child: Text("Не выбрано"))]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Мировоззрение персонажа:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<String>(
                              value: _alignment,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (String? value){
                                setState(() {
                                  _alignment = value;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: null, child: Text("Не выбрано")),
                                DropdownMenuItem(value: "законопослушный добрый", child: Text("законопослушный добрый")),
                                DropdownMenuItem(value: "законопослушный нейтральный", child: Text("законопослушный нейтральный")),
                                DropdownMenuItem(value: "законопослушный злой", child: Text("законопослушный злой")),
                                DropdownMenuItem(value: "нейтральный добрый", child: Text("нейтральный добрый")),
                                DropdownMenuItem(value: "истинно нейтральный", child: Text("истинно нейтральный")),
                                DropdownMenuItem(value: "нейтральный злой", child: Text("нейтральный злой")),
                                DropdownMenuItem(value: "хаотичный добрый", child: Text("хаотичный добрый")),
                                DropdownMenuItem(value: "хаотичный нейтральный", child: Text("хаотичный нейтральный")),
                                DropdownMenuItem(value: "хаотичный злой", child: Text("хаотичный злой")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Происхождение персонажа:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<Background>(
                              value: _background,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (Background? value){
                                setState(() {
                                  _background = value;
                                });
                              },
                              items: (_backgrounds.isNotEmpty ? (_backgrounds.map<DropdownMenuItem<Background>>((Background value) {return DropdownMenuItem<Background>(value: value,child: Text(value.name));}).toList()..add(const DropdownMenuItem<Background>(value: null,child: Text("Не выбрано")))) : [const DropdownMenuItem<Background>(value: null,child: Text("Не выбрано"))]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Метод выбора характеристик:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<bool>(
                              value: _abilityScoreMethod,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (bool? value){
                                setState(() {
                                  _abilities.clear();
                                  _abilityScoreMethod = value;
                                  _abilityPoints = 27;
                                  if(value == true){
                                    _abilities[Characteristic.strength] = 8;
                                    _abilities[Characteristic.dexterity] = 8;
                                    _abilities[Characteristic.constitution] = 8;
                                    _abilities[Characteristic.intelligence] = 8;
                                    _abilities[Characteristic.wisdom] = 8;
                                    _abilities[Characteristic.charisma] = 8;
                                  }
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: null, child: Text("случайно")),
                                DropdownMenuItem(value: false, child: Text("стандартный набор")),
                                DropdownMenuItem(value: true, child: Text("настройка значений")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _abilityScoreMethod == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Текущие значения: " + (_randomAbilities.isNotEmpty ? _randomAbilities[0].toString() + ", " + _randomAbilities[1].toString() + ", " + _randomAbilities[2].toString() + ", " + _randomAbilities[3].toString() + ", " + _randomAbilities[4].toString() + ", " + _randomAbilities[5].toString() + "." : "нет данных."), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                            child: InkWell(
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xffaae0fa),
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(width: 1.5, color: Colors.black45),
                                ),
                                child: const Center(child: Text("Перебросить", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, overflow: TextOverflow.clip),),),
                              ),
                              onTap: (){setState(() {
                                _abilities.clear();
                                _setRandomAbilities();
                              });},
                            ),
                          ),
                          (_abilityScoreMethod == null ? _getMenuElement("Cил", Characteristic.strength) : Container()),
                          (_abilityScoreMethod == null ? _getMenuElement("Лов", Characteristic.dexterity) : Container()),
                          (_abilityScoreMethod == null ? _getMenuElement("Тел", Characteristic.constitution) : Container()),
                          (_abilityScoreMethod == null ? _getMenuElement("Инт", Characteristic.intelligence) : Container()),
                          (_abilityScoreMethod == null ? _getMenuElement("Муд", Characteristic.wisdom) : Container()),
                          (_abilityScoreMethod == null ? _getMenuElement("Хар", Characteristic.charisma) : Container()),
                        ],
                      ),
                      secondChild: Container(),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _abilityScoreMethod == false ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (_abilityScoreMethod == false ? _getMenuElement("Cил", Characteristic.strength) : Container()),
                          (_abilityScoreMethod == false ? _getMenuElement("Лов", Characteristic.dexterity) : Container()),
                          (_abilityScoreMethod == false ? _getMenuElement("Тел", Characteristic.constitution) : Container()),
                          (_abilityScoreMethod == false ? _getMenuElement("Инт", Characteristic.intelligence) : Container()),
                          (_abilityScoreMethod == false ? _getMenuElement("Муд", Characteristic.wisdom) : Container()),
                          (_abilityScoreMethod == false ? _getMenuElement("Хар", Characteristic.charisma) : Container()),
                        ],
                      ), secondChild: Container(),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _abilityScoreMethod == true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Осталось пунктов: " + _abilityPoints.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _getPointElement("Cил", Characteristic.strength),
                          _getPointElement("Лов", Characteristic.dexterity),
                          _getPointElement("Тел", Characteristic.constitution),
                          _getPointElement("Инт", Characteristic.intelligence),
                          _getPointElement("Муд", Characteristic.wisdom),
                          _getPointElement("Хар", Characteristic.charisma),
                        ],
                      ),
                      secondChild: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                      child: Center(
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              color: const Color(0xffaae0fa),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(width: 1.5, color: Colors.black45),
                            ),
                            child: const Center(child: Text("Сохранить", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, overflow: TextOverflow.clip),),),
                          ),
                          onTap: (){
                            if(_nameController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо ввести имя персонажа"),));
                              return;
                            }
                            if(_race == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать расу персонажа"),));
                              return;
                            }
                            if(_race != null && _race!.subRaces.isNotEmpty && _subRace == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать разновидность расы"),));
                              return;
                            }
                            if(_class == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать класс персонажа"),));
                              return;
                            }
                            if(_background == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать происхождение персонажа"),));
                              return;
                            }
                            if(_abilityPoints < 0){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Количество оставшихся пунктов не может быть меньше нуля"),));
                              return;
                            }
                            if(_abilities.length < 6){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать значения характеристик персонажа"),));
                              return;
                            }
                            Box<Character> box = Hive.box<Character>("Characters");
                            box.add(Character.creator(_nameController.text, _class!, _background!, (_race!.subRaces.isNotEmpty ? _subRace! : _race!), Map.castFrom(_abilities), _alignment ?? ""));
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Персонаж был успешно сохранён"),));
                            callBack();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }



}
