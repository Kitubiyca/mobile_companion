import 'package:hive/hive.dart';

part 'rest.g.dart';

@HiveType(typeId: 7)
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