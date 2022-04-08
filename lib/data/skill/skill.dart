class Skill{

  Skill();

  /*

  String _name;
  String _description;
  bool _dice;
  bool _damage;
  bool _mastery;
  bool _unarmed;
  String _classPoint;
  String _code;

  late bool _protected;

  Skill(this._name, this._description, this._dice, this._damage, this._mastery,
      this._unarmed, this._classPoint, this._code, this._protected);

  //Skill.copyFrom(Skill object){
  //  _name = object.name;
  //  _description = object.description;
  //  _dice = object.dice;
  //  _damage = object.damage;
  //  _mastery = object.mastery;
  //  _unarmed = object.unarmed;
  //  _classPoint = object.classPoint;
  //  _code = code;
  //  _protected = false;
  //}

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  String get description => _description;

  set description(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _description = value;
  }

  bool get dice => _dice;

  set dice(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _dice = value;
  }

  bool get damage => _damage;

  set damage(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _damage = value;
  }

  bool get mastery => _mastery;

  set mastery(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _mastery = value;
  }

  bool get unarmed => _unarmed;

  set unarmed(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _unarmed = value;
  }

  String get classPoint => _classPoint;

  set classPoint(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _classPoint = value;
  }

  String get code => _code;

  set code(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _code = value;
  }

  bool get protected => _protected;

  set protected(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _protected = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Skill &&
              runtimeType == other.runtimeType &&
              _name == other._name &&
              _description == other._description &&
              _dice == other._dice &&
              _damage == other._damage &&
              _mastery == other._mastery &&
              _unarmed == other._unarmed &&
              _classPoint == other._classPoint &&
              _code == other._code &&
              _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _dice.hashCode ^
      _damage.hashCode ^
      _mastery.hashCode ^
      _unarmed.hashCode ^
      _classPoint.hashCode ^
      _code.hashCode ^
      _protected.hashCode;

      */

}