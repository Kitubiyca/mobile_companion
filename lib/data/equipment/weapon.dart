import '../dice/dice.dart';
import 'item.dart';

class Weapon extends Item{

  List<Dice> _damage;
  List<String> _damage_type;

  bool _universal;
  Dice _universal_damage;

  bool _heavy;
  bool _two_handed;
  bool _melee;
  bool _throwable;
  bool _reach;
  bool _special;
  bool _fencing;

  int _min_distance;
  int _max_distance;

  static List<Weapon> weapons = [];

  Weapon(
      this._damage,
      this._damage_type,
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
      this._max_distance) : super.extendedConstructor('', '', 0, 0, {}, false){weapons.add(this);}

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

  List<String> get damage_type => _damage_type;

  set damage_type(List<String> value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _damage_type = value;
  }

  List<Dice> get damage => _damage;

  set damage(List<Dice> value) {
    if (super.protected) throw Exception("Denied access to protected data.");
    _damage = value;
  }
}