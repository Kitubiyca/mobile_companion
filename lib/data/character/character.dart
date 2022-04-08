import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/race/race.dart';
import 'package:dnd_companion/data/character/race/sub_race.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/hotkeys/skill_hotkey.dart';
import 'package:dnd_companion/data/hotkeys/spell_hotkey.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/skill/feat.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'class/class.dart';

class Character {
  String _name;
  Map<Class, int> _characterClass;
  Background _background;
  Race _race;
  SubRace? _subRace;
  String _alignment;
  int _experience;

  Map<String, int> _stats; // str, dex, con, int, wis, cha
  Map<String, int> _maxStats;

  Map<String, int> _additionalPoints;

  int _freeCantrips;
  Map<int, int> _freeSpells;
  Map<int, int> _freeGeneralSpells;

  Set<SkillCheck> _skillChecks;
  Set<Proficiency> _proficiencies;
  Set<Feat> _feats;
  Set<Skill> _knownSkills;
  Set<Spell> _knownSpells;
  Map<Item, int> _inventory;

  Set<WeaponHotkey> _weaponHotkeys;
  //Set<SpellHotkey> _spellHotkeys;
  //Set<SkillHotkey> _skillHotkeys;

  Character(
      this._name,
      this._characterClass,
      this._background,
      this._race,
      this._subRace,
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
      this._weaponHotkeys);

  Character.smart(
      {name = "Example name",
      Map<Class, int>? characterClass,
      Background? background,
      Race? race,
      SubRace? subRace,
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
        _characterClass = characterClass ?? <Class, int>{Class.smart(): 1},
        _background = background ?? Background.smart(),
        _race = race ?? Race.smart(),
        _subRace = subRace,
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
        _weaponHotkeys = weaponHotkeys ?? {};

  int getStatsBonus(String name){
    int? stat = _stats[name];
    if (stat == null ? true : false){return 0;}
    else{
      return ((stat - 10)/2).floor();
    }
  }
  void addItem(Item item, int count){
    if(inventory[item] != null){inventory[item] = inventory[item]! + count;}
    else{inventory[item] = count;}
  }

  bool removeItem(Item item, int count){
    if(inventory[item] != null){
      if(inventory[item]! - count > 0){
        inventory[item] = inventory[item]! - count;
        return true;
      } else if(inventory[item]! - count == 0){
        inventory.remove(item);
        return true;
      } else {
        return false;
      }
    } else {return false;}
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

  SubRace? get subRace => _subRace;

  set subRace(SubRace? value) {
    _subRace = value;
  }

  Race get race => _race;

  set race(Race value) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _characterClass == other._characterClass &&
          _background == other._background &&
          _race == other._race &&
          _subRace == other._subRace &&
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
          _weaponHotkeys == other._weaponHotkeys;

  @override
  int get hashCode =>
      _name.hashCode ^
      _characterClass.hashCode ^
      _background.hashCode ^
      _race.hashCode ^
      _subRace.hashCode ^
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
      _weaponHotkeys.hashCode;
}
