// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 112;

  @override
  Level read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Level(
      fields[0] as int,
      (fields[1] as Map).cast<Characteristic, int>(),
      (fields[2] as Map).cast<Characteristic, int>(),
      (fields[3] as List).cast<Skill>().toSet(),
      fields[4] as int?,
      (fields[5] as List?)?.cast<Skill>().toSet(),
      (fields[6] as List).cast<String>().toSet(),
      fields[7] as int,
      (fields[8] as Map).map((dynamic k, dynamic v) => MapEntry(
          k as String?,
          (v as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String?, (v as Map).cast<int, int>())))),
      fields[9] as int?,
      fields[10] as Dice?,
    );
  }

  @override
  void write(BinaryWriter writer, Level obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj._abilityScorePoints)
      ..writeByte(1)
      ..write(obj._abilityScoreImprovement)
      ..writeByte(2)
      ..write(obj._maxAbilityScoreImprovement)
      ..writeByte(3)
      ..write(obj._skills.toList())
      ..writeByte(4)
      ..write(obj._skillChoicesCount)
      ..writeByte(5)
      ..write(obj._skillChoices?.toList())
      ..writeByte(6)
      ..write(obj._languages.toList())
      ..writeByte(7)
      ..write(obj._skillChecksCount)
      ..writeByte(8)
      ..write(obj._spellChoices)
      ..writeByte(9)
      ..write(obj._classPoints)
      ..writeByte(10)
      ..write(obj._classDice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
