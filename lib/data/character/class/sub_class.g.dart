// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubClassAdapter extends TypeAdapter<SubClass> {
  @override
  final int typeId = 113;

  @override
  SubClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubClass(
      fields[0] as String,
      fields[1] as String,
      fields[2] as SpellcasterType,
      fields[3] as Characteristic,
      fields[4] as String?,
      fields[5] as Rest?,
      fields[6] as String?,
      (fields[7] as Map).cast<int, Dice>(),
      (fields[8] as Map).cast<int, SubClassLevel>(),
      fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubClass obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._spellcasterType)
      ..writeByte(3)
      ..write(obj._spellCastingAbility)
      ..writeByte(4)
      ..write(obj._subClassPointsName)
      ..writeByte(5)
      ..write(obj._restType)
      ..writeByte(6)
      ..write(obj._diceName)
      ..writeByte(7)
      ..write(obj._dice)
      ..writeByte(8)
      ..write(obj._subClassSkills)
      ..writeByte(9)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
