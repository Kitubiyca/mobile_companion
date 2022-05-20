import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rest.dart';
import 'package:dnd_companion/data/structures/spellcaster_type.dart';
import 'package:hive/hive.dart';
import 'level.dart';

part 'package:dnd_companion/g_parts/class.g.dart';

@HiveType(typeId: 111)
class Class {
  //TODO выбор стартового снаряжения?
  //TODO выбор умений или инструментов

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  Dice _hits;

  @HiveField(3)
  bool? _multiClassingLogic; // false = or, true = and
  @HiveField(4)
  int? _multiClassingProficienciesCount;
  @HiveField(5)
  Map<String, int>? _multiClassingRequirements;
  @HiveField(6)
  Set<Proficiency>? _multiClassingProficiencies;
  @HiveField(7)
  Set<Proficiency>? _multiClassingProficiencyChoices;

  @HiveField(8)
  Characteristic _spellCastingAbility;
  @HiveField(9)
  String? _focusItem;
  @HiveField(10)
  bool _hasSpecialMagicTable;
  @HiveField(11)
  int _spellcasterStartLevel;
  @HiveField(12)
  SpellcasterType _spellcasterType;

  @HiveField(13)
  int _proficiencyCount;
  @HiveField(14)
  Set<Proficiency> _proficiencyChoices;
  @HiveField(15)
  Set<Proficiency> _proficiencies;

  @HiveField(16)
  Set<String> _savingChecks;
  @HiveField(17)
  Rest? _restType; // points regen rest type
  @HiveField(18)
  String? _classPointsName;
  @HiveField(19)
  String? _classDiceName;
  @HiveField(20)
  List<Level> _levels;

  @HiveField(21)
  Map<Item, int> _items;

  //Characteristic _preparedSpellCounter; // TODO check this for duplicating spellCastingAbility
  //String? _activeState; //TODO active states like animal forms or barbarian rage

  @HiveField(22)
  int _subClassChooseLevel;
  @HiveField(23)
  List<SubClass> _subClasses;

  //late int? _unarmoredArmorConst;
  //late Set<String>? _unarmoredArmor;
  //late List<FightingStyle> styles;

