import 'package:dnd_companion/data/characteristics/resist.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:hive/hive.dart';
import 'item.dart';

class Armor extends Item { //TODO проверить и поменять тяжелый средний и лёгкий доспех на бонусы

  int _AC;
  Characteristic _ACModifier;
  int _maxModifier;
  bool _noise;
  int _requirement;
  Resist _resist;

  Armor(
      String name,
      String description,
      String image,
      int weight,
      double cost,
      RareType rare,
      Set<Proficiency> proficiencies,
      Map<Characteristic, int> additionalStats,
      Map<Characteristic, int> forcedStats,
      Set<String> notes,
      bool protected,
      this._AC,
      this._ACModifier,
      this._maxModifier,
      this._noise,
      this._requirement,
      this._resist)
      : super(name, description, image, weight, cost, rare, proficiencies, true, additionalStats, forcedStats, notes, protected);

  Armor.smart({
    required String name,
    String description = "",
    String image = "question-mark.png",
    int weight = 0,
    double cost = 0,
    RareType? rare,
    Set<Proficiency>? proficiencies,
    Map<Characteristic, int>? additionalStats,
    Map<Characteristic, int>? forcedStats,
    Set<String>? notes,
    bool protected = false,
    int AC = 0,
    Characteristic ACModifier = Characteristic.none,
    int maxModifier = 0,
    bool noise = false,
    int requirement = 0,
    Resist? resist,
  })  : _AC = AC,
        _ACModifier = ACModifier,
        _maxModifier = maxModifier,
        _noise = noise,
        _requirement = requirement,
        _resist = resist ?? Resist.empty(),
        super(name, description, image, weight, double.parse(cost.toStringAsPrecision(2)), rare ?? RareType.common, proficiencies ?? {}, true, additionalStats ?? {}, forcedStats ?? {}, notes ?? {}, protected);

  //Armor.copyFrom(Armor object) : super(object.name, object.description, object.weight, object.cost, {}, false){
  //  addNotes(object.notes);
  //  _type = object.type;
  //  _AC = object.AC;
  //  _requirement = object.requirement;
  //  _resist = Resist.copyFrom(object.resist);
  //}

