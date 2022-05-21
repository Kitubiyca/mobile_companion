// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BonusTypeAdapter extends TypeAdapter<BonusType> {
  @override
  final int typeId = 2;

  @override
  BonusType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BonusType.universal;
      case 1:
        return BonusType.attack;
      case 2:
        return BonusType.damage;
      default:
        return BonusType.universal;
    }
  }

  @override
  void write(BinaryWriter writer, BonusType obj) {
    switch (obj) {
      case BonusType.universal:
        writer.writeByte(0);
        break;
      case BonusType.attack:
        writer.writeByte(1);
        break;
      case BonusType.damage:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BonusTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
