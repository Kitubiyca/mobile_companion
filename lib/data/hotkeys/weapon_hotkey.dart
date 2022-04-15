import 'package:dnd_companion/data/equipment/weapon.dart';
import '../character/character.dart';
import '../equipment/item.dart';

class WeaponHotkey {
  String _name;
  Weapon _weapon;
  String _characteristic;
  bool _versatile;
  Item? _ammunition;

  WeaponHotkey(this._name, this._weapon, this._characteristic,
      this._versatile, this._ammunition);

  WeaponHotkey.smart(
    this._name,
    this._weapon, {
    String? characteristic,
    bool versatile = false,
    Item? ammunition,
  })  : _characteristic = characteristic ?? "str",
        _versatile = versatile,
        _ammunition = ammunition;

  bool get versatile => _versatile;

  set versatile(bool value) {
    _versatile = value;
  }

  Item? get ammunition => _ammunition;

  set ammunition(Item? value) {
    _ammunition = value;
  }

  String get characteristic => _characteristic;

  set characteristic(String value) {
    _characteristic = value;
  }

  Weapon get weapon => _weapon;

  set weapon(Weapon value) {
    _weapon = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeaponHotkey &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _weapon == other._weapon &&
          _characteristic == other._characteristic &&
          _versatile == other._versatile &&
          _ammunition == other._ammunition;

  @override
  int get hashCode =>
      _name.hashCode ^
      _weapon.hashCode ^
      _characteristic.hashCode ^
      _versatile.hashCode ^
      _ammunition.hashCode;
}
