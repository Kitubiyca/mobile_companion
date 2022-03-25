import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';

class SubRace{

  late String _name;
  late String _description;
  late String _vision;
  late Map<String, int> _abilityScoreImprovement;
  late Set<SkillCheck> _skillChecks;
  late Set<Spell> _spells;
  late Set<Proficiency> _proficiencies;
  late Resist _resist;
  late int _additionalHits;
  late Map<int, Set<Spell>> _additionalSpells;
  late Set<String> _languages;
  late bool _protected;

  SubRace(
      this._name,
      this._description,
      this._vision,
      this._abilityScoreImprovement,
      this._skillChecks,
      this._spells,
      this._proficiencies,
      this._resist,
      this._additionalHits,
      this._additionalSpells,
      this._languages,
      this._protected);

  SubRace.copyFrom(SubRace object){
    _name = object.name;
    _description = object.description;
    _vision = object.vision;
    _abilityScoreImprovement.addAll(object.abilityScoreImprovement);
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
    _protected = false;
  }

  bool get protected => _protected;

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
      other is SubRace &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _vision == other._vision &&
          _abilityScoreImprovement == other._abilityScoreImprovement &&
          _skillChecks == other._skillChecks &&
          _spells == other._spells &&
          _proficiencies == other._proficiencies &&
          _resist == other._resist &&
          _additionalHits == other._additionalHits &&
          _additionalSpells == other._additionalSpells &&
          _languages == other._languages &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _vision.hashCode ^
      _abilityScoreImprovement.hashCode ^
      _skillChecks.hashCode ^
      _spells.hashCode ^
      _proficiencies.hashCode ^
      _resist.hashCode ^
      _additionalHits.hashCode ^
      _additionalSpells.hashCode ^
      _languages.hashCode ^
      _protected.hashCode;
}