import 'package:hive/hive.dart';

part 'weapon_feature.g.dart';

@HiveType(typeId: 9)
enum WeaponFeature{

  @HiveField(0)
  heavy, // disadvantage for small creatures
  @HiveField(1)
  light, // two weapons
  @HiveField(2)
  twoHanded, // one weapon in two hands
  @HiveField(3)
  reach, // +5 ft. to melee range
  @HiveField(4)
  special, // has special rules
  @HiveField(5)
  fencing, // finesse // uses str or dex for attack and damage roll
  @HiveField(6)
  reloading, // only one attack at turn // needs to be reloaded

}