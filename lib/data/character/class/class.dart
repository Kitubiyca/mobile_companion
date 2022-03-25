import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'fighting_style.dart';
import 'level.dart';

class Class{

  late String _name;
  late String _description;
  late Dice _hits;
  late int? _unarmoredArmorConst;
  late Set<String>? _unarmoredArmor;
  late int _spellcasterLevel; // 0-not 1-full 2-half 3-third
  late bool _hasSpecialMagicTable;
  late Set<String> _savingChecks;
  late String _classPointsName;
  late Set<Proficiency> _proficiencies;
  late int _subClassChooseLevel;
  late List<Level> _levels;
  late List<SubClass> subClasses = [];
  late List<FightingStyle> styles = [];
  late bool _protected;

  static List<Class> classes = [];

  Class(
      this._name,
      this._description,
      this._hits,
      this._unarmoredArmorConst,
      this._unarmoredArmor,
      this._spellcasterLevel,
      this._hasSpecialMagicTable,
      this._savingChecks,
      this._classPointsName,
      this._proficiencies,
      this._subClassChooseLevel,
      this._levels,
      this.subClasses,
      this.styles,
      this._protected);

  Class.withAdd(
      this._name,
      this._description,
      this._hits,
      this._unarmoredArmorConst,
      this._unarmoredArmor,
      this._spellcasterLevel,
      this._hasSpecialMagicTable,
      this._savingChecks,
      this._classPointsName,
      this._proficiencies,
      this._subClassChooseLevel,
      this._levels,
      this.subClasses,
      this.styles,
      this._protected){classes.add(this);}

  Class.copyFrom(Class object){
    _name = object.name;
    _description = object.description;
    _hits = object.hits;

  }

  bool get protected => _protected;

  List<Level> get levels => _levels;

  set levels(List<Level> value) {
    _levels = value;
  }

  int get subClassChooseLevel => _subClassChooseLevel;

  set subClassChooseLevel(int value) {
    _subClassChooseLevel = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  String get classPointsName => _classPointsName;

  set classPointsName(String value) {
    _classPointsName = value;
  }

  Set<String> get savingChecks => _savingChecks;

  set savingChecks(Set<String> value) {
    _savingChecks = value;
  }

  bool get hasSpecialMagicTable => _hasSpecialMagicTable;

  set hasSpecialMagicTable(bool value) {
    _hasSpecialMagicTable = value;
  }

  int get magicPowerRank => _spellcasterLevel;

  set magicPowerRank(int value) {
    _spellcasterLevel = value;
  }

  Set<String>? get unarmoredArmor => _unarmoredArmor;

  set unarmoredArmor(Set<String>? value) {
    _unarmoredArmor = value;
  }

  int? get unarmoredArmorConst => _unarmoredArmorConst;

  set unarmoredArmorConst(int? value) {
    _unarmoredArmorConst = value;
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
          _unarmoredArmorConst == other._unarmoredArmorConst &&
          _unarmoredArmor == other._unarmoredArmor &&
          _spellcasterLevel == other._spellcasterLevel &&
          _hasSpecialMagicTable == other._hasSpecialMagicTable &&
          _savingChecks == other._savingChecks &&
          _classPointsName == other._classPointsName &&
          _proficiencies == other._proficiencies &&
          _subClassChooseLevel == other._subClassChooseLevel &&
          _levels == other._levels &&
          subClasses == other.subClasses &&
          styles == other.styles &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _hits.hashCode ^
      _unarmoredArmorConst.hashCode ^
      _unarmoredArmor.hashCode ^
      _spellcasterLevel.hashCode ^
      _hasSpecialMagicTable.hashCode ^
      _savingChecks.hashCode ^
      _classPointsName.hashCode ^
      _proficiencies.hashCode ^
      _subClassChooseLevel.hashCode ^
      _levels.hashCode ^
      subClasses.hashCode ^
      styles.hashCode ^
      _protected.hashCode;
}