import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/spell/spell.dart';

class Level {

  late int _abilityScorePoints;
  late Map<String, int> _abilityScoreImprovement;
  late Map<String, int> _maxAbilityScoreImprovement;

  late Set<Skill> _skills;
  late Set<Spell> _spells;
  late Set<Spell> _cantrips;

  late int _skillCount;
  late int _cantripsOnLevel;
  late Map<int, int> _spellsOnLevel;
  late Map<int, int> _generalSpellsOnLevel;

  late Dice? _martialArts;
  late Dice? _sneakAttack;
  late int? _unarmoredMovement;
  late int? _rageDamage;
  late int? _invocations;

  late int? _classPoints;

  Level(
      this._abilityScorePoints,
      this._abilityScoreImprovement,
      this._maxAbilityScoreImprovement,
      this._skills,
      this._spells,
      this._cantrips,
      this._skillCount,
      this._cantripsOnLevel,
      this._spellsOnLevel,
      this._generalSpellsOnLevel,
      [this._martialArts,
      this._sneakAttack,
      this._unarmoredMovement,
      this._rageDamage,
      this._invocations,
      this._classPoints]);

  int? get classPoints => _classPoints;

  set classPoints(int? value) {
    _classPoints = value;
  }

  int? get invocations => _invocations;

  set invocations(int? value) {
    _invocations = value;
  }

  int? get rageDamage => _rageDamage;

  set rageDamage(int? value) {
    _rageDamage = value;
  }

  int? get unarmoredMovement => _unarmoredMovement;

  set unarmoredMovement(int? value) {
    _unarmoredMovement = value;
  }

  Dice? get sneakAttack => _sneakAttack;

  set sneakAttack(Dice? value) {
    _sneakAttack = value;
  }

  Dice? get martialArts => _martialArts;

  set martialArts(Dice? value) {
    _martialArts = value;
  }

  Map<int, int> get generalSpellsOnLevel => _generalSpellsOnLevel;

  set generalSpellsOnLevel(Map<int, int> value) {
    _generalSpellsOnLevel = value;
  }

  Map<int, int> get spellsOnLevel => _spellsOnLevel;

  set spellsOnLevel(Map<int, int> value) {
    _spellsOnLevel = value;
  }

  int get cantripsOnLevel => _cantripsOnLevel;

  set cantripsOnLevel(int value) {
    _cantripsOnLevel = value;
  }

  int get skillCount => _skillCount;

  set skillCount(int value) {
    _skillCount = value;
  }

  Set<Spell> get cantrips => _cantrips;

  set cantrips(Set<Spell> value) {
    _cantrips = value;
  }

  Set<Spell> get spells => _spells;

  set spells(Set<Spell> value) {
    _spells = value;
  }

  Set<Skill> get skills => _skills;

  set skills(Set<Skill> value) {
    _skills = value;
  }

  Map<String, int> get maxAbilityScoreImprovement =>
      _maxAbilityScoreImprovement;

  set maxAbilityScoreImprovement(Map<String, int> value) {
    _maxAbilityScoreImprovement = value;
  }

  Map<String, int> get abilityScoreImprovement => _abilityScoreImprovement;

  set abilityScoreImprovement(Map<String, int> value) {
    _abilityScoreImprovement = value;
  }

  int get abilityScorePoints => _abilityScorePoints;

  set abilityScorePoints(int value) {
    _abilityScorePoints = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level &&
          runtimeType == other.runtimeType &&
          _abilityScorePoints == other._abilityScorePoints &&
          _abilityScoreImprovement == other._abilityScoreImprovement &&
          _maxAbilityScoreImprovement == other._maxAbilityScoreImprovement &&
          _skills == other._skills &&
          _spells == other._spells &&
          _cantrips == other._cantrips &&
          _skillCount == other._skillCount &&
          _cantripsOnLevel == other._cantripsOnLevel &&
          _spellsOnLevel == other._spellsOnLevel &&
          _generalSpellsOnLevel == other._generalSpellsOnLevel &&
          _martialArts == other._martialArts &&
          _sneakAttack == other._sneakAttack &&
          _unarmoredMovement == other._unarmoredMovement &&
          _rageDamage == other._rageDamage &&
          _invocations == other._invocations &&
          _classPoints == other._classPoints;

  @override
  int get hashCode =>
      _abilityScorePoints.hashCode ^
      _abilityScoreImprovement.hashCode ^
      _maxAbilityScoreImprovement.hashCode ^
      _skills.hashCode ^
      _spells.hashCode ^
      _cantrips.hashCode ^
      _skillCount.hashCode ^
      _cantripsOnLevel.hashCode ^
      _spellsOnLevel.hashCode ^
      _generalSpellsOnLevel.hashCode ^
      _martialArts.hashCode ^
      _sneakAttack.hashCode ^
      _unarmoredMovement.hashCode ^
      _rageDamage.hashCode ^
      _invocations.hashCode ^
      _classPoints.hashCode;
}