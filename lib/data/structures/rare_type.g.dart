// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rare_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RareTypeAdapter extends TypeAdapter<RareType> {
  @override
  final int typeId = 6;

  @override
  RareType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RareType.common;
      case 1:
        return RareType.uncommon;
      case 2:
        return RareType.rare;
      case 3:
        return RareType.epic;
      case 4:
        return RareType.legendary;
      default:
        return RareType.common;
    }
  }

  @override
  void write(BinaryWriter writer, RareType obj) {
    switch (obj) {
      case RareType.common:
        writer.writeByte(0);
        break;
      case RareType.uncommon:
        writer.writeByte(1);
        break;
      case RareType.rare:
        writer.writeByte(2);
        break;
      case RareType.epic:
        writer.writeByte(3);
        break;
      case RareType.legendary:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RareTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
