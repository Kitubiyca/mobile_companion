import 'package:hive/hive.dart';
import '../data/character/class/class.dart';
import '../data/character/class/level.dart';
import '../data/skill/skill.dart';
import '../data/spell/spell.dart';

class LevelAdapter extends TypeAdapter<Level>{

  @override
  Level read(BinaryReader reader) {
    final Class usedClass = reader.read();
    final int abilityScorePoints = reader.readInt();
    final Map<String, int> abilityScoreImprovement = Map.castFrom(reader.readMap());
    final Map<String, int> maxAbilityScoreImprovement = Map.castFrom(reader.readMap());
    final Set<Skill> skills = Set.castFrom(reader.readList().toSet());
    final Set<Spell> spells = Set.castFrom(reader.readList().toSet());
    final Set<Spell> cantrips = Set.castFrom(reader.readList().toSet());
    final int skillCount = reader.readInt();
    final int cantripsOnLevel = reader.readInt();
    final Map<int, int> spellsOnLevel = Map.castFrom(reader.readMap());
    final Map<int, int> generalSpellsOnLevel = Map.castFrom(reader.readMap());
    final int? classPoints = reader.readInt();
    return Level(usedClass, abilityScorePoints, abilityScoreImprovement, maxAbilityScoreImprovement, skills, spells, cantrips, skillCount, cantripsOnLevel, spellsOnLevel, generalSpellsOnLevel, classPoints);
  }

  @override
  final int typeId = 113;

  @override
  void write(BinaryWriter writer, Level obj) {
    writer.write(obj.usedClass);
    writer.writeInt(obj.abilityScorePoints);
    writer.writeMap(obj.abilityScoreImprovement);
    writer.writeMap(obj.maxAbilityScoreImprovement);
    writer.writeList(obj.skills.toList());
    writer.writeList(obj.spells.toList());
    writer.writeList(obj.cantrips.toList());
    writer.writeInt(obj.skillCount);
    writer.writeInt(obj.cantripsOnLevel);
    writer.writeMap(obj.spellsOnLevel);
    writer.writeMap(obj.generalSpellsOnLevel);
    writer.write(obj.classPoints);
  }

}