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
    final bool twoHanded = reader.readBool();
    final bool melee = reader.readBool();
    final bool throwable = reader.readBool();
    final bool reach = reader.readBool();
    final bool special = reader.readBool();
    final bool fencing = reader.readBool();
    final int minDistance = reader.readInt();
    final int maxDistance = reader.readInt();
    return Weapon(name, description, weight, cost, notes, protected, damage, damageType, versatileDamage, heavy, twoHanded, melee, throwable, reach, special, fencing, minDistance, maxDistance);
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
    writer.writeBool(obj.twoHanded);
    writer.writeBool(obj.melee);
    writer.writeBool(obj.throwable);
    writer.writeBool(obj.reach);
    writer.writeBool(obj.special);
    writer.writeBool(obj.fencing);
    writer.writeInt(obj.minDistance);
    writer.writeInt(obj.maxDistance);
  }

}