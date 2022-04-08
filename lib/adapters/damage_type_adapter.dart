import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:hive/hive.dart';

class DamageTypeAdapter extends TypeAdapter<DamageType>{
  @override
  DamageType read(BinaryReader reader) {
    final bool bludgeoning = reader.readBool();
    final bool sound = reader.readBool();
    final bool radiant = reader.readBool();
    final bool acid = reader.readBool();
    final bool piercing = reader.readBool();
    final bool necrotic = reader.readBool();
    final bool fire = reader.readBool();
    final bool psychic = reader.readBool();
    final bool slashing = reader.readBool();
    final bool force = reader.readBool();
    final bool cold = reader.readBool();
    final bool electric = reader.readBool();
    final bool poison = reader.readBool();
    return DamageType(bludgeoning, sound, radiant, acid, piercing, necrotic, fire, psychic, slashing, force, cold, electric, poison);
  }

  @override
  final typeId = 21;

  @override
  void write(BinaryWriter writer, DamageType obj) {
    writer.writeBool(obj.bludgeoning);
    writer.writeBool(obj.sound);
    writer.writeBool(obj.radiant);
    writer.writeBool(obj.acid);
    writer.writeBool(obj.piercing);
    writer.writeBool(obj.necrotic);
    writer.writeBool(obj.fire);
    writer.writeBool(obj.psychic);
    writer.writeBool(obj.slashing);
    writer.writeBool(obj.force);
    writer.writeBool(obj.frost);
    writer.writeBool(obj.electric);
    writer.writeBool(obj.poison);
  }

}