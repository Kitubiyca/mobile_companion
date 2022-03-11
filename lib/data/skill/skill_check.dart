class SkillCheck {

  late String _name;
  late String _code;
  late bool _protected;

  static List<SkillCheck> skills = [];
  
  SkillCheck(this._name, this._code, this._protected);

  SkillCheck.withAdd(this._name, this._code, this._protected){skills.add(this);}

  SkillCheck.copyFrom(SkillCheck object){
    _name = object.name;
    _code = object.code;
    _protected = false;
  }

  static List<SkillCheck> getStandartSkills() {
    List<SkillCheck> returnSkills = [];
    returnSkills.add(SkillCheck("Акробатика", "dex", true));
    returnSkills.add(SkillCheck("Анализ", "int", true));
    returnSkills.add(SkillCheck("Атлетика", "str", true));
    returnSkills.add(SkillCheck("Внимательность", "wis", true));
    returnSkills.add(SkillCheck("Выживание", "wis", true));
    returnSkills.add(SkillCheck("Выступление", "cha", true));
    returnSkills.add(SkillCheck("Запугивание", "cha", true));
    returnSkills.add(SkillCheck("История", "int", true));
    returnSkills.add(SkillCheck("Ловкость рук", "dex", true));
    returnSkills.add(SkillCheck("Магия", "int", true));
    returnSkills.add(SkillCheck("Медицина", "wis", true));
    returnSkills.add(SkillCheck("Обман", "cha", true));
    returnSkills.add(SkillCheck("Природа", "int", true));
    returnSkills.add(SkillCheck("Проницательность", "wis", true));
    returnSkills.add(SkillCheck("Религия", "int", true));
    returnSkills.add(SkillCheck("Скрытность", "dex", true));
    returnSkills.add(SkillCheck("Убеждение", "cha", true));
    returnSkills.add(SkillCheck("Уход за животными", "wis", true));
    return returnSkills;
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