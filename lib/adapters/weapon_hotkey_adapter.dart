import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';
import '../data/equipment/item.dart';
import '../data/equipment/weapon.dart';

class WeaponHotkeyAdapter extends TypeAdapter<WeaponHotkey>{

  @override
  WeaponHotkey read(BinaryReader reader) {
    final String name = reader.readString();
    final Weapon weapon = reader.read();
    final Characteristic characteristic = reader.read();
    final bool versatile = reader.readBool();
    final Item? ammunition = reader.read();
    return WeaponHotkey(name, weapon, characteristic, versatile, ammunition);
  }

  @override
  final int typeId = 3;

  @override
  void write(BinaryWriter writer, WeaponHotkey obj) {
    writer.writeString(obj.name);
    writer.write(obj.weapon);
    writer.write(obj.characteristic);
    writer.writeBool(obj.versatile);
    writer.write(obj.ammunition);
  }

}