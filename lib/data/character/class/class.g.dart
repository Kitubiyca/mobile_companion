// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassAdapter extends TypeAdapter<Class> {
  @override
  final int typeId = 111;

  @override
  Class read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Class(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as Dice,
      (fields[4] as List).cast<Characteristic>().toSet(),
      fields[5] as bool?,
      fields[6] as int?,
      (fields[7] as Map?)?.cast<String, int>(),
      (fields[8] as List?)?.cast<Proficiency>().toSet(),
      (fields[9] as List?)?.cast<Proficiency>().toSet(),
      fields[10] as Characteristic,
      fields[11] as String?,
      fields[12] as bool,
      fields[13] as int,
      fields[14] as SpellcasterType,
      fields[15] as int,
      (fields[16] as List).cast<Proficiency>().toSet(),
      (fields[17] as List).cast<Proficiency>().toSet(),
      (fields[18] as List).cast<SkillCheck>().toSet(),
      fields[19] as int,
      (fields[20] as List).cast<SkillCheck>().toSet(),
      fields[21] as Rest?,
      fields[22] as String?,
      fields[23] as String?,
      (fields[24] as List).cast<Level>(),
      (fields[25] as Map).cast<Item, int>(),
      fields[26] as int,
      (fields[27] as List).cast<SubClass>(),
      fields[28] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Class obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._image)
      ..writeByte(3)
      ..write(obj._hits)
      ..writeByte(4)
      ..write(obj._savingChecks.toList())
      ..writeByte(5)
      ..write(obj._multiClassingLogic)
      ..writeByte(6)
      ..write(obj._multiClassingProficienciesCount)
      ..writeByte(7)
      ..write(obj._multiClassingRequirements)
      ..writeByte(8)
      ..write(obj._multiClassingProficiencies?.toList())
      ..writeByte(9)
      ..write(obj._multiClassingProficiencyChoices?.toList())
      ..writeByte(10)
      ..write(obj._spellCastingAbility)
      ..writeByte(11)
      ..write(obj._focusItem)
      ..writeByte(12)
      ..write(obj._hasSpecialMagicTable)
      ..writeByte(13)
      ..write(obj._spellcasterStartLevel)
      ..writeByte(14)
      ..write(obj._spellcasterType)
      ..writeByte(15)
      ..write(obj._proficiencyCount)
      ..writeByte(16)
      ..write(obj._proficiencyChoices.toList())
      ..writeByte(17)
      ..write(obj._proficiencies.toList())
      ..writeByte(18)
      ..write(obj._skillChecks.toList())
      ..writeByte(19)
      ..write(obj._skillChecksCount)
      ..writeByte(20)
      ..write(obj._skillCheckChoices.toList())
      ..writeByte(21)
      ..write(obj._restType)
      ..writeByte(22)
      ..write(obj._classPointsName)
      ..writeByte(23)
      ..write(obj._classDiceName)
      ..writeByte(24)
      ..write(obj._levels)
      ..writeByte(25)
      ..write(obj._items)
      ..writeByte(26)
      ..write(obj._subClassChooseLevel)
      ..writeByte(27)
      ..write(obj._subClasses)
      ..writeByte(28)
      ..write(obj._protected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
