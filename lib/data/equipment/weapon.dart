import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:hive/hive.dart';
import '../characteristics/damage_type.dart';
import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item {

  Map<DamageType, Dice> _damage;
  Map<DamageType, Dice> _versatileDamage;
  Set<WeaponFeature> _features;
  List<int> _rangedDistance;
  List<int> _throwableDistance;

  Weapon(
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
      this._damage,
      this._versatileDamage,
      this._features,
      this._rangedDistance,
      this._throwableDistance)
      : super(name, description, image, weight, cost, rare, proficiencies, true, additionalStats, forcedStats, notes, false);

  Weapon.smart({
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
    required Map<DamageType, Dice> damage,
    Map<DamageType, Dice>? versatileDamage,
    Set<WeaponFeature>? features,
    List<int>? rangedDistance,
    List<int>? throwableDistance,
  })  : _damage = damage,
        _versatileDamage = versatileDamage ?? {},
        _features = features ?? {},
        _rangedDistance = rangedDistance ?? [],
        _throwableDistance = throwableDistance ?? [],
        super(name, description, image, weight, double.parse(cost.toStringAsPrecision(2)), rare ?? RareType.common, proficiencies ?? {}, true, additionalStats ?? {}, forcedStats ?? {}, notes ?? {}, false);

  static Future<void> unpack(Box<Item> items, Box<Proficiency> proficiencies) async {
    await items.put("quarterstaff", Weapon.smart(
        name: "Боевой посох",
        cost: 0.2,
        proficiencies: {proficiencies.get("quarterstaffs")!, proficiencies.get("simple weapons")!},
        damage: {DamageType. bludgeoning: Dice(1, 6, 0)},
        weight: 4,
        versatileDamage: {DamageType.bludgeoning: Dice(1, 8, 0)}));
    await items.put("mace", Weapon.smart(
        name: "Булава",
        cost: 5,
        proficiencies: {proficiencies.get("maces")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.bludgeoning: Dice(1, 6, 0)},
        weight: 4));
    await items.put("club", Weapon.smart(
        name: "Дубинка",
        cost: 0.1,
        proficiencies: {proficiencies.get("clubs")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.bludgeoning: Dice(1, 4, 0)},
        weight: 2,
        features: {WeaponFeature.light}));
    await items.put("dagger", Weapon.smart(
        name: "Кинжал",
        cost: 2,
        proficiencies: {proficiencies.get("daggers")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 4, 0)},
        weight: 1,
        throwableDistance: [20, 60],
        features: {WeaponFeature.light, WeaponFeature.fencing}));
    await items.put("spear", Weapon.smart(
        name: "Копьё",
        cost: 1,
        proficiencies: {proficiencies.get("spears")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 6, 0)},
        weight: 3,
        throwableDistance: [20, 60],
        versatileDamage: {DamageType.piercing: Dice(1, 8, 0)}));
    await items.put("light hammer", Weapon.smart(
        name: "Лёгкий молот",
        cost: 2,
        proficiencies: {proficiencies.get("throwing hammers")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.bludgeoning: Dice(1, 4, 0)},
        weight: 2,
        features: {WeaponFeature.light},
        throwableDistance: [20, 60]));
    await items.put("javelin", Weapon.smart(
        name: "Метательное копьё",
        cost: 0.5,
        proficiencies: {proficiencies.get("javelins")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 6, 0)},
        weight: 2,
        throwableDistance: [30, 120]));
    await items.put("greatclub", Weapon.smart(
        name: "Палица",
        cost: 0.5,
        proficiencies: {proficiencies.get("simple weapons")!},
        damage: {DamageType.bludgeoning: Dice(1, 8, 0)},
        weight: 10,
        features: {WeaponFeature.twoHanded}));
    await items.put("handaxe", Weapon.smart(
        name: "Ручной топор",
        cost: 5,
        proficiencies: {proficiencies.get("handaxes")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.slashing: Dice(1, 6, 0)},
        weight: 2,
        features: {WeaponFeature.light},
        throwableDistance: [20, 60]));
    await items.put("sickle", Weapon.smart(
        name: "Серп",
        cost: 1,
        proficiencies: {proficiencies.get("sickles")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.slashing: Dice(1, 4, 0)},
        weight: 2,
        features: {WeaponFeature.light}));
    await items.put("crossbow, light", Weapon.smart(
        name: "Арбалет, лёгкий",
        cost: 25,
        proficiencies: {proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 8, 0)},
        weight: 5,
        rangedDistance: [80, 320],
        features: {WeaponFeature.reloading, WeaponFeature.twoHanded}));
    await items.put("dart", Weapon.smart(
        name: "Дротик",
        cost: 0.05,
        proficiencies: {proficiencies.get("darts")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 4, 0)},
        throwableDistance: [20, 60],
        features: {WeaponFeature.fencing}));
    await items.put("shortbow", Weapon.smart(
        name: "Короткий лук",
        cost: 25,
        proficiencies: {proficiencies.get("shortbows")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 6, 0)},
        weight: 2,
        rangedDistance: [80, 320],
        features: {WeaponFeature.twoHanded}));
    await items.put("sling", Weapon.smart(
        name: "Праща",
        cost: 0.1,
        proficiencies: {proficiencies.get("slings")!, proficiencies.get("simple weapons")!},
        damage: {DamageType.bludgeoning: Dice(1, 4, 0)},
        rangedDistance: [30, 120]));
    await items.put("small knife", Weapon.smart(
        name: "Маленький нож",
        cost: 0.2,
        weight: 1,
        proficiencies: {proficiencies.get("simple weapons")!},
        damage: {DamageType.piercing: Dice(1, 4, 0)}));
    await items.put("long sword", Weapon.smart(
        name: "Длинный меч",
        cost: 15,
        weight: 3,
        proficiencies: {proficiencies.get("martial weapons")!},
        damage: {DamageType.slashing: Dice(1, 8, 0)},
        versatileDamage: {DamageType.slashing: Dice(1, 10, 0)}));
  }

  @override
  String getType() {
      for (int i = 0; i < super.proficiencies.length; i++) {
        switch (super.proficiencies.elementAt(i).mark) {
          case "простое":
            return "Простое оружие";
          case "воинское":
            return "Воинское оружие";
          default:
            break;
        }
      }
      return "Оружие";
    }

  String getFeatures(){
    String ret = "";
    for(int i=0; i<features.length; i++){
      ret+=features.elementAt(i).getText() + ", ";
    }
    if(versatileDamage.isNotEmpty){
      ret += "универсальное(" + getStringVersatileDamage() + "), ";
    }
    if(rangedDistance.isNotEmpty){
      ret += "Боеприпас (дис. " + rangedDistance.elementAt(0).toString() + "/" + rangedDistance.elementAt(1).toString() + "), ";
    }
    if(throwableDistance.isNotEmpty){
      ret += "метательное (дис. " + throwableDistance.elementAt(0).toString() + "/" + throwableDistance.elementAt(1).toString() + "), ";
    }
    if(ret==""){
      return ret;
    } else {
      return ret.substring(0, ret.length-2);
    }
  }

  String getStringDamage(){
    String ret = "";
    for(int i=0; i < damage.length; i++){
      ret += (damage.values.elementAt(i).name == "1D1" ? "1" : damage.values.elementAt(i).name) + " " + damage.keys.elementAt(i).getText() + ", ";
    }
    if(ret != "") ret = ret.substring(0, ret.length-2);
    return ret;
  }

  String getStringVersatileDamage(){
    String ret = "";
    for(int i=0; i < versatileDamage.length; i++){
      ret += (versatileDamage.values.elementAt(i).name == "1D1" ? "1" : versatileDamage.values.elementAt(i).name) + " " + (versatileDamage.keys.elementAt(i) == damage.keys.elementAt(i) ? "" : versatileDamage.keys.elementAt(i).getText()) + ", ";
    }
    if(ret != "") ret = ret.substring(0, ret.length-2);
    return ret;
  }

  bool checkProficiency(Character character){
    for(Proficiency prof in super.proficiencies){
      if (character.proficiencies.contains(prof)){
        return true;
      }
    }
    return false;
  }

  Map<String, int> getAttackMap(Character character, bool dex){
    Map<String, int> ret = {};
    ret["1к20"] = Dice(1, 20, 0).roll().first;
    if(dex){
      ret["Лов"] = character.getStatBonus(Characteristic.dexterity);
    } else {
      ret["Сил"] = character.getStatBonus(Characteristic.strength);
    }
    if(checkProficiency(character)){
      ret["Мастер"] = character.getProficiencyBonus();
    }
    return ret;
  }

  List<int> get throwableDistance => _throwableDistance;

  set throwableDistance(List<int> value) {
    _throwableDistance = value;
  }

  List<int> get rangedDistance => _rangedDistance;

  set rangedDistance(List<int> value) {
    _rangedDistance = value;
  }

  Set<WeaponFeature> get features => _features;

  set features(Set<WeaponFeature> value) {
    _features = value;
  }

  Map<DamageType, Dice> get versatileDamage => _versatileDamage;

  set versatileDamage(Map<DamageType, Dice> value) {
    _versatileDamage = value;
  }

  Map<DamageType, Dice> get damage => _damage;

  set damage(Map<DamageType, Dice> value) {
    _damage = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other && other is Weapon &&
              runtimeType == other.runtimeType && _damage == other._damage &&
              _versatileDamage == other._versatileDamage &&
              _features == other._features &&
              _rangedDistance == other._rangedDistance &&
              _throwableDistance == other._throwableDistance;

  @override
  int get hashCode =>
      super.hashCode ^ _damage.hashCode ^ _versatileDamage.hashCode ^ _features
          .hashCode ^ _rangedDistance.hashCode ^ _throwableDistance.hashCode;

//Weapon.copyFrom(Weapon object) : super(object.name, object. description, object.weight, object.cost, {}, false){
//  addNotes(object.notes);
//  _damage = object.damage;
//  _damage_type = DamageType.copyFrom(object.damage_type);
//  _versatile_damage = object.versatile_damage;
//  _heavy = object.heavy;
//  _two_handed = object.two_handed;
//  _melee = object.melee;
//  _throwable = object.throwable;
//  _reach = object.reach;
//  _special = object.special;
//  _fencing = object.fencing;
//  _min_distance = object.min_distance;
//  _max_distance = object.max_distance;
//}

}
