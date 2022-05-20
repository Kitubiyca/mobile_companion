

import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/rest.g.dart';

@HiveType(typeId: 6)
enum Rest{

  @HiveField(0)
  short,
  @HiveField(1)
  long,
  @HiveField(2)
  both,
  @HiveField(3)
  none,

}