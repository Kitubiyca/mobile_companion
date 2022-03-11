import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/spell/spell.dart';

import '../../characteristics/resist.dart';
import '../../skill/skill.dart';
import 'race.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';

class SubRace{

  late String _name;
  late String _description;
  late String vision;
  late List<String> _abilityScoreImprovement;
  late Set<SkillCheck> _skillChecks;
  late Set<Spell> _spells;
  late Set<Skill> _skills;
  late Set<Proficiency> _proficiencies;
  late Resist resist;
  late Set<String> _languages;
  late bool _protected;

  SubRace(this._name, this._race, this._abilityScoreImprovement, this._skillChecks, this._languages, this._protected);

  SubRace.copyFrom(SubRace object, this._race){
    _name = object._name;
    _abilityScoreImprovement.addAll(object._abilityScoreImprovement);
    _skillChecks.addAll(object._skillChecks);
    _languages.addAll(object._languages);
    _protected = false;
  }

  bool get protected => _protected;

  Set<String> get languages => _languages;

  addLanguages(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _languages.add(value);
  }

  removeLanguages(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _languages.remove(value);
  }

  Set<SkillCheck> get skills => _skillChecks;

  addSkills(SkillCheck value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skillChecks.add(value);
  }

  List<String> get abilityScoreImprovement => _abilityScoreImprovement;

  set abilityScoreImprovement(List<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _abilityScoreImprovement = value;
  }

  Race get race => _race;

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }
}