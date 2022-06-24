import 'package:hive/hive.dart';

part 'proficiency.g.dart';

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
    await proficiencies.put("light armor", Proficiency.smart(name: "Лёгкие доспехи", mark: "лёгкий"));
    await proficiencies.put("medium armor", Proficiency.smart(name: "Лёгкие и средние доспехи", mark: "средний", includes: {proficiencies.get("light armor")!}));
    await proficiencies.put("all armor", Proficiency.smart(name: "Любые доспехи", mark: "тяжелый", includes: {proficiencies.get("light armor")!, proficiencies.get("medium armor")!}));
    await proficiencies.put("simple weapons", Proficiency.smart(name: "Простое оружие", mark: "простое"));
    await proficiencies.put("martial weapons", Proficiency.smart(name: "Воинское оружие", mark: "воинское"));
    await proficiencies.put("shields", Proficiency.smart(name: "Щиты", mark: "щит"));
    await proficiencies.put("hand crossbows", Proficiency.smart(name: "Ручные арбалеты", mark: "ручной арбалет"));
    await proficiencies.put("longswords", Proficiency.smart(name: "Длинные мечи", mark: "длинный меч"));
    await proficiencies.put("rapiers", Proficiency.smart(name: "Рапиры", mark: "рапира"));
    await proficiencies.put("shortswords", Proficiency.smart(name: "Короткие мечи", mark: "короткий меч"));
    await proficiencies.put("clubs", Proficiency.smart(name: "Дубинки", mark: "дубинка"));
    await proficiencies.put("daggers", Proficiency.smart(name: "Кинжалы", mark: "кинжал"));
    await proficiencies.put("darts", Proficiency.smart(name: "Дротики", mark: "дротик"));
    await proficiencies.put("javelins", Proficiency.smart(name: "Метательные копья", mark: "метательное копьё"));
    await proficiencies.put("maces", Proficiency.smart(name: "Булавы", mark: "булава"));
    await proficiencies.put("quarterstaffs", Proficiency.smart(name: "Боевые посохи", mark: "боевой посох"));
    await proficiencies.put("scimitars", Proficiency.smart(name: "Скимитары", mark: "скимитар"));
    await proficiencies.put("sickles", Proficiency.smart(name: "Серпы", mark: "серп"));
    await proficiencies.put("slings", Proficiency.smart(name: "Пращи", mark: "праща"));
    await proficiencies.put("spears", Proficiency.smart(name: "Копья", mark: "копьё"));
    await proficiencies.put("battleaxes", Proficiency.smart(name: "Боевые топоры", mark: "боевой топор"));
    await proficiencies.put("handaxes", Proficiency.smart(name: "Ручные топоры", mark: "ручной топор"));
    await proficiencies.put("throwing hammers", Proficiency.smart(name: "Лёгкие молоты", mark: "лёгкий молот"));
    await proficiencies.put("warhammers", Proficiency.smart(name: "Боевые молоты", mark: "боевой молот"));
    await proficiencies.put("smith's tools", Proficiency.smart(name: "Инструменты кузнеца", mark: "инструменты кузнеца"));
    await proficiencies.put("brewer's supplies", Proficiency.smart(name: "Инструменты пивовара", mark: "инструменты пивовара"));
    await proficiencies.put("mason's tools", Proficiency.smart(name: "Инструменты каменщика", mark: "инструменты каменщика"));
    await proficiencies.put("shortbows", Proficiency.smart(name: "Короткие луки", mark: "короткий"));
    await proficiencies.put("longbows", Proficiency.smart(name: "Длинные луки", mark: "длинный"));
    await proficiencies.put("dice sets", Proficiency.smart(name: "Кости", mark: "кости"));
    await proficiencies.put("vehicles(land)", Proficiency.smart(name: "Транспорт (сухопутный)", mark: "транспорт (сухопутный)"));
    await proficiencies.put("herbalism kit", Proficiency.smart(name: "Набор травника", mark: "набор травника"));
    await proficiencies.put("navigators tools", Proficiency.smart(name: "Инструменты навигатора", mark: "инструмент навигатора"));
    await proficiencies.put("vehicles(water)", Proficiency.smart(name: "Транспорт (водный)", mark: "транспорт (водный)"));
    await proficiencies.put("thieves tools", Proficiency.smart(name: "Воровские инструменты", mark: "воровской инструмент"));
    await proficiencies.put("disguise kit", Proficiency.smart(name: "Набор для гримма", mark: "набор для гримма"));
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
