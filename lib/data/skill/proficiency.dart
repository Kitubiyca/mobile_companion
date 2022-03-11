class Proficiency{

  late String _name;
  late String _description;
  late bool _protected;

  static List<Proficiency> proficiencies = [];

  Proficiency(this._name, this._description, this._protected);

  Proficiency.withAdd(this._name, this._description, this._protected) {proficiencies.add(this);}

  Proficiency.copyFrom(Proficiency object){
    _name = object.name;
    _description = object.description;
    _protected = false;
  }

  bool get protected => _protected;

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
      other is Proficiency &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^ _description.hashCode ^ _protected.hashCode;

}