import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/race/sub_race.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/skill/feat.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';
import 'class/class.dart';

part 'character.g.dart';

@HiveType(typeId: 14)
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

  @HiveField(0)
  String _name;
  @HiveField(1)
  Map<Class, int> _characterClass;
  @HiveField(2)
  Background _background;
  @HiveField(3)
  SubRace _race;
  @HiveField(4)
  String _alignment; // мировоззрение
  @HiveField(5)
  int _experience;
  @HiveField(6)
  int _maxHits;
  @HiveField(7)
  int _hits;
  @HiveField(8)
  int _additionalHits;
  @HiveField(9)
  int _deathRolls;
  @HiveField(10)
  int _lifeRolls;
  @HiveField(11)
  Map<Characteristic, int> _stats; // str, dex, con, int, wis, cha
  @HiveField(12)
  Map<Characteristic, int> _temporaryStatsAdd;
  @HiveField(13)
  Map<Characteristic, int> _temporaryStatsForced;
  @HiveField(14)
  Map<Characteristic, int> _maxStats;
  @HiveField(15)
  int _additionalPoints;
  @HiveField(16)
  Map<String?, Map<String?, Map<int, int>>> _spellCount; // getting spells with restraints (class, school, level count)
  @HiveField(17)
  Set<SkillCheck> _skillChecks;
  @HiveField(18)
  Set<Proficiency> _proficiencies;
  @HiveField(19)
  Set<Feat> _feats;
  @HiveField(20)
  Map<Skill, int?> _knownSkills; // skill with charges
  @HiveField(21)
  Set<Spell> _knownSpells;
  @HiveField(22)
  Set<Spell> _preparedSpells;
  @HiveField(23)
  Set<Spell> _alwaysPreparedSpells;
  @HiveField(24)
  Map<Item, int> _inventory;
  @HiveField(25)
  Map<Item, int> _equippedItems;
  @HiveField(26)
  Set<WeaponHotkey> _weaponHotkeys;
  @HiveField(27)
  bool _inspiration;


  //bard skill checks system
  //bool _halfSkillCheckBonus;
  //bool _fullProficiencyBonus;
  //Set<SkillCheck> _doubleSkillCheckBonus;

  //old buff system (needs rework and integration)
  //Map<String, Dice> _damageBuff;
  //Map<String, int> _constDamageBuff;
  //Map<String, Dice> _universalBuff;

  //state system
  //bool _stateIsActive;
  //Set<CharacterState> _states; //TODO ярость, облик животного или древнего чемпиона (паладина)
  //CharacterState? _activeState;

  //old spell system
  //int _freeCantrips;
  //Map<int, int> _freeSpells;
  //Map<int, int> _freeGeneralSpells;

  Character(
      this._name,
      this._characterClass,
      this._background,
      this._race,
      this._alignment,
      this._experience,
      this._maxHits,
      this._hits,
      this._additionalHits,
      this._deathRolls,
      this._lifeRolls,
      this._stats,
      this._temporaryStatsAdd,
      this._temporaryStatsForced,
      this._maxStats,
      this._additionalPoints,
      this._spellCount,
      this._skillChecks,
      this._proficiencies,
      this._feats,
      this._knownSkills,
      this._knownSpells,
      this._preparedSpells,
      this._alwaysPreparedSpells,
      this._inventory,
      this._equippedItems,
      this._weaponHotkeys,
      this._inspiration);


  Character.smart({
  required String name,
  required Map<Class, int> characterClass,
  required Background background,
  required SubRace race,
  String alignment = "",
  //int experience = 0,
  //int maxHits = 0,
  //int hits = 0,
  //int additionalHits = 0,
  //int deathRolls = 0,
  //int lifeRolls = 0,
  required Map<Characteristic, int>? stats,
  //Map<Characteristic, int>? temporaryStatsAdd,
  //Map<Characteristic, int>? temporaryStatsForced,
  //Map<Characteristic, int>? maxStats,
  int additionalPoints = 0,
  //Map<String?, Map<String?, Map<int, int>>>? spellCount,
  Set<SkillCheck>? skillChecks,
  Set<Proficiency>? proficiencies,
  //Set<Feat>? feats,
  //Map<Skill, int?>? knownSkills,
  //Set<Spell>? knownSpells,
  //Set<Spell>? preparedSpells,
  //Set<Spell>? alwaysPreparedSpells,
  Map<Item, int>? inventory,
  Map<Item, int>? equippedItems,
  //Set<WeaponHotkey>? weaponHotkeys,
  //bool inspiration = false,
}) :
        _name = name,
        _characterClass = characterClass,
        _background = background,
        _race = race,
        _alignment = alignment,
        _experience = 0,
        _maxHits = 0,
        _hits = 0,
        _additionalHits = 0,
        _deathRolls = 0,
        _lifeRolls = 0,
        _stats = stats ?? Character.generateStats(characterClass.keys.first.hits),
        _temporaryStatsAdd = {},
        _temporaryStatsForced = {},
        _maxStats = {Characteristic.strength: 20, Characteristic.dexterity: 20, Characteristic.constitution: 20, Characteristic.intelligence: 20, Characteristic.wisdom: 20, Characteristic.charisma: 20},
        _additionalPoints = additionalPoints,
        _spellCount = characterClass.keys.first.levels.first.spellChoices,
        _skillChecks = skillChecks ?? {},
        _proficiencies = proficiencies ?? {},
        _feats = {},
        _knownSkills = {},
        _knownSpells = {},
        _preparedSpells = {},
        _alwaysPreparedSpells = {},
        _inventory = inventory ?? {},
        _equippedItems = equippedItems ?? {},
        _weaponHotkeys = {},
        _inspiration = false;

  static Map<Characteristic, int> generateStats(Dice hits){
    Map<Characteristic, int> ret = {};
    ret[Characteristic.strength] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    ret[Characteristic.dexterity] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    ret[Characteristic.constitution] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    ret[Characteristic.intelligence] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    ret[Characteristic.wisdom] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    ret[Characteristic.charisma] = (([hits.roll().first, hits.roll().first, hits.roll().first, hits.roll().first]..sort())..removeAt(0)).fold(0, (previousValue, element) => previousValue + element);
    return ret;
  }

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
    ret += getStatBonus(skillCheck.characteristic.getText());
    if(_skillChecks.contains(skillCheck)){
      ret += getProficiencyBonus();
    }
    return ret;
  }

  bool get inspiration => _inspiration;

  set inspiration(bool value) {
    _inspiration = value;
  }

  Set<WeaponHotkey> get weaponHotkeys => _weaponHotkeys;

  set weaponHotkeys(Set<WeaponHotkey> value) {
    _weaponHotkeys = value;
  }

  Map<Item, int> get equippedItems => _equippedItems;

  set equippedItems(Map<Item, int> value) {
    _equippedItems = value;
  }

  Map<Item, int> get inventory => _inventory;

  set inventory(Map<Item, int> value) {
    _inventory = value;
  }

  Set<Spell> get alwaysPreparedSpells => _alwaysPreparedSpells;

  set alwaysPreparedSpells(Set<Spell> value) {
    _alwaysPreparedSpells = value;
  }

  Set<Spell> get preparedSpells => _preparedSpells;

  set preparedSpells(Set<Spell> value) {
    _preparedSpells = value;
  }

  Set<Spell> get knownSpells => _knownSpells;

  set knownSpells(Set<Spell> value) {
    _knownSpells = value;
  }

  Map<Skill, int?> get knownSkills => _knownSkills;

  set knownSkills(Map<Skill, int?> value) {
    _knownSkills = value;
  }

  Set<Feat> get feats => _feats;

  set feats(Set<Feat> value) {
    _feats = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    _skillChecks = value;
  }

  Map<String?, Map<String?, Map<int, int>>> get spellCount => _spellCount;

  set spellCount(Map<String?, Map<String?, Map<int, int>>> value) {
    _spellCount = value;
  }

  int get additionalPoints => _additionalPoints;

  set additionalPoints(int value) {
    _additionalPoints = value;
  }

  Map<Characteristic, int> get maxStats => _maxStats;

  set maxStats(Map<Characteristic, int> value) {
    _maxStats = value;
  }

  Map<Characteristic, int> get temporaryStatsForced => _temporaryStatsForced;

  set temporaryStatsForced(Map<Characteristic, int> value) {
    _temporaryStatsForced = value;
  }

  Map<Characteristic, int> get temporaryStatsAdd => _temporaryStatsAdd;

  set temporaryStatsAdd(Map<Characteristic, int> value) {
    _temporaryStatsAdd = value;
  }

  Map<Characteristic, int> get stats => _stats;

  set stats(Map<Characteristic, int> value) {
    _stats = value;
  }

  int get lifeRolls => _lifeRolls;

  set lifeRolls(int value) {
    _lifeRolls = value;
  }

  int get deathRolls => _deathRolls;

  set deathRolls(int value) {
    _deathRolls = value;
  }

  int get additionalHits => _additionalHits;

  set additionalHits(int value) {
    _additionalHits = value;
  }

  int get hits => _hits;

  set hits(int value) {
    _hits = value;
  }

  int get maxHits => _maxHits;

  set maxHits(int value) {
    _maxHits = value;
  }

  int get experience => _experience;

  set experience(int value) {
    _experience = value;
  }

  String get alignment => _alignment;

  set alignment(String value) {
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
          _maxHits == other._maxHits &&
          _hits == other._hits &&
          _additionalHits == other._additionalHits &&
          _deathRolls == other._deathRolls &&
          _lifeRolls == other._lifeRolls &&
          _stats == other._stats &&
          _temporaryStatsAdd == other._temporaryStatsAdd &&
          _temporaryStatsForced == other._temporaryStatsForced &&
          _maxStats == other._maxStats &&
          _additionalPoints == other._additionalPoints &&
          _spellCount == other._spellCount &&
          _skillChecks == other._skillChecks &&
          _proficiencies == other._proficiencies &&
          _feats == other._feats &&
          _knownSkills == other._knownSkills &&
          _knownSpells == other._knownSpells &&
          _preparedSpells == other._preparedSpells &&
          _alwaysPreparedSpells == other._alwaysPreparedSpells &&
          _inventory == other._inventory &&
          _equippedItems == other._equippedItems &&
          _weaponHotkeys == other._weaponHotkeys &&
          _inspiration == other._inspiration;

  @override
  int get hashCode =>
      _name.hashCode ^
      _characterClass.hashCode ^
      _background.hashCode ^
      _race.hashCode ^
      _alignment.hashCode ^
      _experience.hashCode ^
      _maxHits.hashCode ^
      _hits.hashCode ^
      _additionalHits.hashCode ^
      _deathRolls.hashCode ^
      _lifeRolls.hashCode ^
      _stats.hashCode ^
      _temporaryStatsAdd.hashCode ^
      _temporaryStatsForced.hashCode ^
      _maxStats.hashCode ^
      _additionalPoints.hashCode ^
      _spellCount.hashCode ^
      _skillChecks.hashCode ^
      _proficiencies.hashCode ^
      _feats.hashCode ^
      _knownSkills.hashCode ^
      _knownSpells.hashCode ^
      _preparedSpells.hashCode ^
      _alwaysPreparedSpells.hashCode ^
      _inventory.hashCode ^
      _equippedItems.hashCode ^
      _weaponHotkeys.hashCode ^
      _inspiration.hashCode;

/* Character.smart(
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
        _skillHotkeys = skillHotkeys ?? {};*/
}
