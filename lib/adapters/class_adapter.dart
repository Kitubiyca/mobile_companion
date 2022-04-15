import 'package:hive/hive.dart';
import '../data/character/class/class.dart';
import '../data/character/class/level.dart';
import '../data/character/class/sub_class.dart';
import '../data/dice/dice.dart';
import '../data/skill/proficiency.dart';

class ClassAdapter extends TypeAdapter<Class>{

  @override
  Class read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final Dice hits = reader.read();
    final bool multiClassingLogic = reader.readBool();
    final int multiClassingProficienciesCount = reader.readInt();
    final Map<String, int> multiClassingRequirements = Map.castFrom(reader.readMap());
    final Set<Proficiency> multiClassingProficiencies = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> multiClassingProficiencyChoices = Set.castFrom(reader.readList().toSet());
    final bool hasSpecialMagicTable = reader.readBool();
    final int spellcasterStart = reader.readInt();
    final int spellcasterLevel = reader.readInt();
    final int proficiencyCount = reader.readInt();
    final Set<Proficiency> proficiencyChoices = Set.castFrom(reader.readList().toSet());
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final Set<String> savingChecks = reader.readStringList().toSet();
    final String classPointsName = reader.readString();
    final List<Level> levels = List.castFrom(reader.readList());
    final int subClassChooseLevel = reader.readInt();
    final List<SubClass> subClasses = List.castFrom(reader.readList());
    final bool protected = reader.readBool();
    return Class(name, description, hits, multiClassingLogic, multiClassingProficienciesCount, multiClassingRequirements, multiClassingProficiencies, multiClassingProficiencyChoices, hasSpecialMagicTable, spellcasterStart, spellcasterLevel, proficiencyCount, proficiencyChoices, proficiencies, savingChecks, classPointsName, levels, subClassChooseLevel, subClasses, protected);
  }

  @override
  final int typeId = 111;

  @override
  void write(BinaryWriter writer, Class obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.write(obj.hits);
    writer.writeBool(obj.multiClassingLogic);
    writer.writeInt(obj.multiClassingProficienciesCount);
    writer.writeMap(obj.multiClassingRequirements);
    writer.writeList(obj.multiClassingProficiencies.toList());
    writer.writeList(obj.multiClassingProficiencyChoices.toList());
    writer.writeBool(obj.hasSpecialMagicTable);
    writer.writeInt(obj.spellcasterStart);
    writer.writeInt(obj.spellcasterLevel);
    writer.writeInt(obj.proficiencyCount);
    writer.writeList(obj.proficiencyChoices.toList());
    writer.writeList(obj.proficiencies.toList());
    writer.writeStringList(obj.savingChecks.toList());
    writer.writeString(obj.classPointsName);
    writer.writeList(obj.levels);
    writer.writeInt(obj.subClassChooseLevel);
    writer.writeList(obj.subClasses);
    writer.writeBool(obj.protected);
  }

}