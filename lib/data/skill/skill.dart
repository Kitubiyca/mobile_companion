import 'dart:math';

import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/character/class/class.dart';
import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/class_dependency.dart';
import 'package:dnd_companion/data/structures/rest.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 73)
class Skill {
  //TODO print classes with this skill
  //TODO механика поинтов скиллов с откатом в короткий или продолжительный отдых
  //TODO подумать над весом, преимуществом и помехой
  //TODO улучшения зверя (питомца)

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  ClassDependency? _consumedPointsDependency; // what points consumes, if does
  @HiveField(3)
  int? _consumedPointsCount; // how many points being consumed
  @HiveField(4)
  Map<int, int>? _maxCharges;
  @HiveField(5)
  Characteristic?
      _maxChargesFromCharacteristic; // adds 1 charge from each characteristic modifier
  @HiveField(6)
  Rest? _rechargeRequirement;
  @HiveField(7)
  Map<int, Dice>? _diceImpact; // dice impact (heal or damage), depends on level
  @HiveField(8)
  Map<int, int>? _constImpact; // const impact instead of dice, depends on level
  @HiveField(9)
  bool _addClassLevel;
  @HiveField(10)
  DamageType? _damageType;
  @HiveField(11)
  bool
      _castDifficulty; // checks if you need to see case difficulty of the skill
  @HiveField(12)
  bool _attack; //checks if you need to throw a hit attack dice
  @HiveField(13)
  Set<Characteristic>? _characteristics; // characteristics modifier check
  @HiveField(14)
  double? _levelMultiplier; // adds class level multiplied by this number

  //Set<BonusType> _bonusTypes; // TODO возможность сохранения бонуса (многразовость)

  @HiveField(15)
  bool _protected;

  Skill(
      this._name,
      this._description,
      this._consumedPointsDependency,
      this._consumedPointsCount,
      this._maxCharges,
      this._maxChargesFromCharacteristic,
      this._rechargeRequirement,
      this._diceImpact,
      this._constImpact,
      this._addClassLevel,
      this._damageType,
      this._castDifficulty,
      this._attack,
      this._characteristics,
      this._levelMultiplier,
      this._protected);

  Skill.smart(
      {required String name,
      String description = "",
      ClassDependency? consumedPointsDependency,
      int? consumedPointsCount,
      Map<int, int>? maxCharges,
      Characteristic? maxChargesFromCharacteristic,
      Rest? rechargeRequirement,
      Map<int, Dice>? diceImpact,
      Map<int, int>? constImpact,
      bool addClassLevel = false,
      DamageType? damageType,
      bool castDifficulty = false,
      bool attack = false,
      Set<Characteristic>? characteristics,
      double? levelMultiplier,
      bool protected = false})
      : _name = name,
        _description = description,
        _consumedPointsDependency = consumedPointsDependency,
        _consumedPointsCount = consumedPointsCount,
        _maxCharges = maxCharges,
        _maxChargesFromCharacteristic = maxChargesFromCharacteristic,
        _rechargeRequirement = rechargeRequirement,
        _diceImpact = diceImpact,
        _constImpact = constImpact,
        _addClassLevel = addClassLevel,
        _damageType = damageType,
        _castDifficulty = castDifficulty,
        _attack = attack,
        _characteristics = characteristics,
        _levelMultiplier = levelMultiplier,
        _protected = protected;

  void use(BuildContext context, Character character, Class? characterClass){
    Map<String, int> ret = {};
    if(_diceImpact != null){
      int index = _diceImpact!.keys.lastWhere((element) => element <= character.level);
      ret[_diceImpact![index]!.name] = _diceImpact![index]!.roll().first;
    }
    if(_constImpact != null){
      ret["константа"] = _constImpact![_constImpact!.keys.lastWhere((element) => element <= character.level)]!;
    }
    if(_addClassLevel && characterClass != null){
      ret["уровень класса"] = character.characterClass[characterClass]!;
    }
    Utils.showAlertRoll(context, _name, ret);
  }

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  double? get levelMultiplier => _levelMultiplier;

  set levelMultiplier(double? value) {
    _levelMultiplier = value;
  }

  Set<Characteristic>? get characteristics => _characteristics;

  set characteristics(Set<Characteristic>? value) {
    _characteristics = value;
  }

  bool get attack => _attack;

  set attack(bool value) {
    _attack = value;
  }

  bool get castDifficulty => _castDifficulty;

  set castDifficulty(bool value) {
    _castDifficulty = value;
  }

  DamageType? get damageType => _damageType;

  set damageType(DamageType? value) {
    _damageType = value;
  }

  bool get addClassLevel => _addClassLevel;

  set addClassLevel(bool value) {
    _addClassLevel = value;
  }

  Map<int, int>? get constImpact => _constImpact;

  set constImpact(Map<int, int>? value) {
    _constImpact = value;
  }

  Map<int, Dice>? get diceImpact => _diceImpact;

  set diceImpact(Map<int, Dice>? value) {
    _diceImpact = value;
  }

  Rest? get rechargeRequirement => _rechargeRequirement;

  set rechargeRequirement(Rest? value) {
    _rechargeRequirement = value;
  }

  Characteristic? get maxChargesFromCharacteristic =>
      _maxChargesFromCharacteristic;

  set maxChargesFromCharacteristic(Characteristic? value) {
    _maxChargesFromCharacteristic = value;
  }

  Map<int, int>? get maxCharges => _maxCharges;

  set maxCharges(Map<int, int>? value) {
    _maxCharges = value;
  }

  int? get consumedPointsCount => _consumedPointsCount;

  set consumedPointsCount(int? value) {
    _consumedPointsCount = value;
  }

  ClassDependency? get consumedPointsDependency => _consumedPointsDependency;

  set consumedPointsDependency(ClassDependency? value) {
    _consumedPointsDependency = value;
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
      other is Skill &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _consumedPointsDependency == other._consumedPointsDependency &&
          _consumedPointsCount == other._consumedPointsCount &&
          _maxCharges == other._maxCharges &&
          _maxChargesFromCharacteristic ==
              other._maxChargesFromCharacteristic &&
          _rechargeRequirement == other._rechargeRequirement &&
          _diceImpact == other._diceImpact &&
          _constImpact == other._constImpact &&
          _addClassLevel == other._addClassLevel &&
          _damageType == other._damageType &&
          _castDifficulty == other._castDifficulty &&
          _attack == other._attack &&
          _characteristics == other._characteristics &&
          _levelMultiplier == other._levelMultiplier &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _consumedPointsDependency.hashCode ^
      _consumedPointsCount.hashCode ^
      _maxCharges.hashCode ^
      _maxChargesFromCharacteristic.hashCode ^
      _rechargeRequirement.hashCode ^
      _diceImpact.hashCode ^
      _constImpact.hashCode ^
      _addClassLevel.hashCode ^
      _damageType.hashCode ^
      _castDifficulty.hashCode ^
      _attack.hashCode ^
      _characteristics.hashCode ^
      _levelMultiplier.hashCode ^
      _protected.hashCode;
}
