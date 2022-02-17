class Proficiency{

  String _name;
  String _description;
  bool _protected;

  static List<Proficiency> proficiencies = [];

  Proficiency(this._name, this._description, this._protected) {proficiencies.add(this);}

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

}