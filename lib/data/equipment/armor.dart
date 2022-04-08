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
    String description = "Default description",
    int weight = 10,
    int cost = 20,
    Set<String>? notes,
    bool protected = false,
    String type = "light",
    int AC = 10,
    String ACModifier = "dex",
    int maxModifier = 2,
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
