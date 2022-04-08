import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'fighting_style.dart';
import 'level.dart';

class Class {

  String _name;
  String _description;
  Dice _hits;

  bool _multiClassingLogic; // false = or, true = and
  int _multiClassingProficienciesCount;
  Map<String, int> _multiClassingRequirements;
  Set<Proficiency> _multiClassingProficiencies;
  Set<Proficiency> _multiClassingProficiencyChoices;

  bool _hasSpecialMagicTable;
  int _spellcasterStart;
  int _spellcasterLevel; // 0-not 1-full 2-half 3-third

  int _proficiencyCount;
  Set<Proficiency> _proficiencyChoices;
  Set<Proficiency> _proficiencies;

  Set<String> _savingChecks;
  String _classPointsName;
  List<Level> _levels;

  int _subClassChooseLevel;
  List<SubClass> _subClasses;

  //late int? _unarmoredArmorConst;
  //late Set<String>? _unarmoredArmor;
  //late List<FightingStyle> styles;

  bool _protected;

  Class(
      this._name,
      this._description,
      this._hits,
      this._multiClassingLogic,
      this._multiClassingProficienciesCount,
      this._multiClassingRequirements,
      this._multiClassingProficiencies,
      this._multiClassingProficiencyChoices,
      this._hasSpecialMagicTable,
      this._spellcasterStart,
      this._spellcasterLevel,
      this._proficiencyCount,
      this._proficiencyChoices,
      this._proficiencies,
      this._savingChecks,
      this._classPointsName,
      this._levels,
      this._subClassChooseLevel,
      this._subClasses,
      this._protected);

  Class.smart(
      {String name = "Example name",
      String description = "Example description",
      Dice? hits,
      bool multiClassingLogic = true,
      int multiClassingProficienciesCount = 0,
      Map<String, int>? multiClassingRequirements,
      Set<Proficiency>? multiClassingProficiencies,
      Set<Proficiency>? multiClassingProficiencyChoices,
      bool hasSpecialMagicTable = false,
      int spellcasterStart = 0,
      int spellcasterLevel = 0,
      int proficiencyCount = 0,
      Set<Proficiency>? proficiencyChoices,
      Set<Proficiency>? proficiencies,
      Set<String>? savingChecks,
      String classPointsName = "",
      List<Level>? levels,
      int subClassChooseLevel = 4,
      List<SubClass>? subClasses,
      bool protected = false})
      : _name = name,
        _description = description,
        _hits = hits ?? Dice(1, 12),
        _multiClassingLogic = multiClassingLogic,
        _multiClassingProficienciesCount = multiClassingProficienciesCount,
        _multiClassingRequirements = multiClassingRequirements ?? {},
        _multiClassingProficiencies = multiClassingProficiencies ?? {},
        _multiClassingProficiencyChoices =
            multiClassingProficiencyChoices ?? {},
        _hasSpecialMagicTable = hasSpecialMagicTable,
        _spellcasterStart = spellcasterStart,
        _spellcasterLevel = spellcasterLevel,
        _proficiencyCount = proficiencyCount,
        _proficiencyChoices = proficiencyChoices ?? {},
        _proficiencies = proficiencies ?? {},
        _savingChecks = savingChecks ?? {},
        _classPointsName = classPointsName,
        _levels = levels ?? [],
        _subClassChooseLevel = subClassChooseLevel,
        _subClasses = subClasses ?? [],
        _protected = protected;

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  List<SubClass> get subClasses => _subClasses;

  set subClasses(List<SubClass> value) {
    _subClasses = value;
  }

  int get subClassChooseLevel => _subClassChooseLevel;

  set subClassChooseLevel(int value) {
    _subClassChooseLevel = value;
  }

  List<Level> get levels => _levels;

  set levels(List<Level> value) {
    _levels = value;
  }

  String get classPointsName => _classPointsName;

  set classPointsName(String value) {
    _classPointsName = value;
  }

  Set<String> get savingChecks => _savingChecks;

  set savingChecks(Set<String> value) {
    _savingChecks = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  Set<Proficiency> get proficiencyChoices => _proficiencyChoices;

  set proficiencyChoices(Set<Proficiency> value) {
    _proficiencyChoices = value;
  }

  int get proficiencyCount => _proficiencyCount;

  set proficiencyCount(int value) {
    _proficiencyCount = value;
  }

  int get spellcasterLevel => _spellcasterLevel;

  set spellcasterLevel(int value) {
    _spellcasterLevel = value;
  }

  int get spellcasterStart => _spellcasterStart;

  set spellcasterStart(int value) {
    _spellcasterStart = value;
  }

  bool get hasSpecialMagicTable => _hasSpecialMagicTable;

  set hasSpecialMagicTable(bool value) {
    _hasSpecialMagicTable = value;
  }

  Set<Proficiency> get multiClassingProficiencyChoices =>
      _multiClassingProficiencyChoices;

  set multiClassingProficiencyChoices(Set<Proficiency> value) {
    _multiClassingProficiencyChoices = value;
  }

  Set<Proficiency> get multiClassingProficiencies =>
      _multiClassingProficiencies;

  set multiClassingProficiencies(Set<Proficiency> value) {
    _multiClassingProficiencies = value;
  }

  Map<String, int> get multiClassingRequirements => _multiClassingRequirements;

  set multiClassingRequirements(Map<String, int> value) {
    _multiClassingRequirements = value;
  }

  int get multiClassingProficienciesCount => _multiClassingProficienciesCount;

  set multiClassingProficienciesCount(int value) {
    _multiClassingProficienciesCount = value;
  }

  bool get multiClassingLogic => _multiClassingLogic;

  set multiClassingLogic(bool value) {
    _multiClassingLogic = value;
  }

  Dice get hits => _hits;

  set hits(Dice value) {
    _hits = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Class &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _hits == other._hits &&
          _multiClassingLogic == other._multiClassingLogic &&
          _multiClassingProficienciesCount ==
              other._multiClassingProficienciesCount &&
          _multiClassingRequirements == other._multiClassingRequirements &&
          _multiClassingProficiencies == other._multiClassingProficiencies &&
          _multiClassingProficiencyChoices ==
              other._multiClassingProficiencyChoices &&
          _hasSpecialMagicTable == other._hasSpecialMagicTable &&
          _spellcasterStart == other._spellcasterStart &&
          _spellcasterLevel == other._spellcasterLevel &&
          _proficiencyCount == other._proficiencyCount &&
          _proficiencyChoices == other._proficiencyChoices &&
          _proficiencies == other._proficiencies &&
          _savingChecks == other._savingChecks &&
          _classPointsName == other._classPointsName &&
          _levels == other._levels &&
          _subClassChooseLevel == other._subClassChooseLevel &&
          _subClasses == other._subClasses &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _hits.hashCode ^
      _multiClassingLogic.hashCode ^
      _multiClassingProficienciesCount.hashCode ^
      _multiClassingRequirements.hashCode ^
      _multiClassingProficiencies.hashCode ^
      _multiClassingProficiencyChoices.hashCode ^
      _hasSpecialMagicTable.hashCode ^
      _spellcasterStart.hashCode ^
      _spellcasterLevel.hashCode ^
      _proficiencyCount.hashCode ^
      _proficiencyChoices.hashCode ^
      _proficiencies.hashCode ^
      _savingChecks.hashCode ^
      _classPointsName.hashCode ^
      _levels.hashCode ^
      _subClassChooseLevel.hashCode ^
      _subClasses.hashCode ^
      _protected.hashCode;
}
