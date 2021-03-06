import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/size_type.dart';
import 'package:hive/hive.dart';
import '../data/character/race.dart';
import '../data/characteristics/resist.dart';
import '../data/skill/proficiency.dart';
import '../data/skill/skill_check.dart';
import '../data/spell/spell.dart';

class RaceAdapter extends TypeAdapter<Race>{

  @override
  Race read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final String image = reader.readString();
    final int? speed = reader.read();
    final int? age = reader.read();
    final SizeType size = reader.read();
    final String? vision = reader.read();
    final Map<Characteristic, int> abilityScoreImprovement = Map.castFrom(reader.readMap());
    final Set<SkillCheck> skillChecks = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> optionalProficiencies = Set.castFrom(reader.readList().toSet());
    final int startingProficienciesCount = reader.readInt();
    final Set<Proficiency> startingProficiencies = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> traits = Set.castFrom(reader.readList().toSet());
    final Resist resist = reader.read();
    final int additionalHits = reader.readInt();
    final Map<String, Map<int, int>> classSpells = Map.castFrom(reader.readMap());
    final Map<int, Set<Spell>> giftedSpells = Map.castFrom(reader.readMap());
    final Set<String> languages = reader.readStringList().toSet();
    final List<Race> subRaces = List.castFrom(reader.readList());
    final bool protected = reader.readBool();
    return Race(name, description, image, speed, age, size, vision, abilityScoreImprovement, skillChecks, optionalProficiencies, startingProficienciesCount, startingProficiencies, traits, resist, additionalHits, classSpells, giftedSpells, languages, subRaces, protected);
  }

  @override
  final int typeId = 15;

  @override
  void write(BinaryWriter writer, Race obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.write(obj.speed);
    writer.write(obj.age);
    writer.write(obj.size);
    writer.write(obj.vision);
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
    writer.writeStringList(obj.languages.toList());
    writer.writeList(obj.subRaces);
    writer.writeBool(obj.protected);
  }

}