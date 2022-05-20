import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/race/sub_race.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/hotkeys/skill_hotkey.dart';
import 'package:dnd_companion/data/hotkeys/spell_hotkey.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/skill/feat.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';
import 'class/class.dart';

part 'package:dnd_companion/g_parts/character.g.dart';

@HiveType(typeId: 12)
class Character {

  //TODO реализовать постоянный эффект (например элементальный урон у чародея-дракона)
  //TODO реализовать механики ярости
  //TODO реализовать механики изменения облика
  //TODO восстановление маны после короткого отдыха (описано в скиллах)
  //TODO реализация под-подкласса?
  //TODO реализация списка эффектов (невидимость, отравление)
  //TODO защита и скорость без доспеха
  //TODO скрытная атака с уровнем
  //TODO множитель проверок характеристик
  //TODO кастомные баффы (например, избранные враги следопыта)
  //TODO спутник (зверь, питомец)
  //TODO использование костей хитов персонажа (и питомца)

  String _name;
  Map<Class, int> _characterClass;
  Background _background;
  SubRace _race;
  String _alignment;
  int _experience;

  Map<Characteristic, int> _stats; // str, dex, con, int, wis, cha
  Map<Characteristic, int> _maxStats;

  Map<Characteristic, int> _additionalPoints;

  int _freeCantrips;
  Map<int, int> _freeSpells;
  Map<int, int> _freeGeneralSpells;

  Set<SkillCheck> _skillChecks;
  Set<Proficiency> _proficiencies;
  Set<Feat> _feats;
  Map<Skill, int> _knownSkills; // skill with charges
  Set<Spell> _knownSpells;
  Map<Item, int> _inventory;

  Set<WeaponHotkey> _weaponHotkeys;
  Set<SpellHotkey> _spellHotkeys;
  Set<SkillHotkey> _skillHotkeys; // TODO check for delete

  Map<String, Dice> _damageBuff;
  Map<String, int> _constDamageBuff;
  Map<String, Dice> _universalBuff;

  bool _halfSkillCheckBonus;
  bool _fullProficiencyBonus;
  Set<SkillCheck> _doubleSkillCheckBonus;
  bool _stateIsActive;

  Set<Spell> _preparedSpells;
  Set<Spell> _alwaysPreparedSpells;

  //Set<CharacterState> _states; //TODO ярость, облик животного или древнего чемпиона (паладина)
  //CharacterState? _activeState;

  Character(
      this._name,
      this._characterClass,
      this._background,
      this._race,
      this._alignment,
      this._experience,
      this._stats,
      this._maxStats,
      this._additionalPoints,
      this._freeCantrips,
      this._freeSpells,
      this._freeGeneralSpells,
      this._skillChecks,
      this._proficiencies,
      this._feats,
      this._knownSkills,
      this._knownSpells,
      this._inventory,
      this._weaponHotkeys,
      this._spellHotkeys,
      this._skillHotkeys);

  Character.smart(
      {name = "Example name",
      Map<Class, int>? characterClass,
      Background? background,
      required SubRace race,
      String alignment = "True Neutral",
      int experience = 0,
      Map<String, int>? stats,
      Map<String, int>? maxStats,
      Map<String, int>? additionalPoints,
      int freeCantrips = 0,
      Map<int, int>? freeSpells,
      Map<int, int>? freeGeneralSpells,
      Set<SkillCheck>? skillChecks,
      Set<Proficiency>? proficiencies,
      Set<Feat>? feats,
      Set<Skill>? knownSkills,
      Set<Spell>? knownSpells,
      Map<Item, int>? inventory,
      Set<WeaponHotkey>? weaponHotkeys,
      Set<SpellHotkey>? spellHotkeys,
      Set<SkillHotkey>? skillHotkeys})
      : _name = name,
        _characterClass = characterClass ?? {},
        _background = background ?? Background.smart(),
        _race = race,
        _alignment = alignment,
        _experience = experience,
        _stats = stats ??
            <String, int>{
              "str": 10,
              "dex": 10,
              "con": 10,
              "int": 10,
              "wis": 10,
              "cha": 10
            },
        _maxStats = maxStats ??
            <String, int>{
              "str": 20,
              "dex": 20,
              "con": 20,
              "int": 20,
              "wis": 20,
              "cha": 20
            },
        _additionalPoints = additionalPoints ?? {},
        _freeCantrips = freeCantrips,
        _freeSpells = freeSpells ?? {},
        _freeGeneralSpells = freeGeneralSpells ?? {},
        _skillChecks = skillChecks ?? {},
        _proficiencies = proficiencies ?? {},
        _feats = feats ?? {},
        _knownSkills = knownSkills ?? {},
        _knownSpells = knownSpells ?? {},
        _inventory = inventory ?? {},
        _weaponHotkeys = weaponHotkeys ?? {},
        _spellHotkeys = spellHotkeys ?? {},
        _skillHotkeys = skillHotkeys ?? {};

  void addItem(Item item, int count) {
    if (inventory[item] != null) {
      inventory[item] = inventory[item]! + count;
    } else {
      inventory[item] = count;
    }
  }

