// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatsAdapter extends TypeAdapter<Stats> {
  @override
  final int typeId = 8;

  @override
  Stats read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Stats.strength;
      case 1:
        return Stats.dexterity;
      case 2:
        return Stats.constitution;
      case 3:
        return Stats.intelligence;
      case 4:
        return Stats.wisdom;
      case 5:
        return Stats.charisma;
      case 6:
        return Stats.hits;
      case 7:
        return Stats.maxHits;
      case 8:
        return Stats.additionalHits;
      case 9:
        return Stats.armorClass;
      case 10:
        return Stats.proficiencyBonus;
      case 11:
        return Stats.initiative;
      case 12:
        return Stats.speed;
      default:
        return Stats.strength;
    }
  }

  @override
  void write(BinaryWriter writer, Stats obj) {
    switch (obj) {
      case Stats.strength:
        writer.writeByte(0);
        break;
      case Stats.dexterity:
        writer.writeByte(1);
        break;
      case Stats.constitution:
        writer.writeByte(2);
        break;
      case Stats.intelligence:
        writer.writeByte(3);
        break;
      case Stats.wisdom:
        writer.writeByte(4);
        break;
      case Stats.charisma:
        writer.writeByte(5);
        break;
      case Stats.hits:
        writer.writeByte(6);
        break;
      case Stats.maxHits:
        writer.writeByte(7);
        break;
      case Stats.additionalHits:
        writer.writeByte(8);
        break;
      case Stats.armorClass:
        writer.writeByte(9);
        break;
      case Stats.proficiencyBonus:
        writer.writeByte(10);
        break;
      case Stats.initiative:
        writer.writeByte(11);
        break;
      case Stats.speed:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
