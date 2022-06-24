import 'package:dnd_companion/data/structures/stats.dart';
import 'package:hive/hive.dart';
import '../data/skill/feat.dart';

class FeatAdapter extends TypeAdapter<Feat>{
  @override
  Feat read(BinaryReader reader) {
    final String name = reader.readString();
    final List<String> description = reader.readStringList();
    final String requirement = reader.readString();
    final Map<Stats, int> benefits = Map.castFrom(reader.readMap());
    final bool protected = reader.readBool();
    return Feat(name, description, requirement, benefits, protected);
  }

  @override
  final int typeId = 71;

  @override
  void write(BinaryWriter writer, Feat obj) {
    writer.writeString(obj.name);
    writer.writeStringList(obj.description);
    writer.writeString(obj.requirement);
    writer.writeMap(obj.benefits);
    writer.writeBool(obj.protected);
  }

}