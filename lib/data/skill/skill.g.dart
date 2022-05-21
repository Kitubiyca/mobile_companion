// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkillAdapter extends TypeAdapter<Skill> {
  @override
  final int typeId = 73;

  @override
  Skill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Skill(
      fields[0] as String,
      fields[1] as String,
      fields[2] as ClassDependency?,
      fields[3] as int?,
      (fields[4] as Map?)?.cast<int, int>(),
      fields[5] as Characteristic?,
      fields[6] as Rest?,
      (fields[7] as Map?)?.cast<int, Dice>(),
      (fields[8] as Map?)?.cast<int, int>(),
      fields[9] as bool,
      fields[10] as DamageType?,
      fields[11] as bool,
      fields[12] as bool,
      (fields[13] as List?)?.cast<Characteristic>().toSet(),
      fields[14] as int?,
      fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Skill obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._consumedPointsDependency)
      ..writeByte(3)
      ..write(obj._consumedPointsCount)
      ..writeByte(4)
      ..write(obj._maxCharges)
      ..writeByte(5)
      ..write(obj._maxChargesFromCharacteristic)
      ..writeByte(6)
      ..write(obj._rechargeRequirement)
      ..writeByte(7)
      ..write(obj._diceImpact)
      ..writeByte(8)
      ..write(obj._constImpact)
      ..writeByte(9)
      ..write(obj._addClassLevel)
      ..writeByte(10)
      ..write(obj._damageType)
      ..writeByte(11)
      ..write(obj._castDifficulty)
      ..writeByte(12)
      ..write(obj._attack)
      ..writeByte(13)
      ..write(obj._characteristics?.toList())
      ..writeByte(14)
      ..write(obj._levelMultiplier)
      ..writeByte(15)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
