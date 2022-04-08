import 'package:hive/hive.dart';
import '../data/characteristics/resist.dart';

class ResistAdapter extends TypeAdapter<Resist>{

  @override
  Resist read(BinaryReader reader) {
    final int bludgeoning = reader.readInt();
    final int sound = reader.readInt();
    final int radiant = reader.readInt();
    final int acid = reader.readInt();
    final int piercing = reader.readInt();
    final int necrotic = reader.readInt();
    final int fire = reader.readInt();
    final int psychic = reader.readInt();
    final int slashing = reader.readInt();
    final int force = reader.readInt();
    final int cold = reader.readInt();
    final int electric = reader.readInt();
    final int poison = reader.readInt();
    return Resist(bludgeoning, sound, radiant, acid, piercing, necrotic, fire, psychic, slashing, force, cold, electric, poison);
  }

  @override
  final int  typeId = 22;

  @override
  void write(BinaryWriter writer, Resist obj) {
    writer.writeInt(obj.bludgeoning);
    writer.writeInt(obj.sound);
    writer.writeInt(obj.radiant);
    writer.writeInt(obj.acid);
    writer.writeInt(obj.piercing);
    writer.writeInt(obj.necrotic);
    writer.writeInt(obj.fire);
    writer.writeInt(obj.psychic);
    writer.writeInt(obj.slashing);
    writer.writeInt(obj.force);
    writer.writeInt(obj.cold);
    writer.writeInt(obj.electric);
    writer.writeInt(obj.poison);
  }

}