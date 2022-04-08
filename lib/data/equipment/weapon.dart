import '../characteristics/damage_type.dart';
import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item{

  List<Dice> _damage;
  DamageType _damageType;

  List<Dice> _versatileDamage;

  bool _heavy;
  bool _twoHanded;
  bool _melee;
  bool _throwable;
  bool _reach;
  bool _special;
  bool _fencing; // finesse

  int _minDistance;
  int _maxDistance;

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
      this._twoHanded,
      this._melee,
      this._throwable,
      this._reach,
      this._special,
      this._fencing,
      this._minDistance,
      this._maxDistance) : super(name, description, weight, cost, notes, false);

  Weapon.smart({
    String name = "Default name",
    String description = "Default description",
    int weight = 10,
    int cost = 20,
    Set<String>? notes,
    bool protected = false,
    List<Dice>? damage,
    DamageType? damageType,
    List<Dice>? versatileDamage,
    bool heavy = false,
    bool twoHanded = false,
    bool melee = false,
    bool throwable = false,
    bool reach = false,
    bool special = false,
    bool fencing = false,
    int minDistance = 0,
    int maxDistance = 20,
}) :
        _damage = damage ?? [],
        _damageType = damageType ?? DamageType.empty(),
        _versatileDamage = versatileDamage ?? [],
        _heavy = heavy,
        _twoHanded = twoHanded,
        _melee = melee,
        _throwable = throwable,
        _reach = reach,
        _special = special,
        _fencing = fencing,
        _minDistance = minDistance,
        _maxDistance = maxDistance,
        super(name, description, weight, cost, notes ?? {}, false){
    if(_damage.isEmpty) _damage.add(Dice(1, 4));
  }

  int get maxDistance => _maxDistance;

  set maxDistance(int value) {
    _maxDistance = value;
  }

  int get minDistance => _minDistance;

  set minDistance(int value) {
    _minDistance = value;
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

  bool get throwable => _throwable;

  set throwable(bool value) {
    _throwable = value;
  }

  bool get melee => _melee;

  set melee(bool value) {
    _melee = value;
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
          _twoHanded == other._twoHanded &&
          _melee == other._melee &&
          _throwable == other._throwable &&
          _reach == other._reach &&
          _special == other._special &&
          _fencing == other._fencing &&
          _minDistance == other._minDistance &&
          _maxDistance == other._maxDistance;

  @override
  int get hashCode =>
      super.hashCode ^
      _damage.hashCode ^
      _damageType.hashCode ^
      _versatileDamage.hashCode ^
      _heavy.hashCode ^
      _twoHanded.hashCode ^
      _melee.hashCode ^
      _throwable.hashCode ^
      _reach.hashCode ^
      _special.hashCode ^
      _fencing.hashCode ^
      _minDistance.hashCode ^
      _maxDistance.hashCode;

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