import 'package:dnd_companion/data/character/class/class.dart';

import '../character/race/race.dart';

class Proficiency {
  String _name;
  String _description;
  Set<Class> _classes;
  Set<Race> _races;
  bool _protected;

  Proficiency(this._name, this._description, this._classes, this._races,
      this._protected);

  Proficiency.smart({
    String name = "Example name",
    String description = "Example description",
    Set<Class>? classes,
    Set<Race>? races,
    bool protected = false,
  })  : _name = name,
        _description = description,
        _classes = classes ?? {},
        _races = races ?? {},
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

  Set<Race> get races => _races;

  set races(Set<Race> value) {
    _races = value;
  }

  Set<Class> get classes => _classes;

  set classes(Set<Class> value) {
    _classes = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proficiency &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _classes == other._classes &&
          _races == other._races &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _classes.hashCode ^
      _races.hashCode ^
      _protected.hashCode;
}
