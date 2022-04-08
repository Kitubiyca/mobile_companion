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
    final Set<Item> items = Set.castFrom(reader.readList().toSet());
    final Set<String> languages = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    return Background(name, description, skillName, skill, skillChecks, proficiencies, items, languages, protected);
  }

  @override
  final int typeId = 11;

  @override
  void write(BinaryWriter writer, Background obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.skillName);
    writer.writeString(obj.skill);
    writer.writeList(obj.skillChecks.toList());
    writer.writeList(obj.proficiencies.toList());
    writer.writeList(obj.items.toList());
    writer.writeStringList(obj.languages.toList());
    writer.writeBool(obj.protected);
  }

}