class Feat{

  late String _name;
  late String _description;
  late Map<String, int> _benefits;
  late bool _protected;

  static List<Feat> feats = [];

  Feat(this._name, this._description, this._benefits, this._protected);

  Feat.withAdd(this._name, this._description, this._benefits, this._protected){feats.add(this);}

  Feat.copyFrom(Feat object){
    _name = object.name;
    _description = object.description;
    _benefits.addAll(object.benefits);
    _protected = false;
  }

  bool get protected => _protected;

  set protected(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _protected = value;
  }

  Map<String, int> get benefits => _benefits;

  set benefits(Map<String, int> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _benefits = value;
  }

  String get description => _description;

  set description(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feat &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _benefits == other._benefits &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _benefits.hashCode ^
      _protected.hashCode;
}