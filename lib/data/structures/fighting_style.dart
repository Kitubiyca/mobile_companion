

import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/fighting_style.g.dart';


@HiveType(typeId: 5)
enum FightingStyle{

  @HiveField(0)
  archery,
  @HiveField(1)
  blessedWarrior,
  @HiveField(2)
  blindingFighting,
  @HiveField(3)
  defense,
  @HiveField(4)
  druidicWarrior,
  @HiveField(5)
  ducling,
  @HiveField(6)
  greatWeaponFighting,
  @HiveField(7)
  interception,
  @HiveField(8)
  protection,
  @HiveField(9)
  superiorTechnique,
  @HiveField(10)
  thrownWeaponFighting,
  @HiveField(11)
  twoWeaponFighting,
  @HiveField(12)
  unarmedFighting,

}