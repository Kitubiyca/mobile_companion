import 'package:hive/hive.dart';
import '../data/hotkeys/skill_hotkey.dart';

class SkillHotkeyAdapter extends TypeAdapter<SkillHotkey>{

  @override
  read(BinaryReader reader) {

    return SkillHotkey();
  }

  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, obj) {

  }

}