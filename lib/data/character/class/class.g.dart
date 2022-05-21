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
      fields[2] as Dice,
      fields[3] as bool?,
      fields[4] as int?,
      (fields[5] as Map?)?.cast<String, int>(),
      (fields[6] as List?)?.cast<Proficiency>().toSet(),
      (fields[7] as List?)?.cast<Proficiency>().toSet(),
      fields[8] as Characteristic,
      fields[9] as String?,
      fields[10] as bool,
      fields[11] as int,
      fields[12] as SpellcasterType,
      fields[13] as int,
      (fields[14] as List).cast<Proficiency>().toSet(),
      (fields[15] as List).cast<Proficiency>().toSet(),
      (fields[16] as List).cast<String>().toSet(),
      fields[17] as Rest?,
      fields[18] as String?,
      fields[19] as String?,
      (fields[20] as List).cast<Level>(),
      (fields[21] as Map).cast<Item, int>(),
      fields[22] as int,
      (fields[23] as List).cast<SubClass>(),
      fields[24] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Class obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._description)
      ..writeByte(2)
      ..write(obj._hits)
      ..writeByte(3)
      ..write(obj._multiClassingLogic)
      ..writeByte(4)
      ..write(obj._multiClassingProficienciesCount)
      ..writeByte(5)
      ..write(obj._multiClassingRequirements)
      ..writeByte(6)
      ..write(obj._multiClassingProficiencies?.toList())
      ..writeByte(7)
      ..write(obj._multiClassingProficiencyChoices?.toList())
      ..writeByte(8)
      ..write(obj._spellCastingAbility)
      ..writeByte(9)
      ..write(obj._focusItem)
      ..writeByte(10)
      ..write(obj._hasSpecialMagicTable)
      ..writeByte(11)
      ..write(obj._spellcasterStartLevel)
      ..writeByte(12)
      ..write(obj._spellcasterType)
      ..writeByte(13)
      ..write(obj._proficiencyCount)
      ..writeByte(14)
      ..write(obj._proficiencyChoices.toList())
      ..writeByte(15)
      ..write(obj._proficiencies.toList())
      ..writeByte(16)
      ..write(obj._savingChecks.toList())
      ..writeByte(17)
      ..write(obj._restType)
      ..writeByte(18)
      ..write(obj._classPointsName)
      ..writeByte(19)
      ..write(obj._classDiceName)
      ..writeByte(20)
      ..write(obj._levels)
      ..writeByte(21)
      ..write(obj._items)
      ..writeByte(22)
      ..write(obj._subClassChooseLevel)
      ..writeByte(23)
      ..write(obj._subClasses)
      ..writeByte(24)
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
