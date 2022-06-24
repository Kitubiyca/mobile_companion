// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DamageTypeAdapter extends TypeAdapter<DamageType> {
  @override
  final int typeId = 21;

  @override
  DamageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DamageType.bludgeoning;
      case 1:
        return DamageType.sound;
      case 2:
        return DamageType.radiant;
      case 3:
        return DamageType.acid;
      case 4:
        return DamageType.piercing;
      case 5:
        return DamageType.necrotic;
      case 6:
        return DamageType.fire;
      case 7:
        return DamageType.psychic;
      case 8:
        return DamageType.slashing;
      case 9:
        return DamageType.force;
      case 10:
        return DamageType.cold;
      case 11:
        return DamageType.electric;
      case 12:
        return DamageType.poison;
      case 13:
        return DamageType.heal;
      case 14:
        return DamageType.none;
      default:
        return DamageType.bludgeoning;
    }
  }

  @override
  void write(BinaryWriter writer, DamageType obj) {
    switch (obj) {
      case DamageType.bludgeoning:
        writer.writeByte(0);
        break;
      case DamageType.sound:
        writer.writeByte(1);
        break;
      case DamageType.radiant:
        writer.writeByte(2);
        break;
      case DamageType.acid:
        writer.writeByte(3);
        break;
      case DamageType.piercing:
        writer.writeByte(4);
        break;
      case DamageType.necrotic:
        writer.writeByte(5);
        break;
      case DamageType.fire:
        writer.writeByte(6);
        break;
      case DamageType.psychic:
        writer.writeByte(7);
        break;
      case DamageType.slashing:
        writer.writeByte(8);
        break;
      case DamageType.force:
        writer.writeByte(9);
        break;
      case DamageType.cold:
        writer.writeByte(10);
        break;
      case DamageType.electric:
        writer.writeByte(11);
        break;
      case DamageType.poison:
        writer.writeByte(12);
        break;
      case DamageType.heal:
        writer.writeByte(13);
        break;
      case DamageType.none:
        writer.writeByte(14);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DamageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
