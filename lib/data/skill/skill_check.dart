import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:hive/hive.dart';

class SkillCheck { // Навык

  String _name;
  Characteristic _characteristic;
  bool _protected;

  SkillCheck(this._name, this._characteristic, this._protected);

  SkillCheck.smart({
    required String name,
    required Characteristic code,
    bool protected = false,
  })  : _name = name,
        _characteristic = code,
        _protected = protected;

  //SkillCheck.copyFrom(SkillCheck object){
  //  _name = object.name;
  //  _code = object.code;
  //  _protected = false;
  //}

  static Future<void> unpack(Box<SkillCheck> skillChecks) async {
    await skillChecks.put("acrobatics", SkillCheck("Акробатика", Characteristic.dexterity, true));
    await skillChecks.put("investigation", SkillCheck("Анализ", Characteristic.intelligence, true));
    await skillChecks.put("athletics", SkillCheck("Атлетика", Characteristic.strength, true));
    await skillChecks.put("perception", SkillCheck("Внимательность", Characteristic.wisdom, true));
    await skillChecks.put("survival", SkillCheck("Выживание", Characteristic.wisdom, true));
    await skillChecks.put("performance", SkillCheck("Выступление", Characteristic.charisma, true));
    await skillChecks.put("intimidation", SkillCheck("Запугивание", Characteristic.charisma, true));
    await skillChecks.put("history", SkillCheck("История", Characteristic.intelligence, true));
    await skillChecks.put("sleight of hand", SkillCheck("Ловкость рук", Characteristic.dexterity, true));
    await skillChecks.put("arcana", SkillCheck("Магия", Characteristic.intelligence, true));
    await skillChecks.put("medicine", SkillCheck("Медицина", Characteristic.wisdom, true));
    await skillChecks.put("deception", SkillCheck("Обман", Characteristic.charisma, true));
    await skillChecks.put("nature", SkillCheck("Природа", Characteristic.intelligence, true));
    await skillChecks.put("insight", SkillCheck("Проницательность", Characteristic.wisdom, true));
    await skillChecks.put("religion", SkillCheck("Религия", Characteristic.intelligence, true));
    await skillChecks.put("stealth", SkillCheck("Скрытность", Characteristic.dexterity, true));
    await skillChecks.put("persuasion", SkillCheck("Убеждение", Characteristic.charisma, true));
    await skillChecks.put("animal handling", SkillCheck("Уход за животными", Characteristic.wisdom, true));
    return;
  }

  bool get protected => _protected;

  Characteristic get characteristic => _characteristic;

  set characteristic(Characteristic value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _characteristic = value;
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
          _characteristic == other._characteristic &&
          _protected == other._protected;

  @override
  int get hashCode => _name.hashCode ^ _characteristic.hashCode ^ _protected.hashCode;
}
