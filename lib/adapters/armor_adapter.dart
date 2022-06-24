import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/equipment/armor.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:hive/hive.dart';

class ArmorAdapter extends TypeAdapter<Armor>{

  @override
  Armor read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final String image = reader.readString();
    final int weight = reader.readInt();
    final double cost = reader.readDouble();
    final RareType rare = reader.read();
    final Set<Proficiency> proficiencies = Set.castFrom(reader.readList().toSet());
    final Map<Characteristic, int> additionalStats = Map.castFrom(reader.readMap());
    final Map<Characteristic, int> forcedStats = Map.castFrom(reader.readMap());
    final Set<String> notes = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    final int AC = reader.readInt();
    final Characteristic ACModifier = reader.read();
    final int maxModifier = reader.readInt();
    final bool noise = reader.readBool();
    final int requirement = reader.readInt();
    final Resist resist = reader.read();
    return Armor(name, description, image, weight, cost, rare, proficiencies, additionalStats, forcedStats, notes, protected, AC, ACModifier, maxModifier, noise, requirement, resist);
  }

  @override
  final typeId = 41;

  @override
  void write(BinaryWriter writer, Armor obj) {
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
    writer.writeInt(obj.AC);
    writer.write(obj.ACModifier);
    writer.writeInt(obj.maxModifier);
    writer.writeBool(obj.noise);
    writer.writeInt(obj.requirement);
    writer.write(obj.resist);
  }

}