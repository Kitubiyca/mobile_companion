import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';

part 'level.g.dart';

@HiveType(typeId: 112)
class Level {
  @HiveField(0)
  int _abilityScorePoints;
  @HiveField(1)
  Map<Characteristic, int> _abilityScoreImprovement;
  @HiveField(2)
  Map<Characteristic, int> _maxAbilityScoreImprovement;
  @HiveField(3)
  Set<Skill> _skills;
  @HiveField(4)
  int? _skillChoicesCount;
  @HiveField(5)
  Set<Skill>? _skillChoices;
  @HiveField(6)
  Set<String> _languages;
  @HiveField(7)
  int _skillChecksCount;
  @HiveField(8)
  Map<String?, Map<String?, Map<int, int>>>
      _spellChoices; // getting spells with restraints (class, school, level count)
  @HiveField(9)
  int? _classPoints;
  @HiveField(10)
  Dice? _classDice;

  //Set<Spell> _spells;
  //Set<Spell> _cantrips;

  //int _cantripsOnLevel;
  //Map<int, int> _spellsOnLevel;
  //Map<int, int> _generalSpellsOnLevel;

  //late Dice? _martialArts;
  //late Dice? _sneakAttack;
  //late int? _unarmoredMovement;
  //late int? _rageDamage;
  //late int? _invocations;

  Level(
      this._abilityScorePoints,
      this._abilityScoreImprovement,
      this._maxAbilityScoreImprovement,
      this._skills,
      this._skillChoicesCount,
      this._skillChoices,
      this._languages,
      this._skillChecksCount,
      this._spellChoices,
      this._classPoints,
      this._classDice);

  Level.smart({
    int abilityScorePoints = 0,
    Map<Characteristic, int>? abilityScoreImprovement,
    Map<Characteristic, int>? maxAbilityScoreImprovement,
    Set<Skill>? skills,
    int? skillChoicesCount,
    Set<Skill>? skillChoices,
    Set<String>? languages,
    int skillChecksCount = 0,
    Map<String, Map<String, Map<int, int>>>? spellChoices,
    int? classPoints,
    Dice? classDice,
  })  : _abilityScorePoints = abilityScorePoints,
        _abilityScoreImprovement = abilityScoreImprovement ?? {},
        _maxAbilityScoreImprovement = maxAbilityScoreImprovement ?? {},
        _skills = skills ?? {},
        _skillChoicesCount = skillChoicesCount,
        _skillChoices = skillChoices,
        _languages = languages ?? {},
        _skillChecksCount = skillChecksCount,
        _spellChoices = spellChoices ?? {},
        _classPoints = classPoints,
        _classDice = classDice;

  Dice? get classDice => _classDice;

  set classDice(Dice? value) {
    _classDice = value;
  }

  int? get classPoints => _classPoints;

  set classPoints(int? value) {
    _classPoints = value;
  }

  Map<String?, Map<String?, Map<int, int>>> get spellChoices => _spellChoices;

  set spellChoices(Map<String?, Map<String?, Map<int, int>>> value) {
    _spellChoices = value;
  }

  int get skillChecksCount => _skillChecksCount;

  set skillChecksCount(int value) {
    _skillChecksCount = value;
  }

  Set<String> get languages => _languages;

  set languages(Set<String> value) {
    _languages = value;
  }

  Set<Skill>? get skillChoices => _skillChoices;

  set skillChoices(Set<Skill>? value) {
    _skillChoices = value;
  }

  int? get skillChoicesCount => _skillChoicesCount;

  set skillChoicesCount(int? value) {
    _skillChoicesCount = value;
  }

  Set<Skill> get skills => _skills;

  set skills(Set<Skill> value) {
    _skills = value;
  }

  Map<Characteristic, int> get maxAbilityScoreImprovement =>
      _maxAbilityScoreImprovement;

  set maxAbilityScoreImprovement(Map<Characteristic, int> value) {
    _maxAbilityScoreImprovement = value;
  }

  Map<Characteristic, int> get abilityScoreImprovement =>
      _abilityScoreImprovement;

  set abilityScoreImprovement(Map<Characteristic, int> value) {
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
          _skillChoicesCount == other._skillChoicesCount &&
          _skillChoices == other._skillChoices &&
          _languages == other._languages &&
          _skillChecksCount == other._skillChecksCount &&
          _spellChoices == other._spellChoices &&
          _classPoints == other._classPoints &&
          _classDice == other._classDice;

  @override
  int get hashCode =>
      _abilityScorePoints.hashCode ^
      _abilityScoreImprovement.hashCode ^
      _maxAbilityScoreImprovement.hashCode ^
      _skills.hashCode ^
      _skillChoicesCount.hashCode ^
      _skillChoices.hashCode ^
      _languages.hashCode ^
      _skillChecksCount.hashCode ^
      _spellChoices.hashCode ^
      _classPoints.hashCode ^
      _classDice.hashCode;
}
