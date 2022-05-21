// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spellcaster_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpellcasterTypeAdapter extends TypeAdapter<SpellcasterType> {
  @override
  final int typeId = 7;

  @override
  SpellcasterType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SpellcasterType.full;
      case 1:
        return SpellcasterType.half;
      case 2:
        return SpellcasterType.third;
      case 3:
        return SpellcasterType.none;
      default:
        return SpellcasterType.full;
    }
  }

  @override
  void write(BinaryWriter writer, SpellcasterType obj) {
    switch (obj) {
      case SpellcasterType.full:
        writer.writeByte(0);
        break;
      case SpellcasterType.half:
        writer.writeByte(1);
        break;
      case SpellcasterType.third:
        writer.writeByte(2);
        break;
      case SpellcasterType.none:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellcasterTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
