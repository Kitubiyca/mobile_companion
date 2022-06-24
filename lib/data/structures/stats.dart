


import 'package:hive/hive.dart';

part 'stats.g.dart';

@HiveType(typeId: 10)
enum Stats {

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
  hits,
  @HiveField(7)
  maxHits,
  @HiveField(8)
  additionalHits,
  @HiveField(9)
  armorClass,
  @HiveField(10)
  proficiencyBonus,
  @HiveField(11)
  initiative,
  @HiveField(12)
  speed,

}

extension CharacteristicsExtension on Stats{

  String getText(){
    switch(this){
      case Stats.strength: return "сила";
      case Stats.dexterity: return "ловкость";
      case Stats.constitution: return "телосложение";
      case Stats.intelligence: return "интеллект";
      case Stats.wisdom: return "мудрость";
      case Stats.charisma: return "харизма";

      case Stats.hits: return "хиты";
      case Stats.maxHits: return "максимальные хиты";
      case Stats.additionalHits: return "дополнительные хиты";
      case Stats.armorClass: return "класс брони";
      case Stats.proficiencyBonus: return "бонус мастерства";
      case Stats.initiative: return "инициатива";
      case Stats.speed: return "скорость";
      default: return "ошибка";
    }
  }

}