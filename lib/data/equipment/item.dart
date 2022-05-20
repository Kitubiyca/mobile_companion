import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/item.g.dart';

@HiveType(typeId: 43)
class Item {

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  int _weight;
  @HiveField(3)
  int _cost;
  @HiveField(4)
  Set<Proficiency> _proficiencies;
  @HiveField(5)
  Set<String> _notes; // TODO реализовать владение
  @HiveField(6)
  bool _protected;

  Item(this._name, this._description, this._weight, this._cost, this._proficiencies, this._notes,
      this._protected);

  Item.smart(
      {required String name,
      String description = "",
      int weight = 0,
      int cost = 0,
      Set<Proficiency>? proficiencies,
      Set<String>? notes,
      bool protected = false})
      : _name = name,
        _description = description,
        _weight = weight,
        _cost = cost,
        _proficiencies = proficiencies ?? {},
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
    items.put("tasha", Item.smart(name: "маленькие пирожные и перо, которым нужно махать в воздухе"));
    items.put("mage armor", Item.smart(name: "кусочек выделанной кожи"));
    items.put("invisibility", Item.smart(name: "ресница в смоле"));
    items.put("rope trick", Item.smart(name: "экстракт зерна и петля из пергамента"));
    items.put("fireball", Item.smart(name: "крошечный шарик из гуано летучей мыши и серы"));
    return;
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

  int get cost => _cost;

  set cost(int value) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _weight == other._weight &&
          _cost == other._cost &&
          _proficiencies == other._proficiencies &&
          _notes == other._notes &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _weight.hashCode ^
      _cost.hashCode ^
      _proficiencies.hashCode ^
      _notes.hashCode ^
      _protected.hashCode;
}
