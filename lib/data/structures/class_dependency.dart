

import 'package:hive/hive.dart';

part 'class_dependency.g.dart';


@HiveType(typeId: 4)
enum ClassDependency{

  @HiveField(0)
  mainClass,
  @HiveField(1)
  subClass,
  @HiveField(2)
  none,

}