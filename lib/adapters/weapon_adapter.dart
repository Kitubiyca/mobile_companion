import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:hive/hive.dart';

class WeaponAdapter extends TypeAdapter<Weapon>{

  @override
  Weapon read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final int weight = reader.readInt();
    final int cost = reader.readInt();
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final Map<Characteristic, int> additionalStats = Map.castFrom(reader.readMap());
    final Map<Characteristic, int> forcedStats = Map.castFrom(reader.readMap());
    final Set<String> notes = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    final List<Dice> damage = List.castFrom(reader.readList());
    final DamageType damageType = reader.read();
    final List<Dice> versatileDamage = List.castFrom(reader.readList());
    final Set<WeaponFeature> features = Set.castFrom(reader.readList().toSet());
    final List<int> rangedDistance = reader.readIntList();
    final List<int> throwableDistance = reader.readIntList();
    return Weapon(name, description, weight, cost, proficiencies, additionalStats, forcedStats, notes, protected, damage, damageType, versatileDamage, features, rangedDistance, throwableDistance);
  }

  @override
  final typeId = 43;

  @override
  void write(BinaryWriter writer, Weapon obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.cost);
    writer.writeList(obj.proficiencies.toList());
    writer.writeMap(obj.additionalStats);
    writer.writeMap(obj.forcedStats);
    writer.writeStringList(obj.notes.toList());
    writer.writeBool(obj.protected);
    writer.writeList(obj.damage);
    writer.write(obj.damageType);
    writer.writeList(obj.versatileDamage);
    writer.writeList(obj.features.toList());
    writer.writeIntList(obj.rangedDistance);
    writer.writeIntList(obj.throwableDistance);
  }

}