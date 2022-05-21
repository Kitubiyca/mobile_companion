import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'sub_race.dart';

class Race {
  String _name;
  String _description;
  int _speed;
  int _age;
  int _size;
  String _vision;
  Map<String, int> _abilityScoreImprovement;
  Set<SkillCheck> _skillChecks;
  Set<Proficiency> _optionalProficiencies;
  int _startingProficienciesCount;
  Set<Proficiency> _startingProficiencies;
  Set<Proficiency> _traits;
  Resist _resist;
  int _additionalHits;
  Map<String, Map<int, int>> _classSpells; // Set<class spells>, spell num
  Map<int, Set<Spell>> _giftedSpells; // level, set<Spells>
  Set<String> _languages;
  List<SubRace> _subRaces = [];
  bool _protected;


  Race(
      this._name,
      this._description,
      this._speed,
      this._age,
      this._size,
      this._vision,
      this._abilityScoreImprovement,
      this._skillChecks,
      this._optionalProficiencies,
      this._startingProficienciesCount,
      this._startingProficiencies,
      this._traits,
      this._resist,
      this._additionalHits,
      this._classSpells,
      this._giftedSpells,
      this._languages,
  this._subRaces,
      this._protected);

  Race.smart(
      {String name = "Example name",
      String description = "Example description",
      int speed = 30,
      int age = 100,
      int size = 2,
      String vision = "Обычное",
      Map<String, int>? abilityScoreImprovement,
      Set<SkillCheck>? skillChecks,
      Set<Proficiency>? optionalProficiencies,
      int startingProficienciesCount = 0,
      Set<Proficiency>? startingProficiencies,
      Set<Proficiency>? traits,
      Resist? resist,
      int additionalHits = 0,
        Map<String, Map<int, int>>? classSpells,
      Map<int, Set<Spell>>? giftedSpells,
      Set<String>? languages,
      bool usable = true,
        List<SubRace>? subRaces,
      bool protected = false})
      : _name = name,
        _description = description,
        _speed = speed,
        _age = age,
        _size = size,
        _vision = vision,
        _abilityScoreImprovement = abilityScoreImprovement ?? {},
        _skillChecks = skillChecks ?? {},
        _optionalProficiencies = optionalProficiencies ?? {},
        _startingProficienciesCount = startingProficienciesCount,
        _startingProficiencies = startingProficiencies ?? {},
        _traits = traits ?? {},
        _resist = resist ?? Resist.empty(),
        _additionalHits = additionalHits,
        _classSpells = classSpells ?? {},
        _giftedSpells = giftedSpells ?? {},
        _languages = languages ?? {},
        _subRaces = subRaces ?? [],
        _protected = protected;

  static String getStringSize(int sizeId) {
    switch (sizeId) {
      case 0:
        return "Крошечный";
      case 1:
        return "Маленький";
      case 2:
        return "Средний";
      case 3:
        return "Большой";
      case 4:
        return "Большой";
      case 5:
        return "Гигантский";
      default:
        return "Не определён";
    }
  }

  List<SubRace> get subRaces => _subRaces;

  set subRaces(List<SubRace> value) {
    _subRaces = value;
  }

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  Set<String> get languages => _languages;

  set languages(Set<String> value) {
    _languages = value;
  }

  Map<int, Set<Spell>> get giftedSpells => _giftedSpells;

  set giftedSpells(Map<int, Set<Spell>> value) {
    _giftedSpells = value;
  }

  int get additionalHits => _additionalHits;

  set additionalHits(int value) {
    _additionalHits = value;
  }

  Resist get resist => _resist;

  set resist(Resist value) {
    _resist = value;
  }

  Set<Proficiency> get traits => _traits;

  set traits(Set<Proficiency> value) {
    _traits = value;
  }

  Set<Proficiency> get startingProficiencies => _startingProficiencies;

  set startingProficiencies(Set<Proficiency> value) {
    _startingProficiencies = value;
  }

  int get startingProficienciesCount => _startingProficienciesCount;

  set startingProficienciesCount(int value) {
    _startingProficienciesCount = value;
  }

  Set<Proficiency> get optionalProficiencies => _optionalProficiencies;

  set optionalProficiencies(Set<Proficiency> value) {
    _optionalProficiencies = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    _skillChecks = value;
  }

  Map<String, int> get abilityScoreImprovement => _abilityScoreImprovement;

  set abilityScoreImprovement(Map<String, int> value) {
    _abilityScoreImprovement = value;
  }

  String get vision => _vision;

  set vision(String value) {
    _vision = value;
  }

  int get size => _size;

  set size(int value) {
    _size = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  int get speed => _speed;

  set speed(int value) {
    _speed = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<String, Map<int, int>> get classSpells => _classSpells;

  set classSpells(Map<String, Map<int, int>> value) {
    _classSpells = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Race &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _speed == other._speed &&
          _age == other._age &&
          _size == other._size &&
          _vision == other._vision &&
          _abilityScoreImprovement == other._abilityScoreImprovement &&
          _skillChecks == other._skillChecks &&
          _optionalProficiencies == other._optionalProficiencies &&
          _startingProficienciesCount == other._startingProficienciesCount &&
          _startingProficiencies == other._startingProficiencies &&
          _traits == other._traits &&
          _resist == other._resist &&
          _additionalHits == other._additionalHits &&
          _classSpells == other._classSpells &&
          _giftedSpells == other._giftedSpells &&
          _languages == other._languages &&
          _subRaces == other._subRaces &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _speed.hashCode ^
      _age.hashCode ^
      _size.hashCode ^
      _vision.hashCode ^
      _abilityScoreImprovement.hashCode ^
      _skillChecks.hashCode ^
      _optionalProficiencies.hashCode ^
      _startingProficienciesCount.hashCode ^
      _startingProficiencies.hashCode ^
      _traits.hashCode ^
      _resist.hashCode ^
      _additionalHits.hashCode ^
      _classSpells.hashCode ^
      _giftedSpells.hashCode ^
      _languages.hashCode ^
      _subRaces.hashCode ^
      _protected.hashCode;

/*Race.copyFrom(Race object){
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
  }*/

/*void copySubRace(int index){
    _subRaces.add(SubRace.copyFrom(_subRaces.elementAt(index)));
  }*/

}
