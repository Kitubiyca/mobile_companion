import 'package:dnd_companion/data/character/class/class.dart';
import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';

class Spell{

  late String _name;
  late String _description;
  late List<String> _higherDescription;
  late int _range;
  late bool _verbal;
  late bool _somatic;
  late Map<Item, int> _materials;
  late bool _ritual;
  late String _duration;
  late bool _concentration;
  late int _castingTime;
  late int _level;

  late bool _difficultyClass; // spell evasion difficulty(8 + prof bonus + spellcasting mod(magic save mod)) that target need to beat
  late bool _armorPenetration; // d20 + class attack modifier vs target armor class

  late String _savingModifier; // d20 + saving mod + (prof bonus)?

  late DamageType _damageType;
  late List<Dice> _impact;
  late int _constImpact;

  late Set<Class> _classes;

  late bool _protected;

  Spell(
      this._name,
      this._description,
      this._higherDescription,
      this._range,
      this._verbal,
      this._somatic,
      this._materials,
      this._ritual,
      this._duration,
      this._concentration,
      this._castingTime,
      this._level,
      this._difficultyClass,
      this._armorPenetration,
      this._savingModifier,
      this._damageType,
      this._impact,
      this._constImpact,
      this._classes,
      this._protected);

  Spell.copyFrom(Spell object);

  //Spell.copyFrom(Spell object){
  //  _name = object.name;
  //  _description = object.description;
  //  _cast = object.cast;
  //  _verbal = object.verbal;
  //  _somatic = object.somatic;
  //  _ritual = object.ritual;
  //  _concentration = object.concentration;
  //  _reaction = object.reaction;
  //  for(int i = 0; i < object.materials.length; i++){
  //    _materials[Item.copyFrom(object.materials.keys.elementAt(i))] = object.materials.values.elementAt(i);
  //  }
  //  for(int i = 0; i < object.levels.length; i++){
  //    _levels.add(SpellLevel.copyFrom(object.levels[i]));
  //  }
  //  _protected = false;
  //}

  String getDices(){
    String ret = "";
    if (_impact.isNotEmpty){
      ret += _impact[0].name;
      for(int i = 1; i < _impact.length; i++){
        ret += ", " + _impact[i].name;
      }
    }
    return ret;
  }

  String getMarks(){
    String ret = "";
    bool first = true;
    if(_verbal){
      ret += "V";
      first = false;
    }
    if(_somatic){
      if(first) ret += "S";
      else ret += ", S";
      first = false;
    }
    if(_materials.isNotEmpty){
      if(first) ret += "M";
      else ret += ", M";
      first = false;
    }
    if(_ritual){
      if(first) ret += "R";
      else ret += ", R";
      first = false;
    }
    if(_concentration){
      if(first) ret += "C";
      else ret += ", C";
      first = false;
    }
    return ret;
  }

  String getMaterials(){
    String ret = "";
    if(_materials.isNotEmpty){
      ret += _materials.keys.elementAt(0).name + ": " + _materials.values.elementAt(0).toString();
      for(int i = 1; i < _materials.keys.length; i++){
        ret += ", " + _materials.keys.elementAt(i).name + ": " + _materials.values.elementAt(i).toString();
      }
    }
    return ret;
  }

  bool get protected => _protected;

  int get constImpact => _constImpact;

  set constImpact(int value) {
    _constImpact = value;
  }

  List<Dice> get impact => _impact;

  set impact(List<Dice> value) {
    _impact = value;
  }

  DamageType get damageType => _damageType;

  set damageType(DamageType value) {
    _damageType = value;
  }

  String get savingModifier => _savingModifier;

  set savingModifier(String value) {
    _savingModifier = value;
  }

  bool get armorPenetration => _armorPenetration;

  set armorPenetration(bool value) {
    _armorPenetration = value;
  }

  bool get difficultyClass => _difficultyClass;

  set difficultyClass(bool value) {
    _difficultyClass = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  int get castingTime => _castingTime;

  set castingTime(int value) {
    _castingTime = value;
  }

  bool get concentration => _concentration;

  set concentration(bool value) {
    _concentration = value;
  }

  String get duration => _duration;

  set duration(String value) {
    _duration = value;
  }

  bool get ritual => _ritual;

  set ritual(bool value) {
    _ritual = value;
  }

  Map<Item, int> get materials => _materials;

  set materials(Map<Item, int> value) {
    _materials = value;
  }

  bool get somatic => _somatic;

  set somatic(bool value) {
    _somatic = value;
  }

  bool get verbal => _verbal;

  set verbal(bool value) {
    _verbal = value;
  }

  int get range => _range;

  set range(int value) {
    _range = value;
  }

  List<String> get higherDescription => _higherDescription;

  set higherDescription(List<String> value) {
    _higherDescription = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Set<Class> get classes => _classes;

  set classes(Set<Class> value) {
    _classes = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spell &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _higherDescription == other._higherDescription &&
          _range == other._range &&
          _verbal == other._verbal &&
          _somatic == other._somatic &&
          _materials == other._materials &&
          _ritual == other._ritual &&
          _duration == other._duration &&
          _concentration == other._concentration &&
          _castingTime == other._castingTime &&
          _level == other._level &&
          _difficultyClass == other._difficultyClass &&
          _armorPenetration == other._armorPenetration &&
          _savingModifier == other._savingModifier &&
          _damageType == other._damageType &&
          _impact == other._impact &&
          _constImpact == other._constImpact &&
          _classes == other._classes &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _higherDescription.hashCode ^
      _range.hashCode ^
      _verbal.hashCode ^
      _somatic.hashCode ^
      _materials.hashCode ^
      _ritual.hashCode ^
      _duration.hashCode ^
      _concentration.hashCode ^
      _castingTime.hashCode ^
      _level.hashCode ^
      _difficultyClass.hashCode ^
      _armorPenetration.hashCode ^
      _savingModifier.hashCode ^
      _damageType.hashCode ^
      _impact.hashCode ^
      _constImpact.hashCode ^
      _classes.hashCode ^
      _protected.hashCode;
}