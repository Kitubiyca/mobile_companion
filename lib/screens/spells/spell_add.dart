import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/armor.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class SpellAdd extends StatefulWidget {
  const SpellAdd({Key? key}) : super(key: key);

  @override
  State<SpellAdd> createState() => _SpellAddState();
}

class _SpellAddState extends State<SpellAdd> {

  Function callBack = (){};
  TextEditingController _nameController = TextEditingController();
  TextEditingController _actionController = TextEditingController();
  int _dropdownLevelValue = 0;
  String _dropdownSchoolValue = "воплощение";
  bool _dropdownBonusValue = false;
  bool _verbal = false;
  bool _somatic = false;
  bool _material = false;
  List<Item> _items = [];
  bool _isDataLoaded = false;
  Item? _materialItem = null;
  bool _expendableItem = false;
  TextEditingController _rangeController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  bool _concentration = false;
  DamageType _damageType = DamageType.none;
  List<TextEditingController> _countControllers = List<TextEditingController>.generate(20, (index)=>TextEditingController());
  List<TextEditingController> _maxControllers = List<TextEditingController>.generate(20, (index)=>TextEditingController());
  List<TextEditingController> _addControllers = List<TextEditingController>.generate(20, (index)=>TextEditingController());
  List<TextEditingController> _levelControllers = List<TextEditingController>.generate(20, (index)=>TextEditingController());
  int _levelScaling = 1;
  TextEditingController _descriptionController = TextEditingController();
  bool _ritual = false;
  bool? _specialRequirement = null;
  Characteristic _savingMod = Characteristic.none;

  void _getItems() async {
  Box<Item> items = await Hive.openBox<Item>("Items");
  _items = items.values.toList();
  _items.removeWhere((element) => element is Armor || element is Weapon);
  _materialItem = _items.first;
  _isDataLoaded = true;
  items.close();
  }

