import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';

class Spell {
  String _name;
  int _level;
  String _school;
  String _description;
  List<String> _higherDescription;
  int _range; // -1 - на себя, 0 - касание, больше 0 - футы
  bool _verbal;
  bool _somatic;
  Map<Item, int> _materials;
  bool _ritual;
  String _duration; // заменить на int
  bool _concentration;
  bool _bonus; // bonus action
  int _castingTime;

  // d20 + saving mod + (prof bonus)?
  String
      _savingModifier; // spell evasion difficulty(8 + prof bonus + spellcasting mod(magic save mod)) that target need to beat
  bool _armorPenetration; // d20 + class attack modifier vs target armor class

  DamageType _damageType;
  Map<int, List<Dice>> _impact;
  int _constImpact;

  bool _protected;

  Spell(
      this._name,
      this._level,
      this._school,
      this._description,
      this._higherDescription,
      this._range,
      this._verbal,
      this._somatic,
      this._materials,
      this._ritual,
      this._duration,
      this._concentration,
      this._bonus,
      this._castingTime,
      this._savingModifier,
      this._armorPenetration,
      this._damageType,
      this._impact,
      this._constImpact,
      this._protected); //print classes with this spell

  Spell.smart({
    String name = "",
    String description = "",
    List<String>? higherDescription,
    int range = 0,
    bool verbal = false,
    bool somatic = false,
    Map<Item, int>? materials,
    bool ritual = false,
    String duration = "мгновенная",
    bool concentration = false,
    bool bonus = false,
    int castingTime = 1,
    int level = 0,
    String school = "",
    String savingModifier = "",
    bool armorPenetration = false,
    DamageType? damageType,
    Map<int, List<Dice>>? impact,
    int constImpact = 0,
    bool protected = false,
  })  : _name = name,
        _description = description,
        _higherDescription = [],
        _range = range,
        _verbal = verbal,
        _somatic = somatic,
        _materials = materials ?? {},
        _ritual = ritual,
        _duration = duration,
        _concentration = concentration,
        _bonus = bonus,
        _castingTime = castingTime,
        _level = level,
        _school = school,
        _savingModifier = savingModifier,
        _armorPenetration = armorPenetration,
        _damageType = damageType ?? DamageType.empty(),
        _impact = impact ?? {},
        _constImpact = constImpact,
        _protected = protected;

  //Spell.copyFrom(Spell object){
  //  _name = object.name;
  //  _description = object.description;
  //  _cast = object.cast;
  //  _verbal = object.verbal;
  //  _somatic = object.somatic;
  //  _ritual = object.ritual;
  //  _concentration = object.concentration;
  //  _reaction = object.reaction;
  //  for(int i = 0; i < object.materials.length; i++){
  //    _materials[Item.copyFrom(object.materials.keys.elementAt(i))] = object.materials.values.elementAt(i);
  //  }
  //  for(int i = 0; i < object.levels.length; i++){
  //    _levels.add(SpellLevel.copyFrom(object.levels[i]));
  //  }
  //  _protected = false;
  //}

  List<String> getDices() {
    List<String> ret = [];
    for (int i = 0; i < _impact.keys.length; i++) {
      String elem = "";
      if (_impact.values.elementAt(i).isNotEmpty) {
        elem += _impact.values.elementAt(i)[0].name;
        for (int j = 1; j < _impact.length; j++) {
          elem += ", " + _impact.values.elementAt(i)[j].name;
        }
        ret.add(elem);
      }
    }
    return ret;
  }

  String getMarks() {
    String ret = "";
    bool first = true;
    if (_verbal) {
      ret += "V";
      first = false;
    }
    if (_somatic) {
      if (first)
        ret += "S";
      else
        ret += ", S";
      first = false;
    }
    if (_materials.isNotEmpty) {
      if (first)
        ret += "M";
      else
        ret += ", M";
      first = false;
    }
    if (_ritual) {
      if (first)
        ret += "R";
      else
        ret += ", R";
      first = false;
    }
    if (_concentration) {
      if (first)
        ret += "C";
      else
        ret += ", C";
      first = false;
    }
    return ret;
  }

