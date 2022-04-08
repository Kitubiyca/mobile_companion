import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:hive/hive.dart';

class SkillCheckAdapter extends TypeAdapter<SkillCheck>{

  @override
  SkillCheck read(BinaryReader reader) {
    final String name = reader.readString();
    final String code = reader.readString();
    final bool protected = reader.readBool();
    return SkillCheck(name, code, protected);
  }

  @override
  final int typeId = 74;

  @override
  void write(BinaryWriter writer, SkillCheck obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.code);
    writer.writeBool(obj.protected);
  }

}