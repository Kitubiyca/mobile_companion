import '../dice/dice.dart';
import 'level.dart';

class Class{

  String _name;
  String _description;
  Dice _hits;
  Set<String> _classPointsNames;
  int _subClassChooseLevel;
  List<Level> _levels;
  Set<Class> subClasses = {};
  bool _protected;

  static List<Class> classes = [];
  static Set<String> recentlyUsedClassPointsNames = {};

  Class(this._name, this._description, this._classPointsNames, this._levels, this._protected) {
    classes.add(this);
  }

  bool get protected => _protected;

  List<Level> get levels => _levels;

  set levels(List<Level> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    if(value.length != 20) throw Exception("Incorrect input data length: expected 20 levels.");
    _levels = value;
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

  Set<String> get classPointsNames => _classPointsNames;

  addClassPointsName(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _classPointsNames.add(value);
    recentlyUsedClassPointsNames.add(value);
  }

  removeClassPointsName(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _classPointsNames.remove(value);
    recentlyUsedClassPointsNames.add(value);
  }

}