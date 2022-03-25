import 'package:dnd_companion/data/dice/dice.dart';
import 'package:hive/hive.dart';

class DiceAdapter extends TypeAdapter<Dice>{
  @override
  Dice read(BinaryReader reader) {
    final int count = reader.readInt();
    final int max = reader.readInt();
    return Dice(count, max);
  }

  @override
  final typeId = 31;

  @override
  void write(BinaryWriter writer, Dice obj) {
    writer.writeInt(obj.count);
    writer.writeInt(obj.max);
  }

}