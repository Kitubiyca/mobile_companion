import 'package:hive/hive.dart';

part 'damage_type.g.dart';

@HiveType(typeId: 21)
enum DamageType{

  @HiveField(0)
  bludgeoning, //Дробящий
  @HiveField(1)
  sound, //Звук
  @HiveField(2)
  radiant, //Излучение
  @HiveField(3)
  acid, //Кислота
  @HiveField(4)
  piercing, //Колющий
  @HiveField(5)
  necrotic, //Некротический
  @HiveField(6)
  fire, //Огонь
  @HiveField(7)
  psychic, //Психический
  @HiveField(8)
  slashing, //Рубящий
  @HiveField(9)
  force, //Силовой
  @HiveField(10)
  cold, //Холод
  @HiveField(11)
  electric, //Электрический
  @HiveField(12)
  poison, //Яд
  @HiveField(13)
  heal, //Лечение
  @HiveField(14)
  none,

}

extension DamageTypeExtension on DamageType{

  String getText(){
    switch(this){
      case DamageType.bludgeoning: return "дробящий";
      case DamageType.sound: return "звуком";
      case DamageType.radiant: return "излучением";
      case DamageType.acid: return "кислотой";
      case DamageType.piercing: return "колющий";
      case DamageType.necrotic: return "некротический";
      case DamageType.fire: return "огнём";
      case DamageType.psychic: return "психический";
      case DamageType.slashing: return "рубящий";
      case DamageType.force: return "силой";
      case DamageType.cold: return "холодом";
      case DamageType.electric: return "электричеством";
      case DamageType.poison: return "ядом";
      case DamageType.heal: return "лечением";
      case DamageType.none: return "нет";
      default: return "ошибка";
    }
  }

}