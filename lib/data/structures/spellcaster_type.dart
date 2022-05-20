

import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/spell_caster_type.g.dart';

@HiveType(typeId: 7)
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