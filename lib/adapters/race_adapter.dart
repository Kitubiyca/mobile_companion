import 'package:hive/hive.dart';
import '../data/character/class/class.dart';
import '../data/character/race/race.dart';
import '../data/character/race/sub_race.dart';
import '../data/characteristics/resist.dart';
import '../data/skill/proficiency.dart';
import '../data/skill/skill_check.dart';
import '../data/spell/spell.dart';

class RaceAdapter extends TypeAdapter<Race>{

  @override
  Race read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final int speed = reader.readInt();
    final int age = reader.readInt();
    final int size = reader.readInt();
    final String vision = reader.readString();
    final Map<String, int> abilityScoreImprovement = Map.castFrom(reader.readMap());
    final Set<SkillCheck> skillChecks = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> optionalProficiencies = Set.castFrom(reader.readList().toSet());
    final int startingProficienciesCount = reader.readInt();
    final Set<Proficiency> startingProficiencies = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> traits = Set.castFrom(reader.readList().toSet());
    final Resist resist = reader.read();
    final int additionalHits = reader.readInt();
    final Map<Set<Class>, int> classSpells = Map.castFrom(reader.readMap());
    final Map<int, Set<Spell>> giftedSpells = Map.castFrom(reader.readMap());
    final Set<String> languages = reader.readStringList().toSet();
    final bool usable = reader.readBool();
    final bool protected = reader.readBool();
    final List<SubRace> subRaces = List.castFrom(reader.readList());
    return Race(name, description, speed, age, size, vision, abilityScoreImprovement, skillChecks, optionalProficiencies, startingProficienciesCount, startingProficiencies, traits, resist, additionalHits, classSpells, giftedSpells, languages, usable, protected, subRaces);
  }

  @override
  final int typeId = 121;

  @override
  void write(BinaryWriter writer, Race obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.speed);
    writer.writeInt(obj.age);
    writer.writeInt(obj.size);
    writer.writeString(obj.vision);
    writer.writeMap(obj.abilityScoreImprovement);
    writer.writeList(obj.skillChecks.toList());
    writer.writeList(obj.optionalProficiencies.toList());
    writer.writeInt(obj.startingProficienciesCount);
    writer.writeList(obj.startingProficiencies.toList());
    writer.writeList(obj.traits.toList());
    writer.write(obj.resist);
    writer.writeInt(obj.additionalHits);
    writer.writeMap(obj.classSpells);
    writer.writeMap(obj.giftedSpells);
    writer.writeList(obj.languages.toList());
    writer.writeBool(obj.usable);
    writer.writeBool(obj.protected);
    writer.writeList(obj.subRaces);
  }

}