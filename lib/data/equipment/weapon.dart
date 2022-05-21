import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:hive/hive.dart';
import '../characteristics/damage_type.dart';
import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item {

  List<Dice> _damage;
  DamageType _damageType;
  List<Dice> _versatileDamage;
  Set<WeaponFeature> _features;
  List<int> _rangedDistance;
  List<int> _throwableDistance;

  Weapon(
      String name,
      String description,
      int weight,
      int cost,
      Set<Proficiency> proficiencies,
      Map<Characteristic, int> additionalStats,
      Map<Characteristic, int> forcedStats,
      Set<String> notes,
      bool protected,
      this._damage,
      this._damageType,
      this._versatileDamage,
      this._features,
      this._rangedDistance,
      this._throwableDistance)
      : super(name, description, weight, cost, proficiencies, true, additionalStats, forcedStats, notes, false);

  Weapon.smart({
    required String name,
    String description = "",
    int weight = 0,
    int cost = 0,
    Set<Proficiency>? proficiencies,
    Map<Characteristic, int>? additionalStats,
    Map<Characteristic, int>? forcedStats,
    Set<String>? notes,
    bool protected = false,
    required List<Dice> damage,
    required DamageType damageType,
    List<Dice>? versatileDamage,
    Set<WeaponFeature>? features,
    List<int>? rangedDistance,
    List<int>? throwableDistance,
  })  : _damage = damage,
        _damageType = damageType,
        _versatileDamage = versatileDamage ?? [],
        _features = features ?? {},
        _rangedDistance = rangedDistance ?? [],
        _throwableDistance = throwableDistance ?? [],
        super(name, description, weight, cost, proficiencies ?? {}, true, additionalStats ?? {}, forcedStats ?? {}, notes ?? {}, false);

  static Future<void> unpack(Box<Item> items, Box<Proficiency> proficiencies) async {
    items.put("quarterstaff", Weapon.smart(
        name: "Боевой посох",
        cost: 20,
        proficiencies: {proficiencies.get("quarterstaffs")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(bludgeoning: true),
        weight: 4,
        versatileDamage: [Dice(1, 8)]));
    items.put("mace", Weapon.smart(
        name: "Булава",
        cost: 500,
        proficiencies: {proficiencies.get("maces")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(bludgeoning: true),
        weight: 4));
    items.put("club", Weapon.smart(
        name: "Дубинка",
        cost: 10,
        proficiencies: {proficiencies.get("clubs")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(bludgeoning: true),
        weight: 2,
        features: {WeaponFeature.light}));
    items.put("dagger", Weapon.smart(
        name: "Кинжал",
        cost: 200,
        proficiencies: {proficiencies.get("daggers")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(piercing: true),
        weight: 1,
        throwableDistance: [20, 60],
        features: {WeaponFeature.light, WeaponFeature.fencing}));
    items.put("spear", Weapon.smart(
        name: "Копьё",
        cost: 100,
        proficiencies: {proficiencies.get("spears")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(piercing: true),
        weight: 3,
        throwableDistance: [20, 60],
        versatileDamage: [Dice(1, 8)]));
    items.put("light hammer", Weapon.smart(
        name: "Лёгкий молот",
        cost: 200,
        proficiencies: {proficiencies.get("throwing hammers")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(bludgeoning: true),
        weight: 2,
        features: {WeaponFeature.light},
        throwableDistance: [20, 60]));
    items.put("javelin", Weapon.smart(
        name: "Метательное копьё",
        cost: 50,
        proficiencies: {proficiencies.get("javelins")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(piercing: true),
        weight: 2,
        throwableDistance: [30, 120]));
    items.put("greatclub", Weapon.smart(
        name: "Палица",
        cost: 20,
        proficiencies: {proficiencies.get("simple weapons")!},
        damage: [Dice(1, 8)],
        damageType: DamageType.smart(bludgeoning: true),
        weight: 10,
        features: {WeaponFeature.twoHanded}));
    items.put("handaxe", Weapon.smart(
        name: "Ручной топор",
        cost: 500,
        proficiencies: {proficiencies.get("handaxes")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(slashing: true),
        weight: 2,
        features: {WeaponFeature.light},
        throwableDistance: [20, 60]));
    items.put("sickle", Weapon.smart(
        name: "Серп",
        cost: 100,
        proficiencies: {proficiencies.get("sickles")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(slashing: true),
        weight: 2,
        features: {WeaponFeature.light}));
    items.put("crossbow, light", Weapon.smart(
        name: "Арбалет, лёгкий",
        cost: 2500,
        proficiencies: {proficiencies.get("simple weapons")!},
        damage: [Dice(1, 8)],
        damageType: DamageType.smart(piercing: true),
        weight: 5,
        rangedDistance: [80, 320],
        features: {WeaponFeature.reloading, WeaponFeature.twoHanded}));
    items.put("dart", Weapon.smart(
        name: "Дротик",
        cost: 5,
        proficiencies: {proficiencies.get("darts")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(piercing: true),
        throwableDistance: [20, 60],
        features: {WeaponFeature.fencing}));
    items.put("shortbow", Weapon.smart(
        name: "Короткий лук",
        cost: 2500,
        proficiencies: {proficiencies.get("shortbows")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 6)],
        damageType: DamageType.smart(piercing: true),
        weight: 2,
        rangedDistance: [80, 320],
        features: {WeaponFeature.twoHanded}));
    items.put("sling", Weapon.smart(
        name: "Праща",
        cost: 10,
        proficiencies: {proficiencies.get("slings")!, proficiencies.get("simple weapons")!},
        damage: [Dice(1, 4)],
        damageType: DamageType.smart(bludgeoning: true),
        rangedDistance: [30, 120]));
    return;
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

  List<Dice> get versatileDamage => _versatileDamage;

  set versatileDamage(List<Dice> value) {
    _versatileDamage = value;
  }

  DamageType get damageType => _damageType;

  set damageType(DamageType value) {
    _damageType = value;
  }

  List<Dice> get damage => _damage;

  set damage(List<Dice> value) {
    _damage = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Weapon &&
          runtimeType == other.runtimeType &&
          _damage == other._damage &&
          _damageType == other._damageType &&
          _versatileDamage == other._versatileDamage &&
          _features == other._features &&
          _rangedDistance == other._rangedDistance &&
          _throwableDistance == other._throwableDistance;

  @override
  int get hashCode =>
      super.hashCode ^
      _damage.hashCode ^
      _damageType.hashCode ^
      _versatileDamage.hashCode ^
      _features.hashCode ^
      _rangedDistance.hashCode ^
      _throwableDistance.hashCode;

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
