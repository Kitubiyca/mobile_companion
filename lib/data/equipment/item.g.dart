// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 42;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int,
      (fields[4] as List).cast<Proficiency>().toSet(),
      fields[5] as bool,
      (fields[6] as Map).cast<Characteristic, int>(),
      (fields[7] as Map).cast<Characteristic, int>(),
      (fields[8] as List).cast<String>().toSet(),
      fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._weight)
      ..writeByte(3)
      ..write(obj._cost)
      ..writeByte(4)
      ..write(obj._proficiencies.toList())
      ..writeByte(5)
      ..write(obj._equipment)
      ..writeByte(6)
      ..write(obj._additionalStats)
      ..writeByte(7)
      ..write(obj._forcedStats)
      ..writeByte(8)
      ..write(obj._notes.toList())
      ..writeByte(9)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
