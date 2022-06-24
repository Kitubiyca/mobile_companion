// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeTypeAdapter extends TypeAdapter<SizeType> {
  @override
  final int typeId = 8;

  @override
  SizeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SizeType.tiny;
      case 1:
        return SizeType.small;
      case 2:
        return SizeType.medium;
      case 3:
        return SizeType.large;
      case 4:
        return SizeType.huge;
      case 5:
        return SizeType.gargantuan;
      default:
        return SizeType.tiny;
    }
  }

  @override
  void write(BinaryWriter writer, SizeType obj) {
    switch (obj) {
      case SizeType.tiny:
        writer.writeByte(0);
        break;
      case SizeType.small:
        writer.writeByte(1);
        break;
      case SizeType.medium:
        writer.writeByte(2);
        break;
      case SizeType.large:
        writer.writeByte(3);
        break;
      case SizeType.huge:
        writer.writeByte(4);
        break;
      case SizeType.gargantuan:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
