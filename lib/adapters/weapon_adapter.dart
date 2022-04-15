import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:hive/hive.dart';
import '../data/dice/dice.dart';

class WeaponAdapter extends TypeAdapter<Weapon>{

  @override
  Weapon read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final int weight = reader.readInt();
    final int cost = reader.readInt();
    final Set<String> notes = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    final List<Dice> damage = List.castFrom(reader.readList());
    final DamageType damageType = reader.read();
    final List<Dice> versatileDamage = List.castFrom(reader.readList());
    final bool heavy = reader.readBool();
    final bool light = reader.readBool();
    final bool twoHanded = reader.readBool();
    final bool reach = reader.readBool();
    final bool special = reader.readBool();
    final bool fencing = reader.readBool();
    final bool reloading = reader.readBool();
    final List<int> rangedDistance = reader.readIntList();
    final List<int> throwableDistance = reader.readIntList();
    return Weapon(name, description, weight, cost, notes, protected, damage, damageType, versatileDamage, heavy, light, twoHanded, reach, special, fencing, reloading, rangedDistance, throwableDistance);
  }

  @override
  final int typeId = 41;

  @override
  void write(BinaryWriter writer, Weapon obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.cost);
    writer.writeStringList(obj.notes.toList());
    writer.writeBool(obj.protected);
    writer.writeList(obj.damage);
    writer.write(obj.damageType);
    writer.writeList(obj.versatileDamage);
    writer.writeBool(obj.heavy);
    writer.writeBool(obj.light);
    writer.writeBool(obj.twoHanded);
    writer.writeBool(obj.reach);
    writer.writeBool(obj.special);
    writer.writeBool(obj.fencing);
    writer.writeBool(obj.reloading);
    writer.writeIntList(obj.rangedDistance);
    writer.writeIntList(obj.throwableDistance);
  }

}