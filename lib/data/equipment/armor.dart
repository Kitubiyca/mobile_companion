import 'package:dnd_companion/data/characteristics/resist.dart';
import 'item.dart';

class Armor extends Item {
  String _type;
  int _AC;
  String _ACModifier;
  int _maxModifier;
  bool _noise;
  int _requirement;
  Resist _resist;

  Armor(
      String name,
      String description,
      int weight,
      int cost,
      Set<String> notes,
      bool protected,
      this._type,
      this._AC,
      this._ACModifier,
      this._maxModifier,
      this._noise,
      this._requirement,
      this._resist)
      : super(name, description, weight, cost, notes, protected);

  Armor.smart({
    String name = "Default name",
    String description = "",
    int weight = 0,
    int cost = 0,
    Set<String>? notes,
    bool protected = false,
    String type = "",
    int AC = 0,
    String ACModifier = "",
    int maxModifier = 0,
    bool noise = false,
    int requirement = 0,
    Resist? resist,
  })  : _type = type,
        _AC = AC,
        _ACModifier = ACModifier,
        _maxModifier = maxModifier,
        _noise = noise,
        _requirement = requirement,
        _resist = resist ?? Resist.empty(),
        super(name, description, weight, cost, notes ?? {}, protected);

  //Armor.copyFrom(Armor object) : super(object.name, object.description, object.weight, object.cost, {}, false){
  //  addNotes(object.notes);
  //  _type = object.type;
  //  _AC = object.AC;
  //  _requirement = object.requirement;
  //  _resist = Resist.copyFrom(object.resist);
  //}

  static List<Armor> getStandartArmor(){
    List<Armor> armor = [];
    armor.add(Armor.smart(name: "Стёганый доспех", cost: 500, AC: 11, ACModifier: "dex", noise: true, weight: 8, notes: {"лёгкий"}));
    armor.add(Armor.smart(name: "Кожаный доспех", cost: 1000, AC: 11, ACModifier: "dex", weight: 10, notes: {"лёгкий"}));
    armor.add(Armor.smart(name: "Проклёпаный кожаный доспех", cost: 4500, AC: 12, ACModifier: "dex", weight: 13, notes: {"лёгкий"}));

    armor.add(Armor.smart(name: "Шкурный доспех", cost: 1000, AC: 12, ACModifier: "dex", maxModifier: 2, weight: 12, notes: {"средний"}));
    armor.add(Armor.smart(name: "Кольчужная рубаха", cost: 5000, AC: 13, ACModifier: "dex", maxModifier: 2, weight: 20, notes: {"средний"}));
    armor.add(Armor.smart(name: "Чешуйчатый доспех", cost: 5000, AC: 14, ACModifier: "dex", maxModifier: 2, noise: true, weight: 45, notes: {"средний"}));
    armor.add(Armor.smart(name: "Кираса", cost: 40000, AC: 14, ACModifier: "dex", maxModifier: 2, weight: 20, notes: {"средний"}));
    armor.add(Armor.smart(name: "Полулаты", cost: 75000, AC: 15, ACModifier: "dex", maxModifier: 2, noise: true, weight: 40, notes: {"средний"}));

    armor.add(Armor.smart(name: "Калечный доспех", cost: 3000, AC: 14, noise: true, weight: 40, notes: {"тяжёлый"}));
    armor.add(Armor.smart(name: "Кольчужный доспех", cost: 7500, AC: 16, requirement: 13, noise: true, weight: 55, notes: {"тяжёлый"}));
    armor.add(Armor.smart(name: "Наборный доспех", cost: 20000, AC: 17, requirement: 15, noise: true, weight: 60, notes: {"тяжёлый"}));
    armor.add(Armor.smart(name: "Латный доспех", cost: 150000, AC: 18, requirement: 15, noise: true, weight: 65, notes: {"тяжёлый"}));

    armor.add(Armor.smart(name: "Щит", cost: 1000, AC: 2, weight: 6, notes: {"щит"}));
    return armor;
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

  String get type => _type;

  set type(String value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _type = value;
  }

  String get ACModifier => _ACModifier;

  set ACModifier(String value) {
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
          _type == other._type &&
          _AC == other._AC &&
          _ACModifier == other._ACModifier &&
          _maxModifier == other._maxModifier &&
          _noise == other._noise &&
          _requirement == other._requirement &&
          _resist == other._resist;

  @override
  int get hashCode =>
      super.hashCode ^
      _type.hashCode ^
      _AC.hashCode ^
      _ACModifier.hashCode ^
      _maxModifier.hashCode ^
      _noise.hashCode ^
      _requirement.hashCode ^
      _resist.hashCode;
}
