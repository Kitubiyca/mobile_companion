import 'package:hive/hive.dart';

part 'size_type.g.dart';

@HiveType(typeId: 8)
enum SizeType{

  @HiveField(0)
  tiny,
  @HiveField(1)
  small,
  @HiveField(2)
  medium,
  @HiveField(3)
  large,
  @HiveField(4)
  huge,
  @HiveField(5)
  gargantuan,

}

extension SizeTypeExtension on SizeType{

  String getText(){
    switch(this){
      case SizeType.tiny: return "крошечный";
      case SizeType.small: return "маленький";
      case SizeType.medium: return "средний";
      case SizeType.large: return "большой";
      case SizeType.huge: return "огромный";
      case SizeType.gargantuan: return "громадный";
      default: return "ошибка";
    }
  }

}