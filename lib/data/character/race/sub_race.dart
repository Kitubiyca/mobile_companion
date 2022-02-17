import 'race.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';

class SubRace{

  String _name;
  Race _race;
  List<String> _abilityScoreImprovement;
  Set<SkillCheck> _skills;
  Set<String> _languages;
  bool _protected;

  SubRace(this._name, this._race, this._abilityScoreImprovement, this._skills, this._languages, this._protected);

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

  Set<SkillCheck> get skills => _skills;

  addSkills(SkillCheck value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skills.add(value);
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