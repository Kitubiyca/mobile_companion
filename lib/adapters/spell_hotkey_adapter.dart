import 'package:dnd_companion/data/hotkeys/spell_hotkey.dart';
import 'package:hive/hive.dart';

class SpellHotkeyAdapter extends TypeAdapter<SpellHotkey>{

  @override
  read(BinaryReader reader) {

    return SpellHotkey();
  }

  @override
  final int typeId = 2;

  @override
  void write(BinaryWriter writer, obj) {

  }

}