import 'package:dnd_companion/data/character/class/sub_class_level.dart';
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
  String? _subClassDiceName;
  @HiveField(7)
  Map<int, Set<SubClassLevel>> _subClassSkills;
  @HiveField(8)
  bool _protected;

  SubClass(
      this._name,
      this._description,
      this._spellcasterType,
      this._spellCastingAbility,
      this._subClassPointsName,
      this._restType,
      this._subClassDiceName,
      this._subClassSkills,
      this._protected);

  SubClass.smart({
  required String name,
  String description = "",
  SpellcasterType spellcasterType = SpellcasterType.none,
  Characteristic spellCastingAbility = Characteristic.none,
  String? subClassPointsName,
  Rest? restType,
  String? subClassDiceName,
  required subClassSkills,
  protected = false}) :
        _name = name,
        _description = description,
        _spellcasterType = spellcasterType,
        _spellCastingAbility = spellCastingAbility,
        _subClassPointsName = subClassPointsName,
        _restType = restType,
        _subClassDiceName = subClassDiceName,
        _subClassSkills = subClassSkills,
        _protected = protected;

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  Map<int, Set<SubClassLevel>> get subClassSkills => _subClassSkills;

  set subClassSkills(Map<int, Set<SubClassLevel>> value) {
    _subClassSkills = value;
  }

  String? get subClassDiceName => _subClassDiceName;

  set subClassDiceName(String? value) {
    _subClassDiceName = value;
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
          _subClassDiceName == other._subClassDiceName &&
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
      _subClassDiceName.hashCode ^
      _subClassSkills.hashCode ^
      _protected.hashCode;
}