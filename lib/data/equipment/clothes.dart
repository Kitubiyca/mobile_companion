import 'package:dnd_companion/data/characteristics/resist.dart';
import 'item.dart';

class Clothes extends Item{

  late String _type;
  late int _AC;
  late String _ACModifier;
  late bool _noise;
  late int _requirement;
  late Resist _resist;

  Clothes(String name, String description, int weight, int cost, Set<String> notes, bool protected, this._type, this._AC, this._requirement) : super(name, description, weight, cost, notes, protected){
    resist = Resist.empty();
  }

  Clothes.copyFrom(Clothes object) : super(object.name, object.description, object.weight, object.cost, {}, false){
    addNotes(object.notes);
    _type = object.type;
    _AC = object.AC;
    _requirement = object.requirement;
    _resist = Resist.copyFrom(object.resist);
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Clothes &&
          runtimeType == other.runtimeType &&
          _type == other._type &&
          _AC == other._AC &&
          _requirement == other._requirement &&
          _resist == other._resist;

  @override
  int get hashCode =>
      super.hashCode ^
      _type.hashCode ^
      _AC.hashCode ^
      _requirement.hashCode ^
      _resist.hashCode;
}