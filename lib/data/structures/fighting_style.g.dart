// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fighting_style.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FightingStyleAdapter extends TypeAdapter<FightingStyle> {
  @override
  final int typeId = 5;

  @override
  FightingStyle read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FightingStyle.archery;
      case 1:
        return FightingStyle.blessedWarrior;
      case 2:
        return FightingStyle.blindingFighting;
      case 3:
        return FightingStyle.defense;
      case 4:
        return FightingStyle.druidicWarrior;
      case 5:
        return FightingStyle.ducling;
      case 6:
        return FightingStyle.greatWeaponFighting;
      case 7:
        return FightingStyle.interception;
      case 8:
        return FightingStyle.protection;
      case 9:
        return FightingStyle.superiorTechnique;
      case 10:
        return FightingStyle.thrownWeaponFighting;
      case 11:
        return FightingStyle.twoWeaponFighting;
      case 12:
        return FightingStyle.unarmedFighting;
      default:
        return FightingStyle.archery;
    }
  }

  @override
  void write(BinaryWriter writer, FightingStyle obj) {
    switch (obj) {
      case FightingStyle.archery:
        writer.writeByte(0);
        break;
      case FightingStyle.blessedWarrior:
        writer.writeByte(1);
        break;
      case FightingStyle.blindingFighting:
        writer.writeByte(2);
        break;
      case FightingStyle.defense:
        writer.writeByte(3);
        break;
      case FightingStyle.druidicWarrior:
        writer.writeByte(4);
        break;
      case FightingStyle.ducling:
        writer.writeByte(5);
        break;
      case FightingStyle.greatWeaponFighting:
        writer.writeByte(6);
        break;
      case FightingStyle.interception:
        writer.writeByte(7);
        break;
      case FightingStyle.protection:
        writer.writeByte(8);
        break;
      case FightingStyle.superiorTechnique:
        writer.writeByte(9);
        break;
      case FightingStyle.thrownWeaponFighting:
        writer.writeByte(10);
        break;
      case FightingStyle.twoWeaponFighting:
        writer.writeByte(11);
        break;
      case FightingStyle.unarmedFighting:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FightingStyleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
