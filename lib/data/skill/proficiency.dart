import 'package:hive/hive.dart';

part 'package:dnd_companion/g_parts/proficiency.g.dart';

@HiveType(typeId: 72)
class Proficiency {

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  String _mark;
  @HiveField(3)
  Set<Proficiency> _includes;
  @HiveField(4)
  bool _protected;

  //TODO print classes and races with this proficiency

  Proficiency(this._name, this._description, this._mark, this._includes, this._protected);

  Proficiency.smart({
    required String name,
    String description = "",
    required String mark,
    Set<Proficiency>? includes,
    bool protected = false,
  })  : _name = name,
        _description = description,
        _mark = mark,
        _includes = includes ?? {},
        _protected = protected;

  //Proficiency.copyFrom(Proficiency object){
  //  _name = object.name;
  //  _description = object.description;
  //  _protected = false;
  //}

  static Future<void> unpack(Box<Proficiency> proficiencies) async {
    proficiencies.put("light armor", Proficiency.smart(name: "Лёгкие доспехи", mark: "лёгкий"));
    proficiencies.put("medium armor", Proficiency.smart(name: "Лёгкие и средние доспехи", mark: "средний", includes: {proficiencies.get("light armor")!}));
    proficiencies.put("all armor", Proficiency.smart(name: "Любые доспехи", mark: "тяжелый", includes: {proficiencies.get("light armor")!, proficiencies.get("medium armor")!}));
    proficiencies.put("simple weapons", Proficiency.smart(name: "Простое оружие", mark: "простое"));
    proficiencies.put("martial weapons", Proficiency.smart(name: "Воинское оружие", mark: "воинское"));
    proficiencies.put("shields", Proficiency.smart(name: "Щиты", mark: "щит"));
    proficiencies.put("hand crossbows", Proficiency.smart(name: "Ручные арбалеты", mark: "ручной арбалет"));
    proficiencies.put("longswords", Proficiency.smart(name: "Длинные мечи", mark: "длинный меч"));
    proficiencies.put("rapiers", Proficiency.smart(name: "Рапиры", mark: "рапира"));
    proficiencies.put("shortswords", Proficiency.smart(name: "Короткие мечи", mark: "короткий меч"));
    proficiencies.put("clubs", Proficiency.smart(name: "Дубинки", mark: "дубинка"));
    proficiencies.put("daggers", Proficiency.smart(name: "Кинжалы", mark: "кинжал"));
    proficiencies.put("darts", Proficiency.smart(name: "Дротики", mark: "дротик"));
    proficiencies.put("javelins", Proficiency.smart(name: "Метательные копья", mark: "метательное копьё"));
    proficiencies.put("maces", Proficiency.smart(name: "Булавы", mark: "булава"));
    proficiencies.put("quarterstaffs", Proficiency.smart(name: "Боевые посохи", mark: "боевой посох"));
    proficiencies.put("scimitars", Proficiency.smart(name: "Скимитары", mark: "скимитар"));
    proficiencies.put("sickles", Proficiency.smart(name: "Серпы", mark: "серп"));
    proficiencies.put("slings", Proficiency.smart(name: "Пращи", mark: "праща"));
    proficiencies.put("spears", Proficiency.smart(name: "Копья", mark: "копьё"));
    proficiencies.put("battleaxes", Proficiency.smart(name: "Боевые топоры", mark: "боевой топор"));
    proficiencies.put("handaxes", Proficiency.smart(name: "Ручные топоры", mark: "ручной топор"));
    proficiencies.put("throwing hammers", Proficiency.smart(name: "Лёгкие молоты", mark: "лёгкий молот"));
    proficiencies.put("warhammers", Proficiency.smart(name: "Боевые молоты", mark: "боевой молот"));
    proficiencies.put("smith's tools", Proficiency.smart(name: "Инструменты кузнеца", mark: "инструменты кузнеца"));
    proficiencies.put("brewer's supplies", Proficiency.smart(name: "Инструменты пивовара", mark: "инструменты пивовара"));
    proficiencies.put("mason's tools", Proficiency.smart(name: "Инструменты каменщика", mark: "инструменты каменщика"));
    proficiencies.put("shortbows", Proficiency.smart(name: "Короткие луки", mark: "короткий"));
    proficiencies.put("longbows", Proficiency.smart(name: "Длинные луки", mark: "длинный"));
    return;
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

  String get mark => _mark;

  set mark(String value) {
    _mark = value;
  }

  Set<Proficiency> get includes => _includes;

  set includes(Set<Proficiency> value) {
    _includes = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Proficiency &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _mark == other._mark &&
          _includes == other._includes &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _mark.hashCode ^
      _includes.hashCode ^
      _protected.hashCode;
}
