// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpellAdapter extends TypeAdapter<Spell> {
  @override
  final int typeId = 81;

  @override
  Spell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spell(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      (fields[4] as List).cast<String>(),
      fields[5] as int,
      fields[6] as bool,
      fields[7] as bool,
      (fields[8] as Map).cast<Item, int>(),
      fields[9] as bool,
      fields[10] as String,
      fields[11] as bool,
      fields[12] as bool,
      fields[13] as int,
      fields[14] as String,
      fields[15] as bool,
      fields[16] as DamageType,
      (fields[17] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as List).cast<Dice>())),
      fields[18] as int,
      fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Spell obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._level)
      ..writeByte(2)
      ..write(obj._school)
      ..writeByte(3)
      ..write(obj._description)
      ..writeByte(4)
      ..write(obj._higherDescription)
      ..writeByte(5)
      ..write(obj._range)
      ..writeByte(6)
      ..write(obj._verbal)
      ..writeByte(7)
      ..write(obj._somatic)
      ..writeByte(8)
      ..write(obj._materials)
      ..writeByte(9)
      ..write(obj._ritual)
      ..writeByte(10)
      ..write(obj._duration)
      ..writeByte(11)
      ..write(obj._concentration)
      ..writeByte(12)
      ..write(obj._bonus)
      ..writeByte(13)
      ..write(obj._castingTime)
      ..writeByte(14)
      ..write(obj._savingModifier)
      ..writeByte(15)
      ..write(obj._armorPenetration)
      ..writeByte(16)
      ..write(obj._damageType)
      ..writeByte(17)
      ..write(obj._impact)
      ..writeByte(18)
      ..write(obj._constImpact)
      ..writeByte(19)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
