import 'package:dnd_companion/data/skill/skill_check.dart';
import 'sub_race.dart';


class Race{

  String _name;
  List<String> _abilityScoreImprovement;
  String _size;
  int _speed;
  Set<SkillCheck> _skills;
  Set<String> _languages;
  bool _usable;
  bool _protected;

  static List<Race> races = [];
  List<SubRace> subRaces = [];

  Race(this._name, this._abilityScoreImprovement, this._size, this._speed, this._skills, this._languages, this._usable, this._protected){races.add(this);}

  void addSubRace(){
    subRaces.add(SubRace(name, this, abilityScoreImprovement, skills, languages, protected));
  }

  bool get protected => _protected;

  bool get usable => _usable;

  set usable(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _usable = value;
  }

  Set<String> get languages => _languages;

  set languages(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _languages = value;
  }

  Set<SkillCheck> get skills => _skills;

  set skills(Set<SkillCheck> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skills = value;
  }

  int get speed => _speed;

  set speed(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _speed = value;
  }

  String get size => _size;

  set size(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _size = value;
  }

  List<String> get abilityScoreImprovement => _abilityScoreImprovement;

  set abilityScoreImprovement(List<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _abilityScoreImprovement = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }
}