// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon_feature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeaponFeatureAdapter extends TypeAdapter<WeaponFeature> {
  @override
  final int typeId = 11;

  @override
  WeaponFeature read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeaponFeature.heavy;
      case 1:
        return WeaponFeature.light;
      case 2:
        return WeaponFeature.twoHanded;
      case 3:
        return WeaponFeature.reach;
      case 4:
        return WeaponFeature.special;
      case 5:
        return WeaponFeature.fencing;
      case 6:
        return WeaponFeature.reloading;
      default:
        return WeaponFeature.heavy;
    }
  }

  @override
  void write(BinaryWriter writer, WeaponFeature obj) {
    switch (obj) {
      case WeaponFeature.heavy:
        writer.writeByte(0);
        break;
      case WeaponFeature.light:
        writer.writeByte(1);
        break;
      case WeaponFeature.twoHanded:
        writer.writeByte(2);
        break;
      case WeaponFeature.reach:
        writer.writeByte(3);
        break;
      case WeaponFeature.special:
        writer.writeByte(4);
        break;
      case WeaponFeature.fencing:
        writer.writeByte(5);
        break;
      case WeaponFeature.reloading:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponFeatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
