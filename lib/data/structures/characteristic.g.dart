// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacteristicAdapter extends TypeAdapter<Characteristic> {
  @override
  final int typeId = 3;

  @override
  Characteristic read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Characteristic.strength;
      case 1:
        return Characteristic.dexterity;
      case 2:
        return Characteristic.constitution;
      case 3:
        return Characteristic.intelligence;
      case 4:
        return Characteristic.wisdom;
      case 5:
        return Characteristic.charisma;
      case 6:
        return Characteristic.none;
      default:
        return Characteristic.strength;
    }
  }

  @override
  void write(BinaryWriter writer, Characteristic obj) {
    switch (obj) {
      case Characteristic.strength:
        writer.writeByte(0);
        break;
      case Characteristic.dexterity:
        writer.writeByte(1);
        break;
      case Characteristic.constitution:
        writer.writeByte(2);
        break;
      case Characteristic.intelligence:
        writer.writeByte(3);
        break;
      case Characteristic.wisdom:
        writer.writeByte(4);
        break;
      case Characteristic.charisma:
        writer.writeByte(5);
        break;
      case Characteristic.none:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacteristicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
