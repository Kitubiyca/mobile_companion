import '../characteristics/damage_type.dart';
import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item{

  late List<Dice> _damage;
  late DamageType _damage_type;

  late bool _universal;
  late Dice _universal_damage;

  late bool _heavy;
  late bool _two_handed;
  late bool _melee;
  late bool _throwable;
  late bool _reach;
  late bool _special;
  late bool _fencing;

  late int _min_distance;
  late int _max_distance;

  Weapon(
      String name,
      String description,
      int weight,
      int cost,
      Set<String> notes,
      bool protected,
      this._damage,
      this._universal,
      this._universal_damage,
      this._heavy,
      this._two_handed,
      this._melee,
      this._throwable,
      this._reach,
      this._special,
      this._fencing,
      this._min_distance,
      this._max_distance) : super(name, description, weight, cost, {}, false){_damage_type = DamageType.empty();}

  Weapon.copyFrom(Weapon object) : super(object.name, object. description, object.weight, object.cost, {}, false){
    addNotes(object.notes);
    _damage = object.damage;
    _damage_type = DamageType.copyFrom(object.damage_type);
    _universal = object.universal;
    _universal_damage = object.universal_damage;
    _heavy = object.heavy;
    _two_handed = object.two_handed;
    _melee = object.melee;
    _throwable = object.throwable;
    _reach = object.reach;
    _special = object.special;
    _fencing = object.fencing;
    _min_distance = object.min_distance;
    _max_distance = object.max_distance;
  }

  int get max_distance => _max_distance;

  set max_distance(int value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _max_distance = value;
  }

  int get min_distance => _min_distance;

  set min_distance(int value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _min_distance = value;
  }

  bool get fencing => _fencing;

  set fencing(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _fencing = value;
  }

  bool get special => _special;

  set special(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _special = value;
  }

  bool get reach => _reach;

  set reach(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _reach = value;
  }

  bool get throwable => _throwable;

  set throwable(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _throwable = value;
  }

  bool get melee => _melee;

  set melee(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _melee = value;
  }

  bool get two_handed => _two_handed;

  set two_handed(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _two_handed = value;
  }

  bool get heavy => _heavy;

  set heavy(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _heavy = value;
  }

  Dice get universal_damage => _universal_damage;

  set universal_damage(Dice value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _universal_damage = value;
  }

  bool get universal => _universal;

  set universal(bool value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _universal = value;
  }

  DamageType get damage_type => _damage_type;

  set damage_type(DamageType value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _damage_type = value;
  }

  List<Dice> get damage => _damage;

  set damage(List<Dice> value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _damage = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Weapon &&
          runtimeType == other.runtimeType &&
          _damage == other._damage &&
          _damage_type == other._damage_type &&
          _universal == other._universal &&
          _universal_damage == other._universal_damage &&
          _heavy == other._heavy &&
          _two_handed == other._two_handed &&
          _melee == other._melee &&
          _throwable == other._throwable &&
          _reach == other._reach &&
          _special == other._special &&
          _fencing == other._fencing &&
          _min_distance == other._min_distance &&
          _max_distance == other._max_distance;

  @override
  int get hashCode =>
      super.hashCode ^
      _damage.hashCode ^
      _damage_type.hashCode ^
      _universal.hashCode ^
      _universal_damage.hashCode ^
      _heavy.hashCode ^
      _two_handed.hashCode ^
      _melee.hashCode ^
      _throwable.hashCode ^
      _reach.hashCode ^
      _special.hashCode ^
      _fencing.hashCode ^
      _min_distance.hashCode ^
      _max_distance.hashCode;
}