import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';

class SkillCheckAdapter extends TypeAdapter<SkillCheck>{

  @override
  SkillCheck read(BinaryReader reader) {
    final String name = reader.readString();
    final Characteristic code = reader.read();
    final bool protected = reader.readBool();
    return SkillCheck(name, code, protected);
  }

  @override
  final int typeId = 74;

  @override
  void write(BinaryWriter writer, SkillCheck obj) {
    writer.writeString(obj.name);
    writer.write(obj.code);
    writer.writeBool(obj.protected);
  }

}