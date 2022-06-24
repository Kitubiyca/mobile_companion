import 'package:hive/hive.dart';

part 'spellcaster_type.g.dart';

@HiveType(typeId: 9)
enum SpellcasterType{
  @HiveField(0)
  full,
  @HiveField(1)
  half,
  @HiveField(2)
  third,
  @HiveField(3)
  none,
}