
import 'package:hive/hive.dart';

part 'bonus_type.g.dart';

@HiveType(typeId: 2)
enum BonusType{

  @HiveField(0)
  universal,
  @HiveField(1)
  attack,
  @HiveField(2)
  damage,

}