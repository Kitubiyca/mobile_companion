import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import '../../characteristics/resist.dart';
import '../../skill/skill.dart';
import 'sub_race.dart';


class Race{

  late String _name;
  late String _description;
  late String _vision;
  late List<String> _abilityScoreImprovement;
  late int _speed;
  late Set<SkillCheck> _skillChecks;
  late Set<Spell> _spells;
  late Set<Skill> _skills;
  late Set<Proficiency> _proficiencies;
  late Resist resist;
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
      this._skills,
      this._proficiencies,
      this.resist,
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
      this._skills,
      this._proficiencies,
      this.resist,
      this._languages,
      this._usable,
      this._protected,
      this._subRaces)
      {races.add(this);}

  Race.copyFrom(Race object){
    _name = object._name;
    _description = object._description;
    _vision = object._vision;
    _abilityScoreImprovement.addAll(object._abilityScoreImprovement);
    _speed = object._speed;
    _skillChecks.addAll(object._skillChecks);
    _spells.addAll(object._spells);
    _skills.addAll(object._skills);
    _proficiencies.addAll(object._proficiencies);
    resist = object.resist;
    _languages.addAll(object._languages);
    _usable = object._usable;
    _protected = false;
    for(int i = 0; i < object._subRaces.length; i++){
      _subRaces.add(SubRace.copyFrom(object._subRaces[i], this));
    }
  }

  void addSubRace(String subRaceName){
    _subRaces.add(SubRace(subRaceName, this, abilityScoreImprovement, skills, languages, protected));
  }

  void add

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

  Set<SkillCheck> get skills => _skillChecks;

  set skills(Set<SkillCheck> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skillChecks = value;
  }

  int get speed => _speed;

  set speed(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _speed = value;
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

  List<SubRace> get subRaces => _subRaces;

  Set<Proficiency> get proficiencies => _proficiencies;

  Set<Spell> get spells => _spells;

  Set<SkillCheck> get skillChecks => _skillChecks;

  String get vision => _vision;

  String get description => _description;

  set protected(bool value) {
    _protected = value;
  }

  set vision(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _vision = value;
  }

  set description(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }
}