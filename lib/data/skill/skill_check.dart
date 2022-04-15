class SkillCheck {

  String _name;
  String _code;
  bool _protected;

  SkillCheck(this._name, this._code, this._protected);

  SkillCheck.smart({
    String name = "Example name",
    String code = "Example name",
    bool protected = false,
  })  : _name = name,
        _code = code,
        _protected = protected;

  //SkillCheck.copyFrom(SkillCheck object){
  //  _name = object.name;
  //  _code = object.code;
  //  _protected = false;
  //}

  static List<SkillCheck> getStandartSkillChecks() {
    List<SkillCheck> ret = [];
    ret.add(SkillCheck("Акробатика", "dex", true));
    ret.add(SkillCheck("Анализ", "int", true));
    ret.add(SkillCheck("Атлетика", "str", true));
    ret.add(SkillCheck("Внимательность", "wis", true));
    ret.add(SkillCheck("Выживание", "wis", true));
    ret.add(SkillCheck("Выступление", "cha", true));
    ret.add(SkillCheck("Запугивание", "cha", true));
    ret.add(SkillCheck("История", "int", true));
    ret.add(SkillCheck("Ловкость рук", "dex", true));
    ret.add(SkillCheck("Магия", "int", true));
    ret.add(SkillCheck("Медицина", "wis", true));
    ret.add(SkillCheck("Обман", "cha", true));
    ret.add(SkillCheck("Природа", "int", true));
    ret.add(SkillCheck("Проницательность", "wis", true));
    ret.add(SkillCheck("Религия", "int", true));
    ret.add(SkillCheck("Скрытность", "dex", true));
    ret.add(SkillCheck("Убеждение", "cha", true));
    ret.add(SkillCheck("Уход за животными", "wis", true));
    return ret;
  }

  bool get protected => _protected;

  String get code => _code;

  set code(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _code = value;
  }

  String get name => _name;

  set name(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _name = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillCheck &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _code == other._code &&
          _protected == other._protected;

  @override
  int get hashCode => _name.hashCode ^ _code.hashCode ^ _protected.hashCode;
}