  String getMaterials() {
    String ret = "";
    if (_materials.isNotEmpty) {
      ret += _materials.keys.elementAt(0).name +
          ": " +
          _materials.values.elementAt(0).toString();
      for (int i = 1; i < _materials.keys.length; i++) {
        ret += ", " +
            _materials.keys.elementAt(i).name +
            ": " +
            _materials.values.elementAt(i).toString();
      }
    }
    return ret;
  }

  static List<Spell> getStandartSpells() {
    List<Spell> spells = [];
    spells.add(Spell.smart(
        level: 9,
        school: "воплощение",
        name: "Метеоритный дождь",
        castingTime: 1,
        range: 5280,
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        savingModifier: "dex",
        impact: {
          0: [Dice(20, 6), Dice(20, 6)]
        },
        damageType: DamageType.smart(fire: true, bludgeoning: true),
        description:
            "Пылающие шары ударяют о землю в четырёх разных точках, видимых в пределах дистанции. Все существа в сфере с радиусом 40 футов с центром на каждой из точек должны совершить спасбросок Ловкости. Сфера огибает углы. Существо получает при провале 20к6 урона огнём и 20к6 дробящего урона, или половину урона при успехе. Существо, находящееся в области двух взрывов получает урон только один раз.\n\nЗаклинание наносит урон предметам и воспламеняет горючие предметы, которые никто не несёт и не носит."));
    spells.add(Spell.smart(
        level: 9,
        school: "вызов",
        name: "Исполнение желаний",
        castingTime: 1,
        range: -1,
        verbal: true,
        duration: "мгновенная",
        description: ""));
    spells.add(Spell.smart(
        level: 0,
        school: "очарование",
        name: "Злая насмешка",
        castingTime: 1,
        range: 60,
        verbal: true,
        duration: "мгновенная",
        impact: {
          0: [Dice(1, 4)],
          5: [Dice(2, 4)],
          11: [Dice(3, 4)],
          17: [Dice(4, 4)]
        },
        damageType: DamageType.smart(psychic: true),
        savingModifier: "wis",
        description:
            "Вы испускаете на существо, видимое в пределах дистанции, поток оскорблений вперемешку с тонкой магией. Если цель слышит вас (при этом она не обязана вас понимать), она должна преуспеть в спасброске Мудрости, иначе получит урон психической энергией 1к4, и следующий бросок атаки до конца своего следующего хода совершит с помехой.\n\nУрон этого заклинания увеличивается на 1к4, когда вы достигаете 5-го уровня (2к4), 11-го уровня (3к4) и 17-го уровня (4к4).",
        higherDescription: [
          "5-ый уровень класса: урон равен 2к4",
          "11-ый уровень класса: урон равен 3к4",
          "17-ый уровень класса: урон равен 4к4"
        ]));
    spells.add(Spell.smart(
        level: 0,
        school: "воплощение",
        name: "Огненный снаряд",
        castingTime: 1,
        range: 120,
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        impact: {
          0: [Dice(1, 10)],
          5: [Dice(2, 10)],
          11: [Dice(3, 10)],
          17: [Dice(4, 10)]
        },
        damageType: DamageType.smart(fire: true),
        description:
            "Вы кидаете сгусток огня в существо или предмет в пределах дистанции. Совершите по цели дальнобойную атаку заклинанием. При попадании цель получает урон огнём 1к10. Горючие предметы, по которым попало это заклинание, воспламеняются, если их никто не несет и не носит.\n\nУрон этого заклинания увеличивается на 1к10, когда вы достигаете 5-го уровня (2к10), 11-го уровня (3к10), 17-го уровня (4к10).",
        higherDescription: [
          "5-ый уровень класса: урон равен 2к10",
          "11-ый уровень класса: урон равен 3к10",
          "17-ый уровень класса: урон равен 4к10"
        ]));
    spells.add(Spell.smart(
        level: 0,
        school: "воплощение",
        name: "Мистический заряд",
        castingTime: 1,
        range: 120,
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        impact: {
          0: [Dice(1, 4)],
          5: [Dice(2, 4)],
          11: [Dice(3, 4)],
          17: [Dice(4, 4)]
        },
        damageType: DamageType.smart(force: true),
        description:
            "К существу, находящемуся в пределах дистанции, устремляется луч потрескивающей энергии. Совершите дальнобойную атаку заклинанием по цели. При попадании цель получает урон силовым полем 1к10.\n\nЗаклинание создаёт ещё один луч, когда вы достигаете больших уровней: два луча на 5-м уровне, три луча на 11-м уровне и четыре луча на 17-м уровне.\n\nВы можете направить лучи в одну цель или в разных. Для каждого луча совершите свой бросок атаки.",
        higherDescription: [
          "5-ый уровень класса: количество лучей равно двум",
          "11-ый уровень класса: количество лучей равно трём",
          "17-ый уровень класса: количество лучей равно четырём"
        ]));
    spells.add(Spell.smart(
        level: 1,
        school: "очарование",
        name: "Жуткий смех Таши",
        castingTime: 1,
        range: 30,
        verbal: true,
        somatic: true,
        materials: {
          Item.smart(
              name:
                  "маленькие пирожные и перо, которым нужно махать в воздухе"): 1
        },
        duration: "вплоть до одной минуты",
        concentration: true,
        savingModifier: "wis",
        description:
            "Существо на ваш выбор, видимое в пределах дистанции, воспринимает всё невероятно смешным и корчится от смеха, если заклинание на него действует. Цель должна преуспеть в спасброске Мудрости, иначе она падает ничком, становится недееспособной и в течение действия заклинания не может встать. Существа со значением Интеллекта 4 и ниже не попадают под действие этого заклинания.\n\nВ конце каждого своего хода и каждый раз при получении урона цель может совершать новый спасбросок Мудрости. Спасбросок совершается с преимуществом, если он был вызван получением урона. При успехе заклинание оканчивается."));
    spells.add(Spell.smart(
      level: 1,
      school: "ограждение",
      name: "Доспехи мага",
      castingTime: 1,
      range: 0,
      verbal: true,
      somatic: true,
      materials: {Item.smart(name: "Кусочек выделанной кожи"): 1},
      duration: "8 часов",
      description:
          "Вы касаетесь согласного существа, не носящего доспех, и на время действия заклинания его окутывает защитное магическое поле. Базовый КД существа становится равен 13 + его модификатор Ловкости. Заклинание оканчивается, если цель надевает доспех или вы оканчиваете его действием.",
    ));
    spells.add(Spell.smart(
      level: 2,
      school: "иллюзия",
      name: "Невидимость",
      castingTime: 1,
      range: 0,
      verbal: true,
      somatic: true,
      materials: {Item.smart(name: "Ресница в смоле"): 1},
      concentration: true,
      duration: "вплоть до одного часа",
      description:
          "Существо, которого вы касаетесь, становится невидимым до окончания действия заклинания. Все, что цель несет или носит, становится невидимым, пока остается у неё. Заклинание оканчивается на цели, если она совершает атаку или накладывает заклинание.",
      higherDescription: [
        "Если вы накладываете это заклинание, используя ячейку 3-го уровня или выше, вы можете сделать целью одно дополнительное существо за каждый уровень ячейки выше второго.Если вы накладываете это заклинание, используя ячейку 3-го уровня или выше, вы можете сделать целью одно дополнительное существо за каждый уровень ячейки выше второго."
      ],
    ));
    spells.add(Spell.smart(
      level: 2,
      school: "вызов",
      name: "Туманный шаг",
      bonus: true,
      castingTime: 1,
      range: -1,
      verbal: true,
      duration: "мгновенная",
      description: "Окутавшись серебристым туманом, вы телепортируетесь на 30 футов в свободное пространство, видимое вами.",
    ));
    spells.add(Spell.smart(
      level: 2,
      school: "преобразование",
      name: "Трюк с верёвкой",
      castingTime: 1,
      range: 0,
      verbal: true,
      somatic: true,
      materials: {Item.smart(name: "Экстракт зерна и петля из пергамента"): 1},
      duration: "1 час",
      description: "Вы касаетесь верёвки длиной до 60 футов. Один её конец поднимается в воздух, а остальная часть висит перпендикулярно полу. На верхнем конце верёвки появляется невидимый вход в межпространство, существующий, пока заклинание активно.\n\nВ межпространство можно попасть забравшись по верёвке наверх. В этом межпространстве может поместиться восемь существ с размером не больше Среднего. Верёвку можно затянуть внутрь, после чего снаружи её не будет видно.\n\nАтаки и заклинания не могут проходить через вход внутрь межпространства и наружу, но те, кто находятся внутри, могут все видеть как через окно 3 × 5 футов с центром на верёвке.\n\nВсё, что находится в межпространстве, вываливается наружу, когда заклинание оканчивается.",
    ));
    spells.add(Spell.smart(
      level: 3,
      school: "воплощение",
      name: "Огненный шар",
      castingTime: 1,
      range: 150,
      verbal: true,
      somatic: true,
      materials: {Item.smart(name: "крошечный шарик из гуано летучей мыши и серы"): 1},
      duration: "мгновенная",
        savingModifier: "dex",
        damageType: DamageType.smart(fire: true),
        impact: {0: [Dice(8, 6)], 4: [Dice(9, 6)], 5: [Dice(10, 6)], 6: [Dice(11, 6)], 7: [Dice(12, 6)], 8: [Dice(13, 6)], 9: [Dice(14, 6)]},
      description: "Яркий луч вылетает из вашего указательного пальца в точку, выбранную вами в пределах дистанции, где и происходит взрыв пламени с гулким ревом. Все существа в пределах сферы с радиусом 20 футов с центром в этой точке должны совершить спасбросок Ловкости. Цель получает 8к6 урона огнём при провале или половину этого урона при успехе. Этот огонь огибает углы. Он воспламеняет горючие предметы, которые никто не несет и не носит.",
      higherDescription: ["Если вы накладываете это заклинание, используя ячейку 4-го уровня или выше, урон увеличивается на 1к6 за каждый уровень ячейки выше третьего."],
    ));
    return spells;
  }

