import 'package:hive/hive.dart';
import '../data/skill/skill.dart';

class SkillAdapter extends TypeAdapter<Skill>{

  @override
  read(BinaryReader reader) {

    return Skill();
  }

  @override
  final int typeId = 63;

  @override
  void write(BinaryWriter writer, obj) {

  }

}