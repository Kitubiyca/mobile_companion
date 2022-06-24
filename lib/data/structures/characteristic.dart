import 'package:hive/hive.dart';

part 'characteristic.g.dart';

@HiveType(typeId: 3)
enum Characteristic{

  @HiveField(0)
  strength,
  @HiveField(1)
  dexterity,
  @HiveField(2)
  constitution,
  @HiveField(3)
  intelligence,
  @HiveField(4)
  wisdom,
  @HiveField(5)
  charisma,
  @HiveField(6)
  none,

}

extension CharacteristicsExtension on Characteristic{

  String getText(){
    switch(this){
      case Characteristic.strength: return "сила";
      case Characteristic.dexterity: return "ловкость";
      case Characteristic.constitution: return "телосложение";
      case Characteristic.intelligence: return "интеллект";
      case Characteristic.wisdom: return "мудрость";
      case Characteristic.charisma: return "харизма";
      case Characteristic.none: return "нет";
      default: return "ошибка";
    }
  }

}