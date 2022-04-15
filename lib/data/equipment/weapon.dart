import '../characteristics/damage_type.dart';
import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item{

  List<Dice> _damage;
  DamageType _damageType;

  List<Dice> _versatileDamage;

  bool _heavy;
  bool _light;
  bool _twoHanded;
  bool _reach;
  bool _special;
  bool _fencing; // finesse
  bool _reloading;

  List<int> _rangedDistance;
  List<int> _throwableDistance;

  Weapon(
      String name,
      String description,
      int weight,
      int cost,
      Set<String> notes,
      bool protected,
      this._damage,
      this._damageType,
      this._versatileDamage,
      this._heavy,
      this._light,
      this._twoHanded,
      this._reach,
      this._special,
      this._fencing,
      this._reloading,
      this._rangedDistance,
      this._throwableDistance) : super(name, description, weight, cost, notes, false);

  Weapon.smart({
    String name = "Default name",
    String description = "",
    int weight = 0,
    int cost = 0,
    Set<String>? notes,
    bool protected = false,
    List<Dice>? damage,
    DamageType? damageType,
    List<Dice>? versatileDamage,
    bool heavy = false,
    bool light = false,
    bool twoHanded = false,
    bool reach = false,
    bool special = false,
    bool fencing = false,
    bool reloading = false,
    List<int>? rangedDistance,
    List<int>? throwableDistance,
}) :
        _damage = damage ?? [],
        _damageType = damageType ?? DamageType.empty(),
        _versatileDamage = versatileDamage ?? [],
        _heavy = heavy,
  _light = light,
        _twoHanded = twoHanded,
        _reach = reach,
        _special = special,
        _fencing = fencing,
  _reloading = reloading,
  _rangedDistance = rangedDistance ?? [],
  _throwableDistance = throwableDistance ?? [],
        super(name, description, weight, cost, notes ?? {}, false){
    if(_damage.isEmpty) _damage.add(Dice(1, 4));
  }

  static List<Weapon> getStandartWeapons(){
    List<Weapon> weapons = [];
    weapons.add(Weapon.smart(name: "Боевой посох", cost: 20, damage: [Dice(1, 6)], damageType: DamageType.smart(bludgeoning: true), weight: 4, versatileDamage: [Dice(1, 8)]));
    weapons.add(Weapon.smart(name: "Булава", cost: 500, damage: [Dice(1, 6)], damageType: DamageType.smart(bludgeoning: true), weight: 4));
    weapons.add(Weapon.smart(name: "Дубинка", cost: 10, damage: [Dice(1, 4)], damageType: DamageType.smart(bludgeoning: true), weight: 2, light: true));
    weapons.add(Weapon.smart(name: "Кинжал", cost: 200, damage: [Dice(1, 4)], damageType: DamageType.smart(piercing: true), weight: 1, light: true, throwableDistance: [20, 60], fencing: true));
    weapons.add(Weapon.smart(name: "Копьё", cost: 100, damage: [Dice(1, 6)], damageType: DamageType.smart(piercing: true), weight: 3, throwableDistance: [20, 60], versatileDamage: [Dice(1, 8)]));
    weapons.add(Weapon.smart(name: "Лёгкий молот", cost: 200, damage: [Dice(1, 4)], damageType: DamageType.smart(bludgeoning: true), weight: 2, light: true, throwableDistance: [20, 60]));
    weapons.add(Weapon.smart(name: "Метательное копьё", cost: 50, damage: [Dice(1, 6)], damageType: DamageType.smart(piercing: true), weight: 2, throwableDistance: [30, 120]));
    weapons.add(Weapon.smart(name: "Палица", cost: 20, damage: [Dice(1, 8)], damageType: DamageType.smart(bludgeoning: true), weight: 10, twoHanded: true));
    weapons.add(Weapon.smart(name: "Ручной топор", cost: 500, damage: [Dice(1, 6)], damageType: DamageType.smart(slashing: true), weight: 2, light: true, throwableDistance: [20, 60]));
    weapons.add(Weapon.smart(name: "Серп", cost: 100, damage: [Dice(1, 4)], damageType: DamageType.smart(slashing: true), weight: 2, light: true));

    weapons.add(Weapon.smart(name: "Арбалет, лёгкий", cost: 2500, damage: [Dice(1, 8)], damageType: DamageType.smart(piercing: true), weight: 5, rangedDistance: [80, 320], twoHanded: true, reloading: true));
    weapons.add(Weapon.smart(name: "Дротик", cost: 5, damage: [Dice(1, 4)], damageType: DamageType.smart(piercing: true), throwableDistance: [20, 60], fencing: true));
    weapons.add(Weapon.smart(name: "Короткий лук", cost: 2500, damage: [Dice(1, 6)], damageType: DamageType.smart(piercing: true), weight: 2, rangedDistance: [80, 320], twoHanded: true));
    weapons.add(Weapon.smart(name: "Праща", cost: 10, damage: [Dice(1, 4)], damageType: DamageType.smart(bludgeoning: true), rangedDistance: [30, 120]));

    return weapons;
  }

  bool get fencing => _fencing;

  set fencing(bool value) {
    _fencing = value;
  }

  bool get special => _special;

  set special(bool value) {
    _special = value;
  }

  bool get reach => _reach;

  set reach(bool value) {
    _reach = value;
  }

  bool get twoHanded => _twoHanded;

  set twoHanded(bool value) {
    _twoHanded = value;
  }

  bool get heavy => _heavy;

  set heavy(bool value) {
    _heavy = value;
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

  bool get light => _light;

  set light(bool value) {
    _light = value;
  }

  List<int> get throwableDistance => _throwableDistance;

  set throwableDistance(List<int> value) {
    _throwableDistance = value;
  }

  List<int> get rangedDistance => _rangedDistance;

  set rangedDistance(List<int> value) {
    _rangedDistance = value;
  }

  bool get reloading => _reloading;

  set reloading(bool value) {
    _reloading = value;
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
          _heavy == other._heavy &&
          _light == other._light &&
          _twoHanded == other._twoHanded &&
          _reach == other._reach &&
          _special == other._special &&
          _fencing == other._fencing &&
          _reloading == other._reloading &&
          _rangedDistance == other._rangedDistance &&
          _throwableDistance == other._throwableDistance;

  @override
  int get hashCode =>
      super.hashCode ^
      _damage.hashCode ^
      _damageType.hashCode ^
      _versatileDamage.hashCode ^
      _heavy.hashCode ^
      _light.hashCode ^
      _twoHanded.hashCode ^
      _reach.hashCode ^
      _special.hashCode ^
      _fencing.hashCode ^
      _reloading.hashCode ^
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