  bool removeItem(Item item, int count) {
    if (inventory[item] != null) {
      if (inventory[item]! - count > 0) {
        inventory[item] = inventory[item]! - count;
        return true;
      } else if (inventory[item]! - count == 0) {
        inventory.remove(item);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  int getProficiencyBonus(){
    int ret = 0;
    for(Class obj in _characterClass.keys){
      ret += _characterClass[obj]!;
    }
    ret--;
    ret = (ret/4).floor();
    ret++;
    ret++;
    return ret;
  }

  int getStatBonus(String identifier){
    if(stats[identifier] != null){
      return ((stats[identifier]! - 10)/2).floor();
    }
    return 0;
  }

  int getInitiativeBonus(){
    int stat = getStatBonus("dex");
    return stat;
  }

  int getArmorClass(){
    int ret = 10 + getStatBonus("dex");
    return ret;
  }

//SkillCheck skillCheck = SkillCheck("Внимательность", "wis", true);

  int getSkillCheckResult(SkillCheck skillCheck, {bool fixed = false}){
    int ret = 0;
    if(fixed){
      ret += 10;
    } else {
      ret += Dice(1, 20).roll()[0];
    }
    ret += getStatBonus(skillCheck.code);
    if(_skillChecks.contains(skillCheck)){
      ret += getProficiencyBonus();
    }
    return ret;
  }

  String get alignment => _alignment;

  set alignment(String value) {
    _alignment = value;
  }

  Set<WeaponHotkey> get weaponHotkeys => _weaponHotkeys;

  set weaponHotkeys(Set<WeaponHotkey> value) {
    _weaponHotkeys = value;
  }

  Set<Spell> get knownSpells => _knownSpells;

  set knownSpells(Set<Spell> value) {
    _knownSpells = value;
  }

  Map<Item, int> get inventory => _inventory;

  set inventory(Map<Item, int> value) {
    _inventory = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  Set<Skill> get knownSkills => _knownSkills;

  set knownSkills(Set<Skill> value) {
    _knownSkills = value;
  }

  Set<Feat> get feats => _feats;

  set feats(Set<Feat> value) {
    _feats = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    _skillChecks = value;
  }

  Map<int, int> get freeGeneralSpells => _freeGeneralSpells;

  set freeGeneralSpells(Map<int, int> value) {
    _freeGeneralSpells = value;
  }

  Map<int, int> get freeSpells => _freeSpells;

  set freeSpells(Map<int, int> value) {
    _freeSpells = value;
  }

  int get freeCantrips => _freeCantrips;

  set freeCantrips(int value) {
    _freeCantrips = value;
  }

  Map<String, int> get additionalPoints => _additionalPoints;

  set additionalPoints(Map<String, int> value) {
    _additionalPoints = value;
  }

  Map<String, int> get maxStats => _maxStats;

  set maxStats(Map<String, int> value) {
    _maxStats = value;
  }

  Map<String, int> get stats => _stats;

  set stats(Map<String, int> value) {
    _stats = value;
  }

  int get experience => _experience;

  set experience(int value) {
    _experience = value;
  }

  String get Alignment => _alignment;

  set Alignment(String value) {
    _alignment = value;
  }

  SubRace get race => _race;

  set race(SubRace value) {
    _race = value;
  }

  Background get background => _background;

  set background(Background value) {
    _background = value;
  }

  Map<Class, int> get characterClass => _characterClass;

  set characterClass(Map<Class, int> value) {
    _characterClass = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Set<SkillHotkey> get skillHotkeys => _skillHotkeys;

  set skillHotkeys(Set<SkillHotkey> value) {
    _skillHotkeys = value;
  }

  Set<SpellHotkey> get spellHotkeys => _spellHotkeys;

  set spellHotkeys(Set<SpellHotkey> value) {
    _spellHotkeys = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _characterClass == other._characterClass &&
          _background == other._background &&
          _race == other._race &&
          _alignment == other._alignment &&
          _experience == other._experience &&
          _stats == other._stats &&
          _maxStats == other._maxStats &&
          _additionalPoints == other._additionalPoints &&
          _freeCantrips == other._freeCantrips &&
          _freeSpells == other._freeSpells &&
          _freeGeneralSpells == other._freeGeneralSpells &&
          _skillChecks == other._skillChecks &&
          _proficiencies == other._proficiencies &&
          _feats == other._feats &&
          _knownSkills == other._knownSkills &&
          _knownSpells == other._knownSpells &&
          _inventory == other._inventory &&
          _weaponHotkeys == other._weaponHotkeys &&
          _spellHotkeys == other._spellHotkeys &&
          _skillHotkeys == other._skillHotkeys;

  @override
  int get hashCode =>
      _name.hashCode ^
      _characterClass.hashCode ^
      _background.hashCode ^
      _race.hashCode ^
      _alignment.hashCode ^
      _experience.hashCode ^
      _stats.hashCode ^
      _maxStats.hashCode ^
      _additionalPoints.hashCode ^
      _freeCantrips.hashCode ^
      _freeSpells.hashCode ^
      _freeGeneralSpells.hashCode ^
      _skillChecks.hashCode ^
      _proficiencies.hashCode ^
      _feats.hashCode ^
      _knownSkills.hashCode ^
      _knownSpells.hashCode ^
      _inventory.hashCode ^
      _weaponHotkeys.hashCode ^
      _spellHotkeys.hashCode ^
      _skillHotkeys.hashCode;
}
