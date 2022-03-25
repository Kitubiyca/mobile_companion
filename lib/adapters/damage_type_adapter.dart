import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:hive/hive.dart';

class DamageTypeAdapter extends TypeAdapter<DamageType>{
  @override
  DamageType read(BinaryReader reader) {
    bool bludgeoning = reader.readBool();
    bool sound = reader.readBool();
    bool radiant = reader.readBool();
    bool acid = reader.readBool();
    bool piercing = reader.readBool();
    bool necrotic = reader.readBool();
    bool fire = reader.readBool();
    bool psychic = reader.readBool();
    bool slashing = reader.readBool();
    bool force = reader.readBool();
    bool cold = reader.readBool();
    bool electric = reader.readBool();
    bool poison = reader.readBool();
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