  @HiveField(24)
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
      this._spellCastingAbility,
      this._focusItem,
      this._hasSpecialMagicTable,
      this._spellcasterStartLevel,
      this._spellcasterType,
      this._proficiencyCount,
      this._proficiencyChoices,
      this._proficiencies,
      this._savingChecks,
      this._restType,
      this._classPointsName,
      this._classDiceName,
      this._levels,
      this._items,
      this._subClassChooseLevel,
      this._subClasses,
      this._protected);

  Class.smart(
      {required String name,
      String description = "",
      required Dice hits,
      bool? multiClassingLogic,
      int? multiClassingProficienciesCount,
      Map<String, int>? multiClassingRequirements,
      Set<Proficiency>? multiClassingProficiencies,
      Set<Proficiency>? multiClassingProficiencyChoices,
      Characteristic spellCastingAbility = Characteristic.none,
      String? focusItem,
      bool hasSpecialMagicTable = false,
      int spellcasterStartLevel = 0,
      SpellcasterType spellcasterType = SpellcasterType.none,
      int proficiencyCount = 0,
      Set<Proficiency>? proficiencyChoices,
      Set<Proficiency>? proficiencies,
      required Set<String> savingChecks,
      Rest? restType,
      String? classPointsName,
      String? classDiceName,
      required List<Level> levels,
      Map<Item, int>? items,
      int subClassChooseLevel = 2,
      List<SubClass>? subClasses,
      bool protected = false})
      : _name = name,
        _description = description,
        _hits = hits,
        _multiClassingLogic = multiClassingLogic,
        _multiClassingProficienciesCount = multiClassingProficienciesCount,
        _multiClassingRequirements = multiClassingRequirements,
        _multiClassingProficiencies = multiClassingProficiencies,
        _multiClassingProficiencyChoices = multiClassingProficiencyChoices,
        _spellCastingAbility = spellCastingAbility,
        _focusItem = focusItem,
        _hasSpecialMagicTable = hasSpecialMagicTable,
        _spellcasterStartLevel = spellcasterStartLevel,
        _spellcasterType = spellcasterType,
        _proficiencyCount = proficiencyCount,
        _proficiencyChoices = proficiencyChoices ?? {},
        _proficiencies = proficiencies ?? {},
        _savingChecks = savingChecks,
        _restType = restType,
        _classPointsName = classPointsName,
        _classDiceName = classDiceName,
        _levels = levels,
        _items = items ?? {},
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

  String? get classDiceName => _classDiceName;

  set classDiceName(String? value) {
    _classDiceName = value;
  }

  String? get classPointsName => _classPointsName;

  set classPointsName(String? value) {
    _classPointsName = value;
  }

  Rest? get restType => _restType;

  set restType(Rest? value) {
    _restType = value;
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

  SpellcasterType get spellcasterType => _spellcasterType;

  set spellcasterType(SpellcasterType value) {
    _spellcasterType = value;
  }

  int get spellcasterStartLevel => _spellcasterStartLevel;

  set spellcasterStartLevel(int value) {
    _spellcasterStartLevel = value;
  }

  bool get hasSpecialMagicTable => _hasSpecialMagicTable;

  set hasSpecialMagicTable(bool value) {
    _hasSpecialMagicTable = value;
  }

  String? get focusItem => _focusItem;

  set focusItem(String? value) {
    _focusItem = value;
  }

  Characteristic get spellCastingAbility => _spellCastingAbility;

  set spellCastingAbility(Characteristic value) {
    _spellCastingAbility = value;
  }

  Set<Proficiency>? get multiClassingProficiencyChoices =>
      _multiClassingProficiencyChoices;

  set multiClassingProficiencyChoices(Set<Proficiency>? value) {
    _multiClassingProficiencyChoices = value;
  }

  Set<Proficiency>? get multiClassingProficiencies =>
      _multiClassingProficiencies;

  set multiClassingProficiencies(Set<Proficiency>? value) {
    _multiClassingProficiencies = value;
  }

  Map<String, int>? get multiClassingRequirements => _multiClassingRequirements;

  set multiClassingRequirements(Map<String, int>? value) {
    _multiClassingRequirements = value;
  }

  int? get multiClassingProficienciesCount => _multiClassingProficienciesCount;

  set multiClassingProficienciesCount(int? value) {
    _multiClassingProficienciesCount = value;
  }

  bool? get multiClassingLogic => _multiClassingLogic;

  set multiClassingLogic(bool? value) {
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

  Map<Item, int> get items => _items;

  set items(Map<Item, int> value) {
    _items = value;
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
          _spellCastingAbility == other._spellCastingAbility &&
          _focusItem == other._focusItem &&
          _hasSpecialMagicTable == other._hasSpecialMagicTable &&
          _spellcasterStartLevel == other._spellcasterStartLevel &&
          _spellcasterType == other._spellcasterType &&
          _proficiencyCount == other._proficiencyCount &&
          _proficiencyChoices == other._proficiencyChoices &&
          _proficiencies == other._proficiencies &&
          _savingChecks == other._savingChecks &&
          _restType == other._restType &&
          _classPointsName == other._classPointsName &&
          _classDiceName == other._classDiceName &&
          _levels == other._levels &&
          _items == other._items &&
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
      _spellCastingAbility.hashCode ^
      _focusItem.hashCode ^
      _hasSpecialMagicTable.hashCode ^
      _spellcasterStartLevel.hashCode ^
      _spellcasterType.hashCode ^
      _proficiencyCount.hashCode ^
      _proficiencyChoices.hashCode ^
      _proficiencies.hashCode ^
      _savingChecks.hashCode ^
      _restType.hashCode ^
      _classPointsName.hashCode ^
      _classDiceName.hashCode ^
      _levels.hashCode ^
      _items.hashCode ^
      _subClassChooseLevel.hashCode ^
      _subClasses.hashCode ^
      _protected.hashCode;
}
