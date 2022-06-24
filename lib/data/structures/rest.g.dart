// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestAdapter extends TypeAdapter<Rest> {
  @override
  final int typeId = 7;

  @override
  Rest read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Rest.short;
      case 1:
        return Rest.long;
      case 2:
        return Rest.both;
      case 3:
        return Rest.none;
      default:
        return Rest.short;
    }
  }

  @override
  void write(BinaryWriter writer, Rest obj) {
    switch (obj) {
      case Rest.short:
        writer.writeByte(0);
        break;
      case Rest.long:
        writer.writeByte(1);
        break;
      case Rest.both:
        writer.writeByte(2);
        break;
      case Rest.none:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
