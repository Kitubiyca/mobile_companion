import 'dart:ui';
import 'package:hive/hive.dart';

part 'rare_type.g.dart';

@HiveType(typeId: 6)
enum RareType{

  @HiveField(0)
  common,
  @HiveField(1)
  uncommon,
  @HiveField(2)
  rare,
  @HiveField(3)
  epic, // very rare
  @HiveField(4)
  legendary,

}

extension RareTypeExtension on RareType{

  String getText(){
    switch(this){
      case RareType.common: return "обычное";
      case RareType.uncommon: return "необычное";
      case RareType.rare: return "редкое";
      case RareType.epic: return "очень редкое";
      case RareType.legendary: return "легендарное";
      default: return "ошибка";
    }
  }

  Color getColor(){
    switch(this){
      case RareType.common: return const Color(0xff838383);
      case RareType.uncommon: return const Color(0xff1fc219);
      case RareType.rare: return const Color(0xff4990e2);
      case RareType.epic: return const Color(0xff9810e0);
      case RareType.legendary: return const Color(0xfffea227); // artifact color - 0xffbe8972
      default: return const Color(0xff4d2b0f);
    }
  }

}