import 'package:hive/hive.dart';
import '../data/characteristics/resist.dart';
import '../data/equipment/armor.dart';

class ArmorAdapter extends TypeAdapter<Armor>{

  @override
  Armor read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final int weight = reader.readInt();
    final int cost = reader.readInt();
    final Set<String> notes = reader.readStringList().toSet();
    final bool protected = reader.readBool();
    final String type = reader.readString();
    final int AC = reader.readInt();
    final String ACModifier = reader.readString();
    final int maxModifier = reader.readInt();
    final bool noise = reader.readBool();
    final int requirement = reader.readInt();
    final Resist resist = reader.read();
    return Armor(name, description, weight, cost, notes, protected, type, AC, ACModifier, maxModifier, noise, requirement, resist);
  }

  @override
  final int typeId = 42;

  @override
  void write(BinaryWriter writer, Armor obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.cost);
    writer.writeStringList(obj.notes.toList());
    writer.writeBool(obj.protected);
    writer.writeString(obj.type);
    writer.writeInt(obj.AC);
    writer.writeString(obj.ACModifier);
    writer.writeInt(obj.maxModifier);
    writer.writeBool(obj.noise);
    writer.writeInt(obj.requirement);
    writer.write(obj.resist);
  }

}