import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/weapon_feature.g.part';

@HiveType(typeId: 9)
enum WeaponFeature{

  @HiveField(0)
  heavy,
  @HiveField(1)
  light,
  @HiveField(2)
  twoHanded,
  @HiveField(3)
  reach,
  @HiveField(4)
  special,
  @HiveField(5)
  fencing, // finesse
  @HiveField(6)
  reloading,

}