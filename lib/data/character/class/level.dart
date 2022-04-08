import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'class.dart';

class Level {

  Class _usedClass;
  int _abilityScorePoints;
  Map<String, int> _abilityScoreImprovement;
  Map<String, int> _maxAbilityScoreImprovement;

  Set<Skill> _skills;
  Set<Spell> _spells;
  Set<Spell> _cantrips;

  int _skillCount;
  int _cantripsOnLevel;
  Map<int, int> _spellsOnLevel;
  Map<int, int> _generalSpellsOnLevel;

  //late Dice? _martialArts;
  //late Dice? _sneakAttack;
  //late int? _unarmoredMovement;
  //late int? _rageDamage;
  //late int? _invocations;

  int? _classPoints;

  Level(
      this._usedClass,
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
      this._classPoints);

  Level.smart(
      this._usedClass,
      {int abilityScorePoints = 0,
      Map<String, int>? abilityScoreImprovement,
      Map<String, int>? maxAbilityScoreImprovement,
      Set<Skill>? skills,
      Set<Spell>? spells,
      Set<Spell>? cantrips,
      int skillCount = 0,
      int cantripsOnLevel = 0,
      Map<int, int>? spellsOnLevel,
      Map<int, int>? generalSpellsOnLevel,
      int? classPoints})
      : _abilityScorePoints = abilityScorePoints,
        _abilityScoreImprovement = abilityScoreImprovement ?? {},
        _maxAbilityScoreImprovement = maxAbilityScoreImprovement ?? {},
        _skills = skills ?? {},
        _spells = spells ?? {},
        _cantrips = cantrips ?? {},
        _skillCount = skillCount,
        _cantripsOnLevel = cantripsOnLevel,
        _spellsOnLevel = spellsOnLevel ?? {},
        _generalSpellsOnLevel = generalSpellsOnLevel ?? {},
        _classPoints = classPoints;

  int? get classPoints => _classPoints;

  set classPoints(int? value) {
    _classPoints = value;
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

  Class get usedClass => _usedClass;

  set usedClass(Class value) {
    _usedClass = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level &&
          runtimeType == other.runtimeType &&
          _usedClass == other._usedClass &&
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
          _classPoints == other._classPoints;

  @override
  int get hashCode =>
      _usedClass.hashCode ^
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
      _classPoints.hashCode;
}