  static Future<void> unpack(Box<Item> items, Box<Proficiency> proficiencies) async {
    await items.put("padded armor", Armor.smart(name: "Стёганый доспех", cost: 5, AC: 11, ACModifier: Characteristic.dexterity, noise: true, weight: 8, proficiencies: {proficiencies.get("light armor")!}, description: "Стёганый доспех состоит из прошитых слоёв ткани и ватина."));
    await items.put("leather armor", Armor.smart(name: "Кожаный доспех", cost: 10, AC: 11, ACModifier: Characteristic.dexterity, weight: 10, proficiencies: {proficiencies.get("light armor")!}, rare: RareType.uncommon, description: "Нагрудник и плечи этого доспеха изготовлены из кожи, вываренной в масле. Остальные части доспеха сделаны из более мягких и гибких материалов."));
    await items.put("studded leather armor", Armor.smart(name: "Проклёпаный кожаный доспех", cost: 4500, AC: 12, ACModifier: Characteristic.dexterity, weight: 13, proficiencies: {proficiencies.get("light armor")!}, rare: RareType.rare, description: "Изготовленный из крепкой, но гибкой кожи проклёпанный доспех усилен тесно расположенными шипами или заклёпками."));

    await items.put("hide", Armor.smart(name: "Шкурный доспех", cost: 10, AC: 12, ACModifier: Characteristic.dexterity, maxModifier: 2, weight: 12, proficiencies: {proficiencies.get("medium armor")!}, description: "Этот грубый доспех состоит из толстых мехов и шкур. Обычно их носят племена варваров, злые гуманоиды и прочие народы, у которых нет инструментов и материалов для создания более качественных доспехов."));
    await items.put("chain shirt", Armor.smart(name: "Кольчужная рубаха", cost: 50, AC: 13, ACModifier: Characteristic.dexterity, maxModifier: 2, weight: 20, proficiencies: {proficiencies.get("medium armor")!}, rare: RareType.rare, description: "Сделанная из переплетённых металлических колец кольчужная рубаха носится между слоями одежды или кожи. Этот доспех предоставляет умеренную защиту торса и заглушает звон колец внешним покрытием."));
    await items.put("scale mail", Armor.smart(name: "Чешуйчатый доспех", cost: 50, AC: 14, ACModifier: Characteristic.dexterity, maxModifier: 2, noise: true, weight: 45, proficiencies: {proficiencies.get("medium armor")!}, rare: RareType.uncommon, description: "Этот доспех состоит из кожаных куртки и поножей (а также, возможно, отдельной юбки), покрытых перекрывающимися кусочками металла, похожими на рыбную чешую. В комплект входят рукавицы."));
    await items.put("breastplate", Armor.smart(name: "Кираса", cost: 400, AC: 14, ACModifier: Characteristic.dexterity, maxModifier: 2, weight: 20, proficiencies: {proficiencies.get("medium armor")!}, rare: RareType.uncommon, description: "Этот доспех состоит из подогнанного металлического панциря, носимого с подкладкой из кожи. Несмотря на то, что руки и ноги остаются практически без защиты, этот доспех хорошо защищает жизненно важные органы, оставляя владельцу относительную подвижность."));
    await items.put("half plate", Armor.smart(name: "Полулаты", cost: 750, AC: 15, ACModifier: Characteristic.dexterity, maxModifier: 2, noise: true, weight: 40, proficiencies: {proficiencies.get("medium armor")!}, rare: RareType.epic, description: "Полулаты состоят из сформированных металлических пластин, покрывающих большую часть тела владельца. В них не входит защита для ног кроме простых поножей, закреплённых кожаными ремнями."));

    await items.put("ring mail", Armor.smart(name: "Калечный доспех", cost: 30, AC: 14, noise: true, weight: 40, proficiencies: {proficiencies.get("all armor")!}, description: "Это кожаный доспех с нашитыми на него толстыми кольцами. Эти кольца усиливают доспех от ударов мечей и топоров. Колечный доспех хуже кольчуги, и обычно его носят только те, кто не могут позволить себе доспех получше."));
    await items.put("chain mail", Armor.smart(name: "Кольчужный доспех", cost: 75, AC: 16, requirement: 13, noise: true, weight: 55, proficiencies: {proficiencies.get("all armor")!}, rare: RareType.epic, description: "Изготовленная из переплетающихся металлических колец кольчуга включает также слой стёганой ткани, надеваемой под низ, дабы предотвратить натирание и смягчать удары. В комплект входят рукавицы."));
    await items.put("splint armor", Armor.smart(name: "Наборный доспех", cost: 200, AC: 17, requirement: 15, noise: true, weight: 60, proficiencies: {proficiencies.get("all armor")!}, rare: RareType.rare, description: "Этот доспех состоит из узких вертикальных металлических пластин, приклёпанных к кожаной подложке, носимой поверх слоя ватина. Соединения защищаются кольчужным полотном."));
    await items.put("plate armor", Armor.smart(name: "Латный доспех", cost: 1500, AC: 18, requirement: 15, noise: true, weight: 65, proficiencies: {proficiencies.get("all armor")!}, rare: RareType.legendary, description: "Латы состоят из сформированных металлических пластин, покрывающих всё тело. В комплект лат входят рукавицы, тяжёлые кожаные сапоги, шлем с забралом, и толстый слой ватина. Ремешки и пряжки распределяют вес по всему телу."));

    await items.put("shield", Armor.smart(name: "Щит", cost: 10, AC: 2, weight: 6, proficiencies: {proficiencies.get("shields")!}));

    await items.put("common clothes", Armor.smart(name: "Обычная одежда", cost: 0.05, weight: 4));
    await items.put("cassock", Armor.smart(name: "Ряса", cost: 0.03, weight: 3));
    return;
  }

  @override
  String getType(){
      for (int i = 0; i < super.proficiencies.length; i++) {
        switch (super.proficiencies.elementAt(i).mark) {
          case "лёгкий":
            return "Лёгкий доспех";
          case "средний":
            return "Средний доспех";
          case "тяжелый":
            return "Тяжёлый доспех";
          case "щит":
            return "Щит";
          default:
            break;
        }
      }
      return "Одежда";
    }

  Resist get resist => _resist;

  set resist(Resist value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _resist = value;
  }

  int get requirement => _requirement;

  set requirement(int value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _requirement = value;
  }

  int get AC => _AC;

  set AC(int value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _AC = value;
  }

  Characteristic get ACModifier => _ACModifier;

  set ACModifier(Characteristic value) {
    _ACModifier = value;
  }

  int get maxModifier => _maxModifier;

  set maxModifier(int value) {
    _maxModifier = value;
  }

  bool get noise => _noise;

  set noise(bool value) {
    _noise = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Armor &&
          runtimeType == other.runtimeType &&
          _AC == other._AC &&
          _ACModifier == other._ACModifier &&
          _maxModifier == other._maxModifier &&
          _noise == other._noise &&
          _requirement == other._requirement &&
          _resist == other._resist;

  @override
  int get hashCode =>
      super.hashCode ^
      _AC.hashCode ^
      _ACModifier.hashCode ^
      _maxModifier.hashCode ^
      _noise.hashCode ^
      _requirement.hashCode ^
      _resist.hashCode;
}
