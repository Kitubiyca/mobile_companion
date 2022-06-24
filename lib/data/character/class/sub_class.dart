import 'package:dnd_companion/data/character/class/sub_class_level.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rest.dart';
import 'package:dnd_companion/data/structures/spellcaster_type.dart';
import 'package:hive/hive.dart';

part 'sub_class.g.dart';

@HiveType(typeId: 113)
class SubClass{

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  SpellcasterType _spellcasterType;
  @HiveField(3)
  Characteristic _spellCastingAbility;
  @HiveField(4)
  String? _subClassPointsName;
  @HiveField(5)
  Rest? _restType;
  @HiveField(6)
  String? _diceName; // sub class dice name
  @HiveField(7)
  Map<int, Dice> _dice;
  @HiveField(8)
  Map<int, SubClassLevel> _subClassSkills;
  @HiveField(9)
  bool _protected;

  SubClass(
      this._name,
      this._description,
      this._spellcasterType,
      this._spellCastingAbility,
      this._subClassPointsName,
      this._restType,
      this._diceName,
      this._dice,
      this._subClassSkills,
      this._protected);

  SubClass.smart({
  required String name,
  String description = "",
  SpellcasterType spellcasterType = SpellcasterType.none,
  Characteristic spellCastingAbility = Characteristic.none,
  String? subClassPointsName,
  Rest? restType,
  String? diceName,
  Map<int, Dice>? dice,
  required Map<int, SubClassLevel> subClassSkills,
  protected = false}) :
        _name = name,
        _description = description,
        _spellcasterType = spellcasterType,
        _spellCastingAbility = spellCastingAbility,
        _subClassPointsName = subClassPointsName,
        _restType = restType,
        _diceName = diceName,
        _dice = dice ?? {},
        _subClassSkills = subClassSkills,
        _protected = protected;

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  Map<int, SubClassLevel> get subClassSkills => _subClassSkills;

  set subClassSkills(Map<int, SubClassLevel> value) {
    _subClassSkills = value;
  }

  String? get subClassDiceName => _diceName;

  set subClassDiceName(String? value) {
    _diceName = value;
  }

  Rest? get restType => _restType;

  set restType(Rest? value) {
    _restType = value;
  }

  String? get subClassPointsName => _subClassPointsName;

  set subClassPointsName(String? value) {
    _subClassPointsName = value;
  }

  Characteristic get spellCastingAbility => _spellCastingAbility;

  set spellCastingAbility(Characteristic value) {
    _spellCastingAbility = value;
  }

  SpellcasterType get spellcasterType => _spellcasterType;

  set spellcasterType(SpellcasterType value) {
    _spellcasterType = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<int, Dice> get dice => _dice;

  set dice(Map<int, Dice> value) {
    _dice = value;
  }

  String? get diceName => _diceName;

  set diceName(String? value) {
    _diceName = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubClass &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _spellcasterType == other._spellcasterType &&
          _spellCastingAbility == other._spellCastingAbility &&
          _subClassPointsName == other._subClassPointsName &&
          _restType == other._restType &&
          _diceName == other._diceName &&
          _dice == other._dice &&
          _subClassSkills == other._subClassSkills &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _spellcasterType.hashCode ^
      _spellCastingAbility.hashCode ^
      _subClassPointsName.hashCode ^
      _restType.hashCode ^
      _diceName.hashCode ^
      _dice.hashCode ^
      _subClassSkills.hashCode ^
      _protected.hashCode;
}