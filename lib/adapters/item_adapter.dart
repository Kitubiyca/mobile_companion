import 'package:dnd_companion/data/equipment/item.dart';
import 'package:hive/hive.dart';

class ItemAdapter extends TypeAdapter<Item>{
  @override
  Item read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final int weight = reader.readInt();
    final int cost = reader.readInt();
    final Set<String> notes = Set.castFrom(reader.readList().toSet());
    final bool protected = reader.readBool();
    return Item(name, description, weight, cost, notes, protected);
  }

  @override
  final typeId = 43;

  @override
  void write(BinaryWriter writer, Item obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.cost);
    writer.writeList(obj.notes.toList());
    writer.writeBool(obj.protected);
  }

}