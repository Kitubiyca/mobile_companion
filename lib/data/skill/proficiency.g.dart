// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proficiency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProficiencyAdapter extends TypeAdapter<Proficiency> {
  @override
  final int typeId = 72;

  @override
  Proficiency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Proficiency(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<Proficiency>().toSet(),
      fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Proficiency obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._mark)
      ..writeByte(3)
      ..write(obj._includes.toList())
      ..writeByte(4)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProficiencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
