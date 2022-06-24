import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 42)
class Item {

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  String _image;
  @HiveField(3)
  int _weight;
  @HiveField(4)
  double _cost;
  @HiveField(5)
  RareType _rare;
  @HiveField(6)
  Set<Proficiency> _proficiencies;
  @HiveField(7)
  bool _equipment;
  @HiveField(8)
  Map<Characteristic, int> _additionalStats;
  @HiveField(9)
  Map<Characteristic, int> _forcedStats;
  @HiveField(10)
  Set<String> _notes;
  @HiveField(11)
  bool _protected;

  Item(this._name, this._description, this._image, this._weight, this._cost, this._rare, this._proficiencies, this._equipment, this._additionalStats, this._forcedStats, this._notes,
      this._protected);

  Item.smart(
      {required String name,
      String description = "",
      String image = "question-mark.png",
      int weight = 0,
      double cost = 0,
      RareType? rare,
      Set<Proficiency>? proficiencies,
      bool equipment = false,
      Map<Characteristic, int>? additionalStats,
      Map<Characteristic, int>? forcedStats,
      Set<String>? notes,
      bool protected = false})
      : _name = name,
        _description = description,
        _image = image,
        _weight = weight,
        _cost = double.parse(cost.toStringAsFixed(2)),
        _rare = rare ?? RareType.common,
        _proficiencies = proficiencies ?? {},
        _equipment = equipment,
        _additionalStats = additionalStats ?? {},
        _forcedStats = forcedStats ?? {},
        _notes = notes ?? {},
        _protected = protected;

  //Item.copyFrom(Item object){
  //  _name = object.name;
  //  _description = object.description;
  //  _weight = object.weight;
  //  _cost = object.cost;
  //  _notes.addAll(object.notes);
  //  _protected = false;
  //}

  static Future<void> unpack(Box<Item> items, Box<Proficiency> proficiencies) async {
    await items.put("tasha", Item.smart(name: "Маленькие пирожные и перо, которым нужно махать в воздухе"));
    await items.put("mage armor", Item.smart(name: "Кусочек выделанной кожи"));
    await items.put("invisibility", Item.smart(name: "Ресница в смоле"));
    await items.put("rope trick", Item.smart(name: "Экстракт зерна и петля из пергамента"));
    await items.put("fireball", Item.smart(name: "Крошечный шарик из гуано летучей мыши и серы"));
    await items.put("city map", Item.smart(name: "Карта города"));
    await items.put("pet mouse", Item.smart(name: "Ручная мышь"));
    await items.put("token", Item.smart(name: "Безделушка"));
    await items.put("silk rope", Item.smart(name: "Шёлковая верёвка"));
    await items.put("lucky charm", Item.smart(name: "Талисман"));
    await items.put("scroll case", Item.smart(name: "Контейнер для свитков"));
    await items.put("winter blanket", Item.smart(name: "Тёплое одеяло"));
    await items.put("herbalism kit", Item.smart(name: "Набор травника"));
    await items.put("holy symbol", Item.smart(name: "Священный символ"));
    await items.put("prayer book", Item.smart(name: "Молитвенник"));
    await items.put("incense stick", Item.smart(name: "Палочка благовоний"));
    await items.put("insignia of rank", Item.smart(name: "Знак отличия"));
    await items.put("enemy trophy", Item.smart(name: "Трофей врага"));
    await items.put("bone dice", Item.smart(name: "Набор игровых костей"));
    await items.put("bolt", Item.smart(name: "Болт"));
    await items.put("component pouch", Item.smart(name: "мешочек с компонентами", image: "component-pouch.png"));
    await items.put("spellbook", Item.smart(name: "Книга заклинаний", image: "spellbook.png"));
  }

  AssetImage getImage(){
    return AssetImage("resources/icons/items/" + _image);
  }

  String getType(){
    return "предмет";
  }

  bool get protected => _protected;

  Set<String> get notes => _notes;

  addNote(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.add(value);
  }

  addNotes(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.addAll(value);
  }

  removeNote(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.remove(value);
  }

  removeNotes(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.remove(value);
  }

  double get cost => _cost;

  set cost(double value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _cost = value;
  }

  int get weight => _weight;

  set weight(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _weight = value;
  }

  String get description => _description;

  set description(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  Map<Characteristic, int> get forcedStats => _forcedStats;

  set forcedStats(Map<Characteristic, int> value) {
    _forcedStats = value;
  }

  Map<Characteristic, int> get additionalStats => _additionalStats;

  set additionalStats(Map<Characteristic, int> value) {
    _additionalStats = value;
  }

  bool get equipment => _equipment;

  set equipment(bool value) {
    _equipment = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  RareType get rare => _rare;

  set rare(RareType value) {
    _rare = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _image == other._image &&
          _weight == other._weight &&
          _cost == other._cost &&
          _rare == other._rare &&
          _proficiencies == other._proficiencies &&
          _equipment == other._equipment &&
          _additionalStats == other._additionalStats &&
          _forcedStats == other._forcedStats &&
          _notes == other._notes &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _image.hashCode ^
      _weight.hashCode ^
      _cost.hashCode ^
      _rare.hashCode ^
      _proficiencies.hashCode ^
      _equipment.hashCode ^
      _additionalStats.hashCode ^
      _forcedStats.hashCode ^
      _notes.hashCode ^
      _protected.hashCode;
}
