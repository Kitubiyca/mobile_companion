import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:hive/hive.dart';

class ProficiencyAdapter extends TypeAdapter<Proficiency>{
  @override
  Proficiency read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final bool protected = reader.readBool();
    return Proficiency(name, description, protected);
  }

  @override
  final int typeId = 72;

  @override
  void write(BinaryWriter writer, Proficiency obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeBool(obj.protected);
  }

}