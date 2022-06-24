import 'dart:math';

import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/race.dart';
import 'package:dnd_companion/data/characteristics/spell_slots.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/armor.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/skill/feat.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/spellcaster_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'class/class.dart';

part 'character.g.dart';

@HiveType(typeId: 14)
class Character extends HiveObject{

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
  //TODO сделать иначально экипированные предметы

  @HiveField(0)
  String _name;
  @HiveField(1)
  Map<Class, int> _characterClass;
  @HiveField(2)
  Background _background;
  @HiveField(3)
  Race _race;
  @HiveField(4)
  String _alignment; // мировоззрение
  @HiveField(5)
  int _level;
  @HiveField(6)
  int _experience;
  @HiveField(7)
  int _maxHits;
  @HiveField(8)
  int _hits;
  @HiveField(9)
  int _additionalHits;
  @HiveField(10)
  int _deathRolls;
  @HiveField(11)
  int _lifeRolls;
  @HiveField(12)
  Map<Characteristic, int> _stats; // str, dex, con, int, wis, cha
  @HiveField(13)
  Map<Characteristic, int> _temporaryStatsAdd;
  @HiveField(14)
  Map<Characteristic, int> _temporaryStatsForced;
  @HiveField(15)
  Map<Characteristic, int> _maxStats;
  @HiveField(16)
  int _additionalPoints;
  @HiveField(17)
  Map<String?, Map<String?, Map<int, int>>> _spellCount; // getting spells with restraints (class, school, level count)
  @HiveField(18)
  Set<SkillCheck> _skillChecks;
  @HiveField(19)
  Set<Proficiency> _proficiencies;
  @HiveField(20)
  Set<Feat> _feats;
  @HiveField(21)
  Map<Skill, int?> _knownSkills; // skill with charges
  @HiveField(22)
  Set<Spell> _knownSpells;
  @HiveField(23)
  Set<Spell> _preparedSpells;
  @HiveField(24)
  Set<Spell> _alwaysPreparedSpells;
  @HiveField(25)
  double _coins;
  @HiveField(26)
  Map<Item, int> _inventory;
  @HiveField(27)
  List<Item> _equippedItems;
  @HiveField(28)
  Set<WeaponHotkey> _weaponHotkeys;
  @HiveField(29)
  bool _inspiration;
  @HiveField(30)
  String _image;
  @HiveField(31)
  List<int> _spellSlots;

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
      this._level,
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
      this._coins,
      this._inventory,
      this._equippedItems,
      this._weaponHotkeys,
      this._inspiration,
      this._image,
      this._spellSlots
      );

  Character.smart({
  required String name,
  required Map<Class, int> characterClass,
  required Background background,
  required Race race,
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
  List<Item>? equippedItems,
  //Set<WeaponHotkey>? weaponHotkeys,
  //bool inspiration = false,
  String image = "",
  List<int>? spellSlots,
}) :
        _name = name,
        _characterClass = characterClass,
        _background = background,
        _race = race,
        _alignment = alignment,
        _level = 0,
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
        _coins = 0,
        _inventory = inventory ?? {},
        _equippedItems = equippedItems ?? [],
        _weaponHotkeys = {},
        _inspiration = false,
        _image = image,
        _spellSlots = spellSlots ?? [];

  Character.creator(
      String name,
      Class characterClass,
      Background background,
      Race race,
      Map<Characteristic, int> stats,
      String alignment,
      ) :
      _name = name,
      _characterClass = {},
      _background = background,
      _race = race,
      _alignment = alignment,
      _level = 1,
      _experience = 0,
      _maxHits = 0,
      _hits = 0,
      _additionalHits = 0,
      _deathRolls = 0,
      _lifeRolls = 0,
      _stats = {},
      _temporaryStatsAdd = {},
      _temporaryStatsForced = {},
      _maxStats = {Characteristic.strength: 20, Characteristic.dexterity: 20, Characteristic.constitution: 20, Characteristic.intelligence: 20, Characteristic.wisdom: 20, Characteristic.charisma: 20},
      _additionalPoints = 0,
      _spellCount = {},
      _skillChecks = {},
      _proficiencies = {},
      _feats = {},
      _knownSkills = {},
      _knownSpells = {},
      _preparedSpells = {},
      _alwaysPreparedSpells = {},
      _coins = 0,
      _inventory = {},
      _equippedItems = [],
      _weaponHotkeys = {},
      _inspiration = false,
      _image = "",
      _spellSlots = []{
    _characterClass[characterClass] = 1;
    _stats.addAll(stats);
    for(Characteristic char in _race.abilityScoreImprovement.keys){
      _stats[char] = _stats[char]! + _race.abilityScoreImprovement[char]!;
    }
    _skillChecks.addAll(characterClass.skillChecks);
    _proficiencies.addAll(characterClass.proficiencies);
    _proficiencies.addAll(race.startingProficiencies);
    _proficiencies.addAll(background.proficiencies);
    _coins = background.coins;
    _inventory.addAll(characterClass.items);
    _inventory.addAll(background.items);
    _maxHits = characterClass.hits.max + getStatBonus(Characteristic.constitution);
    _hits = _maxHits;
    _knownSkills.addAll({ for (var v in List.from(_characterClass.keys.first.levels[0].skills)) v as Skill : null });
    //TODO поменять ниже
    if(characterClass.spellcasterType != SpellcasterType.none){
      _spellSlots = List.from(SpellSlots.basicMagicTable.first);
    }
    switch(race.name){
      case "Человек": _image = "human.jpg"; break;
      case "Дварф": _image = "dwarf.jpg"; break;
      case "Горный дварф": _image = "dwarf.jpg"; break;
      case "Холмовой дварф": _image = "dwarf.jpg"; break;
    }
  }

  static Future<void> unpack(Box<Character> characters, Box<Class> classes, Box<Background> backgrounds, Box<Race> races) async {
    characters.put("lander", Character.creator("Лэндер", classes.get("fighter")!, backgrounds.get("sailor")!, races.get("human")!, {Characteristic.strength: 15, Characteristic.dexterity: 11, Characteristic.constitution: 13, Characteristic.intelligence: 12, Characteristic.wisdom: 8, Characteristic.charisma: 10}, "истинно нейтральный"));
    characters.put("dain", Character.creator("Дэин", classes.get("wizard")!, backgrounds.get("soldier")!, races.get("dwarf")!.subRaces.elementAt(0), {Characteristic.strength: 8, Characteristic.dexterity: 6, Characteristic.constitution: 10, Characteristic.intelligence: 15, Characteristic.wisdom: 14, Characteristic.charisma: 7}, "нейтральный добрый"));
  }

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

  void levelUp(){
    Skill? skill;
    try{
      skill = _characterClass.keys.first.levels[_level].skills.first;
    } catch(e) {}
    if(skill != null){
      _knownSkills[skill] = 0;
    }
    _characterClass[_characterClass.keys.first] = _characterClass.values.first + 1;
    _knownSkills.addAll({ for (var v in List.from(_characterClass.keys.first.levels[_level].skills)) v : null });
    _level++;
    fillSpellSlots();
    int newHits = _characterClass.keys.first.hits.roll().first + getStatBonus(Characteristic.constitution);
    if(newHits < 1) newHits = 1;
    _maxHits += newHits;
    regenHP();
    save();
  }

  bool useSkill(Skill skill){
    if(_knownSkills[skill] != null){
      if(_knownSkills[skill]! > 0){
        _knownSkills[skill] = _knownSkills[skill]! - 1;
        save();
        return true;
      }
    }
    return false;
  }

  void rest(){
    regenHP();
    fillSpellSlots();
    save();
  }

  void regenHP(){
    _hits = _maxHits;
    save();
  }

  @Deprecated("not working")
  void fillSkillPoints(){
    for(Skill skill in _knownSkills.keys){
      _knownSkills[skill] = 0;
      if(skill.maxCharges != null && skill.maxCharges!.isNotEmpty){
        int index = skill.maxCharges!.keys.lastWhere((element) => element <= _level);
      }
    }
  }

  void fillSpellSlots(){
    if(characterClass.keys.first.spellcasterType == SpellcasterType.full){
      _spellSlots = List.from(SpellSlots.basicMagicTable.elementAt(_level - 1));
    }
    if(characterClass.keys.first.spellcasterType == SpellcasterType.half){
      _spellSlots = List.from(SpellSlots.basicMagicTable.elementAt(((_level - 1)/2).ceil()));
    }
    if(characterClass.keys.first.spellcasterType == SpellcasterType.third){
      _spellSlots = List.from(SpellSlots.basicMagicTable.elementAt(((_level - 1)/3).ceil()));
    }
    save();
  }

  bool checkSpellSlot(int index){
    if(characterClass.keys.first.spellcasterType == SpellcasterType.full){
      return SpellSlots.basicMagicTable.elementAt(_level - 1).elementAt(index - 1) > 0;
    }
    if(characterClass.keys.first.spellcasterType == SpellcasterType.half){
      return SpellSlots.basicMagicTable.elementAt(((_level - 1)/2).ceil()).elementAt(index - 1) > 0;
    }
    if(characterClass.keys.first.spellcasterType == SpellcasterType.third){
      return SpellSlots.basicMagicTable.elementAt(((_level - 1)/3).ceil()).elementAt(index - 1) > 0;
    }
    return false;
  }

  void addItem(Item item, int count) {
    if (inventory[item] != null) {
      inventory[item] = inventory[item]! + count;
    } else {
      inventory[item] = count;
    }
    save();
  }

  bool removeItem(Item item, int count) {
    if (inventory[item] != null) {
      if (inventory[item]! - count > 0) {
        inventory[item] = inventory[item]! - count;
        save();
        return true;
      } else if (inventory[item]! - count == 0) {
        inventory.remove(item);
        save();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool equipItem(Item item){
    if(removeItem(item, 1)){
      _equippedItems.add(item);
      save();
      return true;
    } else {
      return false;
    }
  }

  bool unEquipItem(Item item){
    if(_equippedItems.remove(item)){
      addItem(item, 1);
      save();
      return true;
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

  bool checkProficiencyBonus(Characteristic characteristic){
    if(characterClass.keys.first.savingChecks.contains(characteristic)){
      return true;
    } else {
      return false;
    }
  }

  int getStatBonus(Characteristic identifier){
    if(stats[identifier] != null){
      return ((stats[identifier]! - 10)/2).floor();
    }
    return 0;
  }

  int getInitiativeBonus(){
    int stat = getStatBonus(Characteristic.dexterity);
    return stat;
  }

  int getSpeed() {
    for(Item item in _equippedItems){
      if(item is Armor && item.requirement > _stats[Characteristic.strength]!) return _race.speed! - 10;
    }
    return _race.speed!;
  }

  int getArmorClass(){
    List<Item> items = List.from(_equippedItems);
    items.removeWhere((element) => !(element is Armor));
    if(items.isEmpty) return 10 + getStatBonus(Characteristic.dexterity);
    List<Armor> armor = List.castFrom(items);
    int AC = 0;
    for(Armor item in armor){
      if(item.getType() == "Лёгкий доспех"){
        AC += item.AC + getStatBonus(Characteristic.dexterity);
        continue;
      }
      if(item.getType() == "Средний доспех"){
        AC += item.AC +
            (getStatBonus(Characteristic.dexterity) > 2
                ? 2
                : getStatBonus(Characteristic.dexterity));
        continue;
      }
      if(item.getType() == "Тяжёлый доспех"){
        AC += item.AC;
        continue;
      }
      AC += item.AC;
    }
    return (AC >= 10 + getStatBonus(Characteristic.dexterity) ? AC : 10 + getStatBonus(Characteristic.dexterity));
  }

//SkillCheck skillCheck = SkillCheck("Внимательность", "wis", true);

  int getSkillCheckResult(SkillCheck skillCheck, {bool fixed = false}){
    int ret = 0;
    if(fixed){
      ret += 10;
    } else {
      ret += Dice(1, 20, 0).roll()[0];
    }
    ret += getStatBonus(skillCheck.characteristic);
    if(_skillChecks.contains(skillCheck)){
      ret += getProficiencyBonus();
    }
    return ret;
  }

  AssetImage getImage(){
    //return const AssetImage("resources/portraits/human_test.jpg");
    if(_image == "") {
      return const AssetImage("resources/icons/question-mark.png");
    } else {
      return AssetImage("resources/portraits/" + _image);
    }
  }

  Characteristic getSpellCastingAbility(){
    for(Class cl in _characterClass.keys){
      if(cl.spellCastingAbility != Characteristic.none) return cl.spellCastingAbility;
    }
    return Characteristic.intelligence;
  }

  int getDC(){
    return getStatBonus(getSpellCastingAbility()) + getProficiencyBonus() + 8;
  }

  int getSpellAttackMod(){
    return getStatBonus(getSpellCastingAbility()) + getProficiencyBonus();
  }

  bool get inspiration => _inspiration;

  set inspiration(bool value) {
    _inspiration = value;
  }

  Set<WeaponHotkey> get weaponHotkeys => _weaponHotkeys;

  set weaponHotkeys(Set<WeaponHotkey> value) {
    _weaponHotkeys = value;
  }

  List<Item> get equippedItems => _equippedItems;

  set equippedItems(List<Item> value) {
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

  double get coins => _coins;

  set coins(double value) {
    _coins = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  List<int> get spellSlots => _spellSlots;

  set spellSlots(List<int> value) {
    _spellSlots = value;
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
          _level == other._level &&
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
          _coins == other._coins &&
          _inventory == other._inventory &&
          _equippedItems == other._equippedItems &&
          _weaponHotkeys == other._weaponHotkeys &&
          _inspiration == other._inspiration &&
          _image == other._image &&
          _spellSlots == other._spellSlots;

  @override
  int get hashCode =>
      _name.hashCode ^
      _characterClass.hashCode ^
      _background.hashCode ^
      _race.hashCode ^
      _alignment.hashCode ^
      _level.hashCode ^
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
      _coins.hashCode ^
      _inventory.hashCode ^
      _equippedItems.hashCode ^
      _weaponHotkeys.hashCode ^
      _inspiration.hashCode ^
      _image.hashCode ^
      _spellSlots.hashCode;

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
