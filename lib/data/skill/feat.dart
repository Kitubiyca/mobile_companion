import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/stats.dart';
import 'package:hive/hive.dart';

class Feat {

  //TODO нормальные система требований
  //TODO нормальная система черт

  String _name;
  List<String> _description;
  String _requirement;
  Map<Stats, int> _benefits;
  bool _protected;

  Feat(this._name, this._description, this._requirement, this._benefits,
      this._protected);

  Feat.smart({
    required String name,
    List<String>? description,
    String requirement = "",
    Map<Stats, int>? benefits,
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

  static Future<void> unpack(Box<Feat> feats) async {
    await feats.put("actor", Feat.smart(name: "Артистичный", benefits: {Stats.charisma: 1}, description: ["Научившись театральному искусству и подражанию, вы получаете следующие преимущества:", "Увеличьте значение Харизмы на 1 при максимуме 20.", "Вы совершаете с преимуществом проверки Харизмы (Выступление) и Харизма (Обман), когда пытаетесь выдать себя за кого-то другого.", "Вы можете подражать речи кого-то другого, а также звукам, издаваемым другими существами. Перед этим вы должны как минимум в течение 1 минуты слышать чужую речь или звуки существа. Успешная проверка Мудрости (Проницательность), противопоставленная вашей проверке Харизмы (Обман), позволяет слушающему понять, что источник звука не настоящий."], ));
    await feats.put("athlete", Feat.smart(name: "Атлетичный", benefits: {Stats.strength: 1, Stats.dexterity: 1}, description: ["Вы прошли интенсивную физическую подготовку и получаете следующие преимущества:", "Увеличьте значение Силы или Ловкости на 1 при максимуме 20.", "Если вы лежите ничком, вставание использует только 5 футов перемещения.", "Лазание не заставляет вас тратить дополнительное перемещение.", "Вы можете совершать прыжок в длину или высоту с разбега, переместившись только на 5 футов, а не на 10."], ));
    await feats.put("alert", Feat.smart(name: "Бдительный", benefits: {Stats.initiative: 5}, description: ["Вы всегда готовы к опасностям и получаете следующие преимущества:", "Вы получаете бонус +5 к проверкам инициативы.", "Вас не могут застать врасплох, пока вы в сознании.", "Другие существа не получают преимущество для бросков атаки по вам за то, что они скрыты от вас."], ));
    await feats.put("war caster", Feat.smart(name: "Боевой заклинатель", requirement: "Умение накладывать хотя бы одно заклинание", benefits: {}, description: ["Вы совершаете с преимуществом спасброски Телосложения для поддержания концентрации на заклинании при получении урона.", "Вы совершаете с преимуществом спасброски Телосложения для поддержания концентрации на заклинании при получении урона.", "Вы можете выполнять соматический компонент заклинаний, даже если используете оружие или щит в одной или обеих руках.", "Если перемещение враждебного существа провоцирует от вас атаку, вы можете вместо совершения провоцированной атаки реакцией наложить на это существо заклинание. Время накладывания этого заклинания должно быть «1 действие», и оно должно нацеливаться только на это существо."], ));
    await feats.put("grappler", Feat.smart(name: "Борец", requirement: "Сила 13 или выше", benefits: {}, description: ["Вы развили навыки, нужные для тесного захвата противников. Вы получаете следующие преимущества:", "Вы совершаете с преимуществом броски атаки по существу, которое держите в захвате.", "Вы можете действием попытаться скрутить захваченное вами существо. Для этого совершите ещё одну проверку захвата. В случае успеха и вы и это существо становитесь опутанными до окончания захвата."], ));
  }

  bool get protected => _protected;

  set protected(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _protected = value;
  }

  Map<Stats, int> get benefits => _benefits;

  set benefits(Map<Stats, int> value) {
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
