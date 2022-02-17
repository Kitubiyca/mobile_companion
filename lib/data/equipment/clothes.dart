import 'item.dart';

class Clothes extends Item{

  String _type;
  int _AC;
  int _requirement;

  static List<Clothes> clothes = [];

  Clothes(this._type, this._AC, this._requirement) : super.extendedConstructor('', '', 0, 0, {}, false){clothes.add(this);}

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
}