class SkillCheck {

  String _name;
  String _code;
  bool _protected;

  List<SkillCheck> skills = [];
  
  SkillCheck(this._name, this._code, this._protected){skills.add(this);}

  static List<SkillCheck> getStandartSkills() {
    List<SkillCheck> skills = [];
    skills.add(SkillCheck("Акробатика", "dex", true));
    skills.add(SkillCheck("Анализ", "int", true));
    skills.add(SkillCheck("Атлетика", "str", true));
    skills.add(SkillCheck("Внимательность", "wis", true));
    skills.add(SkillCheck("Выживание", "wis", true));
    skills.add(SkillCheck("Выступление", "cha", true));
    skills.add(SkillCheck("Запугивание", "cha", true));
    skills.add(SkillCheck("История", "int", true));
    skills.add(SkillCheck("Ловкость рук", "dex", true));
    skills.add(SkillCheck("Магия", "int", true));
    skills.add(SkillCheck("Медицина", "wis", true));
    skills.add(SkillCheck("Обман", "cha", true));
    skills.add(SkillCheck("Природа", "int", true));
    skills.add(SkillCheck("Проницательность", "wis", true));
    skills.add(SkillCheck("Религия", "int", true));
    skills.add(SkillCheck("Скрытность", "dex", true));
    skills.add(SkillCheck("Убеждение", "cha", true));
    skills.add(SkillCheck("Уход за животными", "wis", true));
    return skills;
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
}