  bool get protected => _protected;

  int get constImpact => _constImpact;

  set constImpact(int value) {
    _constImpact = value;
  }

  Map<int, List<Dice>> get impact => _impact;

  set impact(Map<int, List<Dice>> value) {
    _impact = value;
  }

  DamageType get damageType => _damageType;

  set damageType(DamageType value) {
    _damageType = value;
  }

  String get savingModifier => _savingModifier;

  set savingModifier(String value) {
    _savingModifier = value;
  }

  bool get armorPenetration => _armorPenetration;

  set armorPenetration(bool value) {
    _armorPenetration = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  int get castingTime => _castingTime;

  set castingTime(int value) {
    _castingTime = value;
  }

  bool get concentration => _concentration;

  set concentration(bool value) {
    _concentration = value;
  }

  String get duration => _duration;

  set duration(String value) {
    _duration = value;
  }

  bool get ritual => _ritual;

  set ritual(bool value) {
    _ritual = value;
  }

  Map<Item, int> get materials => _materials;

  set materials(Map<Item, int> value) {
    _materials = value;
  }

  bool get somatic => _somatic;

  set somatic(bool value) {
    _somatic = value;
  }

  bool get verbal => _verbal;

  set verbal(bool value) {
    _verbal = value;
  }

  int get range => _range;

  set range(int value) {
    _range = value;
  }

  List<String> get higherDescription => _higherDescription;

  set higherDescription(List<String> value) {
    _higherDescription = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get school => _school;

  set school(String value) {
    _school = value;
  }

  bool get bonus => _bonus;

  set bonus(bool value) {
    _bonus = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spell &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _level == other._level &&
          _school == other._school &&
          _description == other._description &&
          _higherDescription == other._higherDescription &&
          _range == other._range &&
          _verbal == other._verbal &&
          _somatic == other._somatic &&
          _materials == other._materials &&
          _ritual == other._ritual &&
          _duration == other._duration &&
          _concentration == other._concentration &&
          _bonus == other._bonus &&
          _castingTime == other._castingTime &&
          _savingModifier == other._savingModifier &&
          _armorPenetration == other._armorPenetration &&
          _damageType == other._damageType &&
          _impact == other._impact &&
          _constImpact == other._constImpact &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _level.hashCode ^
      _school.hashCode ^
      _description.hashCode ^
      _higherDescription.hashCode ^
      _range.hashCode ^
      _verbal.hashCode ^
      _somatic.hashCode ^
      _materials.hashCode ^
      _ritual.hashCode ^
      _duration.hashCode ^
      _concentration.hashCode ^
      _bonus.hashCode ^
      _castingTime.hashCode ^
      _savingModifier.hashCode ^
      _armorPenetration.hashCode ^
      _damageType.hashCode ^
      _impact.hashCode ^
      _constImpact.hashCode ^
      _protected.hashCode;
}
