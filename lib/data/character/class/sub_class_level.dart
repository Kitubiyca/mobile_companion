import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:hive/hive.dart';

part 'sub_class_level.g.dart';

@HiveType(typeId: 114)
class SubClassLevel{

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  Set<Proficiency> _proficiencies;
  @HiveField(3)
  Set<Skill> _skills;
  @HiveField(4)
  Set<SkillCheck> _skillChecks;
  @HiveField(5)
  Set<Spell> _spells;
  @HiveField(6)
  int? _skillCheckCount; // number of skillChecks
  @HiveField(7)
  Set<SkillCheck>? _skillCheckChoices; // choice of proposed skillChecks
  @HiveField(8)
  Set<Skill>? _skillChoices; // Выбор одного умения из нескольких
  @HiveField(9)
  int? _languageCount;
  @HiveField(10)
  Set<String>? _languageChoices;
  @HiveField(11)
  Map<String, Map<String, Map<int, int>>> _spellChoices; // getting spells with restraints (class, school, level count)
  @HiveField(12)
  Resist? _resist;
  @HiveField(13)
  int? _knownSpellMulticlassChoices; // number of spells of not your class
  @HiveField(14)
  Map<String, Set<Spell>>? _spellPacks; // always prepared;

  SubClassLevel(
      this._name,
      this._description,
      this._proficiencies,
      this._skills,
      this._skillChecks,
      this._spells,
      this._skillCheckCount,
      this._skillCheckChoices,
      this._skillChoices,
      this._languageCount,
      this._languageChoices,
      this._spellChoices,
      this._resist,
      this._knownSpellMulticlassChoices,
      this._spellPacks);

  SubClassLevel.smart({
    required String name,
    String description = "",
    Set<Proficiency>? proficiencies,
    Set<Skill>? skills,
    Set<SkillCheck>? skillChecks,
    Set<Spell>? spells,
    int? skillCheckCount,
    Set<SkillCheck>? skillCheckChoices,
    Set<Skill>? skillChoices,
    int? languageCount,
    Set<String>? languageChoices,
    Map<String, Map<String, Map<int, int>>>? spellChoices,
    Resist? resist,
    int? knownSpellMulticlassChoices,
    Map<String, Set<Spell>>? spellPacks,
}) :
        _name = name,
        _description = description,
        _proficiencies = proficiencies ?? {},
        _skills = skills ?? {},
        _skillChecks = skillChecks ?? {},
        _spells = spells ?? {},
        _skillCheckCount = skillCheckCount,
        _skillCheckChoices = skillCheckChoices,
        _skillChoices = skillChoices,
        _languageCount = languageCount,
        _languageChoices = languageChoices,
        _spellChoices = spellChoices ?? {},
        _resist = resist,
        _knownSpellMulticlassChoices = knownSpellMulticlassChoices,
        _spellPacks = spellPacks;

  Map<String, Set<Spell>>? get spellPacks => _spellPacks;

  set spellPacks(Map<String, Set<Spell>>? value) {
    _spellPacks = value;
  }

  int? get knownSpellMulticlassChoices => _knownSpellMulticlassChoices;

  set knownSpellMulticlassChoices(int? value) {
    _knownSpellMulticlassChoices = value;
  }

  Resist? get resist => _resist;

  set resist(Resist? value) {
    _resist = value;
  }

  Map<String, Map<String, Map<int, int>>> get spellChoices => _spellChoices;

  set spellChoices(Map<String, Map<String, Map<int, int>>> value) {
    _spellChoices = value;
  }

  Set<String>? get languageChoices => _languageChoices;

  set languageChoices(Set<String>? value) {
    _languageChoices = value;
  }

  int? get languageCount => _languageCount;

  set languageCount(int? value) {
    _languageCount = value;
  }

  Set<Skill>? get skillChoices => _skillChoices;

  set skillChoices(Set<Skill>? value) {
    _skillChoices = value;
  }

  Set<SkillCheck>? get skillCheckChoices => _skillCheckChoices;

  set skillCheckChoices(Set<SkillCheck>? value) {
    _skillCheckChoices = value;
  }

  int? get skillCheckCount => _skillCheckCount;

  set skillCheckCount(int? value) {
    _skillCheckCount = value;
  }

  Set<Spell> get spells => _spells;

  set spells(Set<Spell> value) {
    _spells = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    _skillChecks = value;
  }

  Set<Skill> get skills => _skills;

  set skills(Set<Skill> value) {
    _skills = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
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
      other is SubClassLevel &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _proficiencies == other._proficiencies &&
          _skills == other._skills &&
          _skillChecks == other._skillChecks &&
          _spells == other._spells &&
          _skillCheckCount == other._skillCheckCount &&
          _skillCheckChoices == other._skillCheckChoices &&
          _skillChoices == other._skillChoices &&
          _languageCount == other._languageCount &&
          _languageChoices == other._languageChoices &&
          _spellChoices == other._spellChoices &&
          _resist == other._resist &&
          _knownSpellMulticlassChoices == other._knownSpellMulticlassChoices &&
          _spellPacks == other._spellPacks;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _proficiencies.hashCode ^
      _skills.hashCode ^
      _skillChecks.hashCode ^
      _spells.hashCode ^
      _skillCheckCount.hashCode ^
      _skillCheckChoices.hashCode ^
      _skillChoices.hashCode ^
      _languageCount.hashCode ^
      _languageChoices.hashCode ^
      _spellChoices.hashCode ^
      _resist.hashCode ^
      _knownSpellMulticlassChoices.hashCode ^
      _spellPacks.hashCode;

}