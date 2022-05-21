
import 'package:hive/hive.dart';

part 'armor_type.g.dart';

@HiveType(typeId: 1)
enum ArmorType{
  @HiveField(0)
  light,
  @HiveField(1)
  medium,
  @HiveField(2)
  heavy,
  @HiveField(3)
  shield,
}