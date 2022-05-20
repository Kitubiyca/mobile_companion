
import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/bonus_type.g.dart';

@HiveType(typeId: 2)
enum BonusType{

  @HiveField(0)
  universal,
  @HiveField(1)
  attack,
  @HiveField(2)
  damage,

}