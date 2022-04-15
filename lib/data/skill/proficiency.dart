import 'package:dnd_companion/data/character/class/class.dart';

import '../character/race/race.dart';

class Proficiency {

  String _name;
  String _description;
  bool _protected;

  //print classes and races with this proficiency

  Proficiency(this._name, this._description, this._protected);

  Proficiency.smart({
    String name = "Example name",
    String description = "Example description",
    bool protected = false,
  })  : _name = name,
        _description = description,
        _protected = protected;

  //Proficiency.copyFrom(Proficiency object){
  //  _name = object.name;
  //  _description = object.description;
  //  _protected = false;
  //}

  bool get protected => _protected;

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proficiency &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _protected.hashCode;
}
