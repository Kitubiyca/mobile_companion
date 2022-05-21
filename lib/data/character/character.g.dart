// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 14;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      fields[0] as String,
      (fields[1] as Map).cast<Class, int>(),
      fields[2] as Background,
      fields[3] as SubRace,
      fields[4] as String,
      fields[5] as int,
      fields[6] as int,
      fields[7] as int,
      fields[8] as int,
      fields[9] as int,
      fields[10] as int,
      (fields[11] as Map).cast<Characteristic, int>(),
      (fields[12] as Map).cast<Characteristic, int>(),
      (fields[13] as Map).cast<Characteristic, int>(),
      (fields[14] as Map).cast<Characteristic, int>(),
      fields[15] as int,
      (fields[16] as Map).map((dynamic k, dynamic v) => MapEntry(
          k as String?,
          (v as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String?, (v as Map).cast<int, int>())))),
      (fields[17] as List).cast<SkillCheck>().toSet(),
      (fields[18] as List).cast<Proficiency>().toSet(),
      (fields[19] as List).cast<Feat>().toSet(),
      (fields[20] as Map).cast<Skill, int?>(),
      (fields[21] as List).cast<Spell>().toSet(),
      (fields[22] as List).cast<Spell>().toSet(),
      (fields[23] as List).cast<Spell>().toSet(),
      (fields[24] as Map).cast<Item, int>(),
      (fields[25] as Map).cast<Item, int>(),
      (fields[26] as List).cast<WeaponHotkey>().toSet(),
      fields[27] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._characterClass)
      ..writeByte(2)
      ..write(obj._background)
      ..writeByte(3)
      ..write(obj._race)
      ..writeByte(4)
      ..write(obj._alignment)
      ..writeByte(5)
      ..write(obj._experience)
      ..writeByte(6)
      ..write(obj._maxHits)
      ..writeByte(7)
      ..write(obj._hits)
      ..writeByte(8)
      ..write(obj._additionalHits)
      ..writeByte(9)
      ..write(obj._deathRolls)
      ..writeByte(10)
      ..write(obj._lifeRolls)
      ..writeByte(11)
      ..write(obj._stats)
      ..writeByte(12)
      ..write(obj._temporaryStatsAdd)
      ..writeByte(13)
      ..write(obj._temporaryStatsForced)
      ..writeByte(14)
      ..write(obj._maxStats)
      ..writeByte(15)
      ..write(obj._additionalPoints)
      ..writeByte(16)
      ..write(obj._spellCount)
      ..writeByte(17)
      ..write(obj._skillChecks.toList())
      ..writeByte(18)
      ..write(obj._proficiencies.toList())
      ..writeByte(19)
      ..write(obj._feats.toList())
      ..writeByte(20)
      ..write(obj._knownSkills)
      ..writeByte(21)
      ..write(obj._knownSpells.toList())
      ..writeByte(22)
      ..write(obj._preparedSpells.toList())
      ..writeByte(23)
      ..write(obj._alwaysPreparedSpells.toList())
      ..writeByte(24)
      ..write(obj._inventory)
      ..writeByte(25)
      ..write(obj._equippedItems)
      ..writeByte(26)
      ..write(obj._weaponHotkeys.toList())
      ..writeByte(27)
      ..write(obj._inspiration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
