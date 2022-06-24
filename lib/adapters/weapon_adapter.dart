import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/weapon.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:hive/hive.dart';

class WeaponAdapter extends TypeAdapter<Weapon>{

  @override
  Weapon read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final String image = reader.readString();
    final int weight = reader.readInt();
    final double cost = reader.readDouble();
    final RareType rare= reader.read();
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final Map<Characteristic, int> additionalStats = Map.castFrom(reader.readMap());
    final Map<Characteristic, int> forcedStats = Map.castFrom(reader.readMap());
    final Set<String> notes = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    final Map<DamageType, Dice> damage = Map.castFrom(reader.readMap());
    final Map<DamageType, Dice> versatileDamage = Map.castFrom(reader.readMap());
    final Set<WeaponFeature> features = Set.castFrom(reader.readList().toSet());
    final List<int> rangedDistance = reader.readIntList();
    final List<int> throwableDistance = reader.readIntList();
    return Weapon(name, description, image, weight, cost, rare, proficiencies, additionalStats, forcedStats, notes, protected, damage, versatileDamage, features, rangedDistance, throwableDistance);
  }

  @override
  final typeId = 43;

  @override
  void write(BinaryWriter writer, Weapon obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.writeInt(obj.weight);
    writer.writeDouble(obj.cost);
    writer.write(obj.rare);
    writer.writeList(obj.proficiencies.toList());
    writer.writeMap(obj.additionalStats);
    writer.writeMap(obj.forcedStats);
    writer.writeStringList(obj.notes.toList());
    writer.writeBool(obj.protected);
    writer.writeMap(obj.damage);
    writer.writeMap(obj.versatileDamage);
    writer.writeList(obj.features.toList());
    writer.writeIntList(obj.rangedDistance);
    writer.writeIntList(obj.throwableDistance);
  }

}