// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_class_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubClassLevelAdapter extends TypeAdapter<SubClassLevel> {
  @override
  final int typeId = 114;

  @override
  SubClassLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubClassLevel(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<Proficiency>().toSet(),
      (fields[3] as List).cast<Skill>().toSet(),
      (fields[4] as List).cast<SkillCheck>().toSet(),
      (fields[5] as List).cast<Spell>().toSet(),
      fields[6] as int?,
      (fields[7] as List?)?.cast<SkillCheck>().toSet(),
      (fields[8] as List?)?.cast<Skill>().toSet(),
      fields[9] as int?,
      (fields[10] as List?)?.cast<String>().toSet(),
      (fields[11] as Map).map((dynamic k, dynamic v) => MapEntry(
          k as String,
          (v as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as Map).cast<int, int>())))),
      fields[12] as Resist?,
      fields[13] as int?,
      (fields[14] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<Spell>().toSet())),
    );
  }

  @override
  void write(BinaryWriter writer, SubClassLevel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._proficiencies.toList())
      ..writeByte(3)
      ..write(obj._skills.toList())
      ..writeByte(4)
      ..write(obj._skillChecks.toList())
      ..writeByte(5)
      ..write(obj._spells.toList())
      ..writeByte(6)
      ..write(obj._skillCheckCount)
      ..writeByte(7)
      ..write(obj._skillCheckChoices?.toList())
      ..writeByte(8)
      ..write(obj._skillChoices?.toList())
      ..writeByte(9)
      ..write(obj._languageCount)
      ..writeByte(10)
      ..write(obj._languageChoices?.toList())
      ..writeByte(11)
      ..write(obj._spellChoices)
      ..writeByte(12)
      ..write(obj._resist)
      ..writeByte(13)
      ..write(obj._knownSpellMulticlassChoices)
      ..writeByte(14)
      ..write(obj._spellPacks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubClassLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
