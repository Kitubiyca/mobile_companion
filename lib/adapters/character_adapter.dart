import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/hotkeys/skill_hotkey.dart';
import 'package:dnd_companion/data/hotkeys/spell_hotkey.dart';
import 'package:hive/hive.dart';
import '../data/character/background.dart';
import '../data/character/class/class.dart';
import '../data/character/race/race.dart';
import '../data/character/race/sub_race.dart';
import '../data/equipment/item.dart';
import '../data/hotkeys/weapon_hotkey.dart';
import '../data/skill/feat.dart';
import '../data/skill/proficiency.dart';
import '../data/skill/skill.dart';
import '../data/skill/skill_check.dart';
import '../data/spell/spell.dart';

class CharacterAdapter extends TypeAdapter<Character>{

  @override
  Character read(BinaryReader reader) {
    final String name = reader.readString();
    final Map<Class, int> characterClass = Map.castFrom(reader.readMap());
    final Background background = reader.read();
    final SubRace race = reader.read();
    final String alignment = reader.readString();
    final int experience = reader.readInt();
    final Map<String, int> stats = Map.castFrom(reader.readMap());
    final Map<String, int> maxStats = Map.castFrom(reader.readMap());
    final Map<String, int> additionalPoints = Map.castFrom(reader.readMap());
    final int freeCantrips = reader.readInt();
    final Map<int, int> freeSpells = Map.castFrom(reader.readMap());
    final Map<int, int> freeGeneralSpells = Map.castFrom(reader.readMap());
    final Set<SkillCheck> skillChecks = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final Set<Feat> feats = Set.castFrom(reader.readList().toSet());
    final Set<Skill> knownSkills = Set.castFrom(reader.readList().toSet());
    final Set<Spell> knownSpells = Set.castFrom(reader.readList().toSet());
    final Map<Item, int> inventory = Map.castFrom(reader.readMap());
    final Set<WeaponHotkey> weaponHotkeys = Set.castFrom(reader.readList().toSet());
    final Set<SpellHotkey> spellHotkeys = Set.castFrom(reader.readList().toSet());
    final Set<SkillHotkey> skillHotkeys = Set.castFrom(reader.readList().toSet());
    return Character(name, characterClass, background, race, alignment, experience, stats, maxStats, additionalPoints, freeCantrips, freeSpells, freeGeneralSpells, skillChecks, proficiencies, feats, knownSkills, knownSpells, inventory, weaponHotkeys, spellHotkeys, skillHotkeys);
  }

  @override
  final int typeId = 12;

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeString(obj.name);
    writer.writeMap(obj.characterClass);
    writer.write(obj.background);
    writer.write(obj.race);
    writer.writeString(obj.alignment);
    writer.writeInt(obj.experience);
    writer.writeMap(obj.stats);
    writer.writeMap(obj.maxStats);
    writer.writeMap(obj.additionalPoints);
    writer.writeInt(obj.freeCantrips);
    writer.writeMap(obj.freeSpells);
    writer.writeMap(obj.freeGeneralSpells);
    writer.writeList(obj.skillChecks.toList());
    writer.writeList(obj.proficiencies.toList());
    writer.writeList(obj.feats.toList());
    writer.writeList(obj.knownSkills.toList());
    writer.writeList(obj.knownSpells.toList());
    writer.writeMap(obj.inventory);
    writer.writeList(obj.weaponHotkeys.toList());
    writer.writeList(obj.spellHotkeys.toList());
    writer.writeList(obj.skillHotkeys.toList());
  }

}