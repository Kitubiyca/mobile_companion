import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:hive/hive.dart';
import '../data/character/class/class.dart';
import '../data/character/race/race.dart';

class ProficiencyAdapter extends TypeAdapter<Proficiency>{
  @override
  Proficiency read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final Set<Class> classes = Set.castFrom(reader.readList().toSet());
    final Set<Race> races = Set.castFrom(reader.readList().toSet());
    final bool protected = reader.readBool();
    return Proficiency(name, description, classes, races, protected);
  }

  @override
  final int typeId = 72;

  @override
  void write(BinaryWriter writer, Proficiency obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeList(obj.classes.toList());
    writer.writeList(obj.races.toList());
    writer.writeBool(obj.protected);
  }

}