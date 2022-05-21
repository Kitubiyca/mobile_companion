// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'armor_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArmorTypeAdapter extends TypeAdapter<ArmorType> {
  @override
  final int typeId = 1;

  @override
  ArmorType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ArmorType.light;
      case 1:
        return ArmorType.medium;
      case 2:
        return ArmorType.heavy;
      case 3:
        return ArmorType.shield;
      default:
        return ArmorType.light;
    }
  }

  @override
  void write(BinaryWriter writer, ArmorType obj) {
    switch (obj) {
      case ArmorType.light:
        writer.writeByte(0);
        break;
      case ArmorType.medium:
        writer.writeByte(1);
        break;
      case ArmorType.heavy:
        writer.writeByte(2);
        break;
      case ArmorType.shield:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArmorTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
