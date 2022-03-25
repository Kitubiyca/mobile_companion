import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'sub_race.dart';


class Race{

  late String _name;
  late String _description;
  late String _vision;
  late Map<String, int> _abilityScoreImprovement;
  late int _speed;
  late Set<SkillCheck> _skillChecks;
  late Set<Spell> _spells;
  late Set<Proficiency> _proficiencies;
  late Resist _resist;
  late int _additionalHits;
  late Map<int, Set<Spell>> _additionalSpells;
  late Set<String> _languages;
  late bool _usable;
  late bool _protected;
  List<SubRace> _subRaces = [];

  static List<Race> races = [];

  Race(
      this._name,
      this._description,
      this._vision,
      this._abilityScoreImprovement,
      this._speed,
      this._skillChecks,
      this._spells,
      this._proficiencies,
      this._resist,
      this._additionalHits,
      this._additionalSpells,
      this._languages,
      this._usable,
      this._protected,
      this._subRaces);

  Race.withAdd(
      this._name,
      this._description,
      this._vision,
      this._abilityScoreImprovement,
      this._speed,
      this._skillChecks,
      this._spells,
      this._proficiencies,
      this._resist,
      this._additionalHits,
      this._additionalSpells,
      this._languages,
      this._usable,
      this._protected,
      this._subRaces){races.add(this);}

  Race.copyFrom(Race object){
    _name = object.name;
    _description = object.description;
    _vision = object.vision;
    _abilityScoreImprovement.addAll(object.abilityScoreImprovement);
    _speed = object.speed;
    for(int i = 0; i < object.skillChecks.length; i++){
      _skillChecks.add(SkillCheck.copyFrom(object.skillChecks.elementAt(i)));
    }
    for(int i = 0; i < object.spells.length; i++){
      _spells.add(Spell.copyFrom(object.spells.elementAt(i)));
    }
    for(int i = 0; i < object.proficiencies.length; i++){
      _proficiencies.add(Proficiency.copyFrom(object.proficiencies.elementAt(i)));
    }
    _resist = Resist.copyFrom(object.resist);
    _additionalHits = object.additionalHits;
    for(int i = 0; i < object.additionalSpells.length; i++){
      _additionalSpells[object.additionalSpells.keys.elementAt(i)] = <Spell>{};
      for(int k = 0; k < object.additionalSpells[object.additionalSpells.keys.elementAt(i)]!.length; k++){
        _additionalSpells[object.additionalSpells.keys.elementAt(i)]!.add(Spell.copyFrom(object.additionalSpells.values.elementAt(i).elementAt(k)));
      }
    }
    _languages.addAll(object.languages);
    _usable = object.usable;
    _protected = false;
    for(int i = 0; i < object.subRaces.length; i++){
      _subRaces.add(SubRace.copyFrom(object.subRaces.elementAt(i)));
    }
  }

  void copySubRace(int index){
    _subRaces.add(SubRace.copyFrom(_subRaces.elementAt(index)));
  }

  List<SubRace> get subRaces => _subRaces;

  set subRaces(List<SubRace> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _subRaces = value;
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

  Map<int, Set<Spell>> get additionalSpells => _additionalSpells;

  set additionalSpells(Map<int, Set<Spell>> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _additionalSpells = value;
  }

  int get additionalHits => _additionalHits;

  set additionalHits(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _additionalHits = value;
  }

  Resist get resist => _resist;

  set resist(Resist value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _resist = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _proficiencies = value;
  }

  Set<Spell> get spells => _spells;

  set spells(Set<Spell> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _spells = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skillChecks = value;
  }

  int get speed => _speed;

  set speed(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _speed = value;
  }

  Map<String, int> get abilityScoreImprovement => _abilityScoreImprovement;

  set abilityScoreImprovement(Map<String, int> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _abilityScoreImprovement = value;
  }

  String get vision => _vision;

  set vision(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _vision = value;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Race &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _vision == other._vision &&
          _abilityScoreImprovement == other._abilityScoreImprovement &&
          _speed == other._speed &&
          _skillChecks == other._skillChecks &&
          _spells == other._spells &&
          _proficiencies == other._proficiencies &&
          _resist == other._resist &&
          _additionalHits == other._additionalHits &&
          _additionalSpells == other._additionalSpells &&
          _languages == other._languages &&
          _usable == other._usable &&
          _protected == other._protected &&
          _subRaces == other._subRaces;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _vision.hashCode ^
      _abilityScoreImprovement.hashCode ^
      _speed.hashCode ^
      _skillChecks.hashCode ^
      _spells.hashCode ^
      _proficiencies.hashCode ^
      _resist.hashCode ^
      _additionalHits.hashCode ^
      _additionalSpells.hashCode ^
      _languages.hashCode ^
      _usable.hashCode ^
      _protected.hashCode ^
      _subRaces.hashCode;
}