  @override
  Widget build(BuildContext context) {
    if(_dropdownLevelValue == 0) _levelControllers[0].text = "1";
    callBack = ModalRoute.of(context)!.settings.arguments as Function();
    if(!_isDataLoaded) _getItems();
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
                          "Создание заклинания", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Название заклинания:", style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold)),
                          TextField(
                            maxLength: 40,
                            decoration: const InputDecoration(
                              counterText: "",
                              hintText: "введите название",
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
                            "Уровень заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<int>(
                              value: _dropdownLevelValue,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (int? value){
                                setState(() {
                                  _dropdownLevelValue = value ?? _dropdownLevelValue;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: 0,child: Text("заговор")),
                                DropdownMenuItem(value: 1,child: Text("уровень 1")),
                                DropdownMenuItem(value: 2,child: Text("уровень 2")),
                                DropdownMenuItem(value: 3,child: Text("уровень 3")),
                                DropdownMenuItem(value: 4,child: Text("уровень 4")),
                                DropdownMenuItem(value: 5,child: Text("уровень 5")),
                                DropdownMenuItem(value: 6,child: Text("уровень 6")),
                                DropdownMenuItem(value: 7,child: Text("уровень 7")),
                                DropdownMenuItem(value: 8,child: Text("уровень 8")),
                                DropdownMenuItem(value: 9,child: Text("уровень 9")),
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
                            "Школа заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<String>(
                              value: _dropdownSchoolValue,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (String? value){
                                setState(() {
                                  _dropdownSchoolValue = value ?? _dropdownSchoolValue;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: "воплощение",child: Text("воплощение")),
                                DropdownMenuItem(value: "вызов",child: Text("вызов")),
                                DropdownMenuItem(value: "иллюзия",child: Text("иллюзия")),
                                DropdownMenuItem(value: "некромантия",child: Text("некромантия")),
                                DropdownMenuItem(value: "ограждение",child: Text("ограждение")),
                                DropdownMenuItem(value: "очарование",child: Text("очарование")),
                                DropdownMenuItem(value: "преобразование",child: Text("преобразование")),
                                DropdownMenuItem(value: "прорицание",child: Text("прорицание")),
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
                            "Время накладывания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "введите число действий",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            maxLength: 5,
                            controller: _actionController,
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
                            "Тип действия:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<bool>(
                              value: _dropdownBonusValue,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (bool? value){
                                setState(() {
                                  _dropdownBonusValue = value ?? _dropdownBonusValue;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: false, child: Text("основное")),
                                DropdownMenuItem(value: true, child: Text("бонусное")),
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
                            "Компоненты:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _verbal = !_verbal;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(border: Border.all(width: 2, color: (_verbal ? Colors.blueAccent : Colors.black))),
                                    child: Center(child: Text("В", style: TextStyle(fontSize: 24, color: (_verbal ? Colors.blueAccent : Colors.black), fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _somatic = !_somatic;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(border: Border.all(width: 2, color: (_somatic ? Colors.blueAccent : Colors.black))),
                                    child: Center(child: Text("С", style: TextStyle(fontSize: 24, color: (_somatic ? Colors.blueAccent : Colors.black), fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      _material = !_material;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(border: Border.all(width: 2, color: (_material ? Colors.blueAccent : Colors.black))),
                                    child: Center(child: Text("М", style: TextStyle(fontSize: 24, color: (_material ? Colors.blueAccent : Colors.black), fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _material ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Материальный компонент:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Listener(
                              onPointerDown: (_) => FocusScope.of(context).unfocus(),
                              child: DropdownButton<Item>(
                                isExpanded: true,
                                value: _materialItem,
                                underline: Container(height: 0.5, color: Colors.black,),
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                onChanged: (Item? value){
                                  setState(() {
                                    _materialItem = value ?? _materialItem;
                                  });
                                },
                                items:
                                  (_items.isNotEmpty ? _items.map<DropdownMenuItem<Item>>((Item value) {return DropdownMenuItem<Item>(value: value,child: Text(value.name + (value.cost > 0 ? ",стоимостью " + value.cost.toString() : ""), overflow: (value == _materialItem ? TextOverflow.ellipsis : TextOverflow.visible),));}).toList() : [const DropdownMenuItem<Item>(value: null, child: Text("Не выбрано"))]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: Container(),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _material && (_materialItem != null ? (_materialItem!.cost > 0) : false) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Тип материального компонента:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Listener(
                              onPointerDown: (_) => FocusScope.of(context).unfocus(),
                              child: DropdownButton<bool>(
                                isExpanded: true,
                                value: _expendableItem,
                                underline: Container(height: 0.5, color: Colors.black,),
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                onChanged: (bool? value){
                                  setState(() {
                                    _expendableItem = value ?? _expendableItem;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem(value: false, child: Text("простой")),
                                  DropdownMenuItem(value: true, child: Text("расходуемый")),
                                ],
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
                            "Дальность действия заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "введите расстояние",
                            ),
                            maxLength: 40,
                            controller: _rangeController,
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
                            "Требуется концентрация:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<bool>(
                              value: _concentration,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (bool? value){
                                setState(() {
                                  _concentration = value ?? _concentration;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: false, child: Text("нет")),
                                DropdownMenuItem(value: true, child: Text("да")),
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
                            "Длительность действия заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              (_concentration ? const Text(
                                "вплоть до ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              ) : Container()),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "введите время или условие",
                                  ),
                                  maxLength: 40,
                                  controller: _durationController,
                                  style: const TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
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
                            "Тип воздействия заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<DamageType>(
                              value: _damageType,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (DamageType? value){
                                setState(() {
                                  _damageType = value ?? _damageType;
                                });
                              },
                              items:
                              DamageType.values.map<DropdownMenuItem<DamageType>>((DamageType value) {return DropdownMenuItem<DamageType>(value: value,child: Text(value.getText()));}).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _damageType != DamageType.none ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Воздействие заклинания " + (_dropdownLevelValue == 0 ? "на уровень персонажа:" : "на уровень ячейки:"), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Visibility(
                              visible: _dropdownLevelValue == 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(children: [
                                  InkWell(
                                    onTap: (){setState(() {
                                      if(_levelScaling < 20) {
                                        _levelScaling++;
                                      } else {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Максимум 20 уровней."),));}
                                    });},
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffaae0fa),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: const Center(child: Icon(Icons.add, size: 40,),),
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  InkWell(
                                    onTap: (){setState(() {
                                      if(_levelScaling > 1) {
                                        _levelScaling--;
                                      } else {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Минимум 1 уровень."),));}
                                    });},
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffaae0fa),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: const Center(child: Icon(Icons.remove, size: 40,),),
                                    ),
                                  ),
                                ],),
                              ),
                            ),
                            Column(
                              children: (_dropdownLevelValue == 0 ? List.generate(_levelScaling, (index)=>_diceInputCantrip(index)) : List.generate(9-_dropdownLevelValue+1, (index)=>_diceInputSpell(index))),
                            )
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
                            "Описание заклинания:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "напишите описание принципа работы вашего заклинания",
                            ),
                            maxLines: 5,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLength: 1000,
                            controller: _descriptionController,
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
                            "Ритуальное заклинание:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<bool>(
                              value: _ritual,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (bool? value){
                                setState(() {
                                  _ritual = value ?? _ritual;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: false, child: Text("нет")),
                                DropdownMenuItem(value: true, child: Text("да")),
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
                            "Особые требования:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Listener(
                            onPointerDown: (_) => FocusScope.of(context).unfocus(),
                            child: DropdownButton<bool>(
                              value: _specialRequirement,
                              underline: Container(height: 0.5, color: Colors.black,),
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              onChanged: (bool? value){
                                setState(() {
                                  _specialRequirement = value ?? _specialRequirement;
                                });
                              },
                              items: const [
                                DropdownMenuItem(value: null, child: Text("нет")),
                                DropdownMenuItem(value: false, child: Text("бросок атаки")),
                                DropdownMenuItem(value: true, child: Text("спасбросок")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: (_specialRequirement ?? false) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Характеристика спасброска:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Listener(
                              onPointerDown: (_) => FocusScope.of(context).unfocus(),
                              child: DropdownButton<Characteristic>(
                                value: _savingMod,
                                underline: Container(height: 0.5, color: Colors.black,),
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                onChanged: (Characteristic? value){
                                  setState(() {
                                    _savingMod = value ?? _savingMod;
                                  });
                                },
                                items: Characteristic.values.map<DropdownMenuItem<Characteristic>>((Characteristic value) {return DropdownMenuItem<Characteristic>(value: value,child: Text(value.getText()));}).toList(),
                              ),
                            ),
                          ],
                        ),
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
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо ввести название заклинания"),));
                              return;
                            }
                            if(_actionController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо ввести время накладывания заклинания"),));
                              return;
                            }
                            if(_material && _materialItem == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать материальный компонент"),));
                              return;
                            }
                            if(_rangeController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо ввести дальность действия заклинания"),));
                              return;
                            }
                            if(_durationController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо ввести продолжительность заклинания"),));
                              return;
                            }
                            if(_specialRequirement == true && _savingMod == Characteristic.none){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Необходимо выбрать характеристику спасброска"),));
                              return;
                            }
                            List<int> levels = [];
                            List<Dice> impact = [];
                            int times = 0;
                            Map<int, Map<DamageType, List<Dice>>> impactMap = {};
                            if(_damageType != DamageType.none) {
                              if (_dropdownLevelValue == 0) {
                                times = _levelScaling;
                              } else {
                                times = 10 - _dropdownLevelValue;
                              }
                              for (int i = 0; i < times; i++) {
                                int? value = int.tryParse(
                                    _levelControllers[i].text);
                                if (value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          "Введены не все уровни"),));
                                  return;
                                } else {
                                  levels.add(value);
                                }
                              }
                              for (int i = 1; i < levels.length; i++) {
                                if (levels[i - 1] >= levels[i]) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          "Уровни введены некорректно"),));
                                  return;
                                }
                              }
                              for (int i = 0; i < levels.length; i++) {
                                int count = int.tryParse(
                                    _countControllers[i].text) ?? 0;
                                int max = int.tryParse(
                                    _maxControllers[i].text) ?? 0;
                                int add = int.tryParse(
                                    _addControllers[i].text) ?? 0;
                                if (count > 0) {
                                  impact.add(Dice(count, max, add));
                                } else {
                                  impact.add(Dice(0, 0, add));
                                }
                              }
                              for (int i = 0; i < levels.length; i++) {
                                impactMap[levels[i]] =
                                {_damageType: [impact[i]]};
                              }
                            }
                            Box<Spell> spells = Hive.box<Spell>("Spells");
                            spells.add(Spell.smart(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              range: _rangeController.text,
                              verbal: _verbal,
                              somatic: _somatic,
                              materials: (_material && _materialItem != null ? {_materialItem!: _expendableItem} : null),
                              ritual: _ritual,
                              duration: (_concentration ? "вплоть до " : "") + _durationController.text,
                              concentration: _concentration,
                              bonus: _dropdownBonusValue,
                              castingTime: (int.tryParse(_actionController.text) ?? 0),
                              level: _dropdownLevelValue,
                              school: _dropdownSchoolValue,
                              savingModifier: (_specialRequirement == true ? _savingMod : null),
                              armorPenetration: _specialRequirement == false,
                              impact: (impactMap.isNotEmpty ? impactMap : null),
                              protected: false,
                            ));
                            callBack();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заклинание успешно сохранено"),));
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

  Widget _diceInputSpell(int num){
    _levelControllers[num].text = (num+_dropdownLevelValue).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Уровень " + (num+_dropdownLevelValue).toString() + ":", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_countControllers[num].text = "";},
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _countControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text("к", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_maxControllers[num].text = "";},
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _maxControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_addControllers[num].text = "";},
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _addControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _diceInputCantrip(int num){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Уровень " + (num == 0 ? "1:" : ""), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        (num != 0 ? SizedBox(
          width: 10,
          child: TextField(
            onTap: (){_levelControllers[num].text = "";},
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: "-",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            controller: _levelControllers[num],
            style: const TextStyle(fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ) : Container()),
        (num != 0 ? const Text(":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) : Container()),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_countControllers[num].text = "";},
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _countControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text("к", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_maxControllers[num].text = "";},
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _maxControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 35,
          child: TextField(
            onTap: (){_addControllers[num].text = "";},
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            controller: _addControllers[num],
            style: const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

}
