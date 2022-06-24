import 'package:dnd_companion/data/character/background.dart';
import 'package:hive/hive.dart';
import '../data/equipment/item.dart';
import '../data/skill/proficiency.dart';
import '../data/skill/skill_check.dart';

class BackgroundAdapter extends TypeAdapter<Background>{

  @override
  Background read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final String skillName = reader.readString();
    final String skill = reader.readString();
    final Set<SkillCheck> skillChecks = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final double coins = reader.readDouble();
    final Map<Item, int> items = Map.castFrom(reader.readMap());
    final Set<String> languages = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    return Background(name, description, skillName, skill, skillChecks, proficiencies, coins, items, languages, protected);
  }

  @override
  final int typeId = 13;

  @override
  void write(BinaryWriter writer, Background obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.skillName);
    writer.writeString(obj.skill);
    writer.writeList(obj.skillChecks.toList());
    writer.writeList(obj.proficiencies.toList());
    writer.writeDouble(obj.coins);
    writer.writeMap(obj.items);
    writer.writeStringList(obj.languages.toList());
    writer.writeBool(obj.protected);
  }

}