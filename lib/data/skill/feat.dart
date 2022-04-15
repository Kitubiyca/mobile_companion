class Feat {

  String _name;
  List<String> _description;
  String _requirement;
  Map<String, int> _benefits;
  bool _protected;

  Feat(this._name, this._description, this._requirement, this._benefits,
      this._protected);

  Feat.smart({
    String name = "Example name",
    List<String>? description,
    String requirement = "",
    Map<String, int>? benefits,
    bool protected = false,
  })  : _name = name,
        _description = description ?? [],
        _requirement = requirement,
        _benefits = benefits ?? {},
        _protected = protected;

  //Feat.copyFrom(Feat object){
  //  _name = object.name;
  //  _description = object.description;
  //  _requirement = object.requirement;
  //  _benefits.addAll(object.benefits);
  //  _protected = false;
  //}

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

  List<String> get description => _description;

  set description(List<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  String get requirement => _requirement;

  set requirement(String value) {
    _requirement = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feat &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _requirement == other._requirement &&
          _benefits == other._benefits &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _requirement.hashCode ^
      _benefits.hashCode ^
      _protected.hashCode;
}
