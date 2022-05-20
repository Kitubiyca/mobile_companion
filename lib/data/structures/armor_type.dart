
import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/armor_type.g.dart';

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