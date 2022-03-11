import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';

class Background{

  late String _name;
  late String _description;
  late String _skillName;
  late String _skill;
  late Set<SkillCheck> _skillChecks;
  late Set<Proficiency> _proficiencies;
  late Set<Item> _items;
  late Set<String> _languages;
  late bool _protected;

  static List<Background> backgrounds = [];

  Background(
      this._name,
      this._description,
      this._skillName,
      this._skill,
      this._skillChecks,
      this._proficiencies,
      this._languages,
      this._items,
      this._protected);

  Background.withAdd(
      this._name,
      this._description,
      this._skillName,
      this._skill,
      this._skillChecks,
      this._proficiencies,
      this._languages,
      this._items,
      this._protected){backgrounds.add(this);}

  Background.copyFrom(Background object){
    _name = object.name;
    _description = object.description;
    _skillName = object.skillName;
    _skill = object.skill;
    for(int i = 0; i < object.skillChecks.length; i++){
      _skillChecks.add(SkillCheck.copyFrom(object.skillChecks.elementAt(i)));
    }
    for(int i = 0; i < object.proficiencies.length; i++){
      _proficiencies.add(Proficiency.copyFrom(object.proficiencies.elementAt(i)));
    }
    for(int i = 0; i < object.items.length; i++){
      _items.add(Item.copyFrom(object.items.elementAt(i)));
    }
    _languages.addAll(object.languages);
    _protected = false;
  }

  bool get protected => _protected;

  set protected(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _protected = value;
  }

  Set<Item> get items => _items;

  void addItems(Set<Item> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for(int i = 0; i < value.length; i++){
      items.add(Item.copyFrom(value.elementAt(i)));
    }
  }

  void removeItem(Item value){
    _items.remove(value);
  }

  Set<String> get languages => _languages;

  void addLanguages(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _languages.addAll(value);
  }

  void removeLanguage(String value){
    _languages.remove(value);
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  void addProficiencies(Set<Proficiency> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for(int i = 0; i < value.length; i++){
      _proficiencies.add(Proficiency.copyFrom(value.elementAt(i)));
    }
  }

  void removeProficiencies(Proficiency value){
    _proficiencies.remove(value);
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  void addSkillChecks(Set<SkillCheck> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for(int i = 0; i < value.length; i++){
      _skillChecks.add(SkillCheck.copyFrom(value.elementAt(i)));
    }
  }

  void removeSkillChecks(SkillCheck value){
    _skillChecks.remove(value);
  }

  String get skill => _skill;

  set skill(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skill = value;
  }

  String get skillName => _skillName;

  set skillName(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skillName = value;
  }

  String get description => _description;

  set description(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Background &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _skillName == other._skillName &&
          _skill == other._skill &&
          _skillChecks == other._skillChecks &&
          _proficiencies == other._proficiencies &&
          _languages == other._languages &&
          _items == other._items &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _skillName.hashCode ^
      _skill.hashCode ^
      _skillChecks.hashCode ^
      _proficiencies.hashCode ^
      _languages.hashCode ^
      _items.hashCode ^
      _protected.hashCode;

}