

import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/class_dependency.g.dart';


@HiveType(typeId: 4)
enum ClassDependency{

  @HiveField(0)
  mainClass,
  @HiveField(1)
  subClass,
  @HiveField(2)
  none,

}