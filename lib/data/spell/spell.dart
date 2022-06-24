import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

part 'spell.g.dart';

@HiveType(typeId: 81)
class Spell {

  //TODO вывод заклинаний по классам
  //TODO print classes with this spell

  @HiveField(0)
  String _name;
  @HiveField(1)
  int _level;
  @HiveField(2)
  String _school;
  @HiveField(3)
  String _description;
  @HiveField(4)
  List<String> _higherDescription;
  @HiveField(5)
  String _range; // OLD -1 - на себя, 0 - касание, больше 0 - футы
  @HiveField(6)
  bool _verbal;
  @HiveField(7)
  bool _somatic;
  @HiveField(8)
  Map<Item, bool> _materials; // true=consumable // simple = without price, count=0; advanced = with price, count=0; consumable = with price, count>0
  @HiveField(9)
  bool _ritual;
  @HiveField(10)
  String _duration; // заменить на int
  @HiveField(11)
  bool _concentration;
  @HiveField(12)
  bool _bonus; // bonus action
  @HiveField(13)
  int _castingTime;

  // d20 + saving mod + (prof bonus)?
  @HiveField(14)
  Characteristic
      _savingModifier; // spell evasion difficulty(8 + prof bonus + spellcasting mod(magic save mod)) that target need to beat
  @HiveField(15)
  bool _armorPenetration; // d20 + class attack modifier vs target armor class

  @HiveField(16)
  Map<int, Map<DamageType, List<Dice>>> _impact;

  @HiveField(17)
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
      this._impact,
      this._protected);

  Spell.smart({
    String name = "",
    String description = "",
    List<String>? higherDescription,
    String range = "на себя",
    bool verbal = false,
    bool somatic = false,
    Map<Item, bool>? materials,
    bool ritual = false,
    String duration = "мгновенная",
    bool concentration = false,
    bool bonus = false,
    int castingTime = 1,
    int level = 0,
    String school = "",
    Characteristic? savingModifier,
    bool armorPenetration = false,
    Map<int, Map<DamageType, List<Dice>>>? impact,
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
        _savingModifier = savingModifier ?? Characteristic.none,
        _armorPenetration = armorPenetration,
        _impact = impact ?? {},
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

  Map<int, String> getStringImpact() {
    Map<int, String> ret = {};
    for (int level in _impact.keys) {
      String elem = "";
      for (DamageType damageType in _impact[level]!.keys) {
        if(_impact[level]![damageType]!.isNotEmpty) {
          elem += damageType.getText() + ": ";
          for (Dice dice in _impact[level]![damageType]!) {
            elem += dice.name + ", ";
          }
        }
      }
      elem = elem.substring(0, elem.length - 2);
      ret[level] = elem;
    }
    return ret;
  }

  // Map<int, Map<DamageType, List<Dice>>> _impact;

  String getComponents(){
    String ret = "";
    if(_verbal) ret += "В, ";
    if(_somatic) ret += "С, ";
    if(_materials.isNotEmpty){
      if(ret.length > 2) ret.substring(0, ret.length - 2);
      ret += "М (";
      for(Item element in _materials.keys){
        ret += element.name;
        if(element.cost > 0) {
          ret += ", стоимостью как минимум " + element.cost.toString();
          if (_materials[element]!) ret += ", расходуется заклинанием";
        }
        ret += ", ";
      }
      ret = ret.substring(0, ret.length - 2);
      ret += ")";
    } else {
      if(ret.length > 2) ret = ret.substring(0, ret.length - 2);
    }
    return ret;
  }

  String getDuration(){
    if(concentration){
      return "концентрация, " + duration;
    } else {
      return duration;
    }
  }

  String getCastingTime(){
    if(bonus){
      return _castingTime.toString() + " бонусное действие";
    } else {
      return _castingTime.toString() + " действие";
    }
  }

  @Deprecated("")
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

  @Deprecated("выводит только простые материалы")
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

  AssetImage getImage(){
    switch(school){
      case "воплощение": return const AssetImage("resources/icons/magic/incarnation.png");
      case "вызов": return const AssetImage("resources/icons/magic/invocation1.png");
      case "иллюзия": return const AssetImage("resources/icons/magic/illusion.png");
      case "некромантия": return const AssetImage("resources/icons/magic/necromancy.png");
      case "ограждение": return const AssetImage("resources/icons/magic/protection.png");
      case "очарование": return const AssetImage("resources/icons/magic/charm.png");
      case "преобразование": return const AssetImage("resources/icons/magic/transmutation.png");
      case "прорицание": return const AssetImage("resources/icons/magic/prophecy.png");
      default: return const AssetImage("resources/icons/question-mark.png");
    }
}

String getStringLevel(){
    if(_level == 0){
      return "заговор";
    } else {
      return "уровень " + _level.toString();
    }
}

  static Future<void> unpack(Box<Spell> spells, Box<Item> items) async {
    await spells.put("meteor swarm", Spell.smart(
        level: 9,
        school: "воплощение",
        name: "Метеоритный дождь",
        castingTime: 1,
        range: "1 миля",
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        savingModifier: Characteristic.dexterity,
        impact: {
          9: {DamageType.fire: [Dice(20, 6, 0)], DamageType.bludgeoning: [Dice(20, 6, 0)]}
            },
        protected: true,
        description:
            "Пылающие шары ударяют о землю в четырёх разных точках, видимых в пределах дистанции. Все существа в сфере с радиусом 40 футов с центром на каждой из точек должны совершить спасбросок Ловкости. Сфера огибает углы. Существо получает при провале 20к6 урона огнём и 20к6 дробящего урона, или половину урона при успехе. Существо, находящееся в области двух взрывов получает урон только один раз.\n\nЗаклинание наносит урон предметам и воспламеняет горючие предметы, которые никто не несёт и не носит."));
    await spells.put("wish", Spell.smart(
        level: 9,
        school: "вызов",
        name: "Исполнение желаний",
        castingTime: 1,
        range: "на себя",
        verbal: true,
        duration: "мгновенная",
        protected: true,
        description: "Исполнение желаний [wish] — это самое мощное заклинание, которое могут накладывать смертные. Высказав вслух свои пожелания, вы можете изменить основы мироздания.\n\nБазовое применение этого заклинания — это дублирование эффектов любого заклинания с уровнем не больше 8-го. Вы не обязаны выполнять требования этих заклинаний, включая стоимость дорогих компонентов. Заклинание просто начинает оказывать свой эффект.\n\nВ качестве альтернативы вы можете создать один из следующих эффектов на свой выбор:\n\n\u{25CF}Вы создаёте один предмет, стоящий до 25 000 зм, не являющийся волшебным. Этот предмет не может превышать ни в одном измерении 300 футов и он появляется в свободном пространстве, видимом вами, на земле.\n\u{25CF}Вы позволяете до двенадцати другим существам, видимым вами, восстановить все хиты, и вы оканчиваете все действующие на них эффекты, описанные в заклинании высшее восстановление [greater restoration].\n\u{25CF}Вы даруете до десяти существам, видимым вами, сопротивление выбранному вами виду урона.\n\u{25CF}Вы даруете до десяти существам, видимым вами, иммунитет к одному заклинанию или другому магическому эффекту на 8 часов. Например, вы можете даровать себе и всем своим спутникам иммунитет к вытягивающей жизнь атаке лича [lich].\n\u{25CF}Вы отменяете одно недавно произошедшее событие, заставив перебросить любой бросок, совершённый в последнем раунде (включая ваш последний ход). Реальность будет сформирована заново, согласно новому результату. Например, заклинание исполнение желаний может отменить успешный спасбросок противника, его критическое попадание, или проваленный спасбросок друга. Вы можете даровать помеху или преимущество к броску, и можете либо выбрать новый результат, либо оставить старый.\n\u{25CF}Вы можете попытаться получить эффект, отличный от приведённых примеров. Максимально точно передайте желание Мастеру. Мастер обладает широкой свободой выбора при вынесении суждения о том, что произошло; чем больше желание, тем больше вероятность того, что что-то пойдёт не так. Это заклинание может просто провалиться, желаемый эффект может осуществиться лишь частично, или же вы можете претерпеть непредвиденные последствия из-за формулировки желания. Например, желание, чтобы злодей был мёртв, может зашвырнуть вас вперёд во времени, фактически, выводя вас из игры. Желание получить легендарный магический предмет или артефакт может мгновенно перенести вас к его текущему обладателю.\n\nСоздание этим заклинанием любого эффекта, кроме дублирования другого заклинания, требует огромных усилий и ослабляет вас. Получив это ослабление и до окончания продолжительного отдыха каждый раз, когда вы накладываете заклинание, вы получаете урон некротической энергией 1к10 за каждый уровень этого заклинания. Этот урон никак нельзя отменить или уменьшить. Кроме того, ваша Сила на 2к4 дня опускается до 3, если она была больше 3. За каждый день, в течение которого вы только отдыхаете и не делаете ничего, кроме лёгкой деятельности, оставшееся время сокращается на 2 дня. Кроме того, существует 33-процентный шанс, что вы больше никогда не сможете накладывать исполнение желаний [wish]."));
    await spells.put("vicious mockery", Spell.smart(
        level: 0,
        school: "очарование",
        name: "Злая насмешка",
        castingTime: 1,
        range: "60 футов",
        verbal: true,
        duration: "мгновенная",
        impact: {
          0: {DamageType.psychic: [Dice(1, 4, 0)]},
          5: {DamageType.psychic: [Dice(2, 4, 0)]},
          11: {DamageType.psychic: [Dice(3, 4, 0)]},
          17: {DamageType.psychic: [Dice(4, 4, 0)]}
            },
        protected: true,
        savingModifier: Characteristic.wisdom,
        description:
            "Вы испускаете на существо, видимое в пределах дистанции, поток оскорблений вперемешку с тонкой магией. Если цель слышит вас (при этом она не обязана вас понимать), она должна преуспеть в спасброске Мудрости, иначе получит урон психической энергией 1к4, и следующий бросок атаки до конца своего следующего хода совершит с помехой.\n\nУрон этого заклинания увеличивается на 1к4, когда вы достигаете 5-го уровня (2к4), 11-го уровня (3к4) и 17-го уровня (4к4).",
        higherDescription: [
          "5-ый уровень класса: урон равен 2к4",
          "11-ый уровень класса: урон равен 3к4",
          "17-ый уровень класса: урон равен 4к4"
        ]));
    await spells.put("fire bolt", Spell.smart(
        level: 0,
        school: "воплощение",
        name: "Огненный снаряд",
        castingTime: 1,
        range: "120 футов",
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        impact: {
          0: {DamageType.fire: [Dice(1, 10, 0)]},
          5: {DamageType.fire: [Dice(2, 10, 0)]},
          11: {DamageType.fire: [Dice(3, 10, 0)]},
          17: {DamageType.fire: [Dice(4, 10, 0)]}
            },
        protected: true,
        description:
            "Вы кидаете сгусток огня в существо или предмет в пределах дистанции. Совершите по цели дальнобойную атаку заклинанием. При попадании цель получает урон огнём 1к10. Горючие предметы, по которым попало это заклинание, воспламеняются, если их никто не несет и не носит.\n\nУрон этого заклинания увеличивается на 1к10, когда вы достигаете 5-го уровня (2к10), 11-го уровня (3к10), 17-го уровня (4к10).",
        higherDescription: [
          "5-ый уровень класса: урон равен 2к10",
          "11-ый уровень класса: урон равен 3к10",
          "17-ый уровень класса: урон равен 4к10"
        ]));
    await spells.put("eldritch blast", Spell.smart(
        level: 0,
        school: "воплощение",
        name: "Мистический заряд",
        castingTime: 1,
        range: "120 футов",
        verbal: true,
        somatic: true,
        duration: "мгновенная",
        impact: {
          0: {DamageType.force: [Dice(1, 4, 0)]},
          5: {DamageType.force: [Dice(1, 4, 0), Dice(1, 4, 0)]},
          11: {DamageType.force: [Dice(1, 4, 0), Dice(1, 4, 0), Dice(1, 4, 0)]},
          17: {DamageType.force: [Dice(1, 4, 0), Dice(1, 4, 0), Dice(1, 4, 0), Dice(1, 4, 0)]}
            },
        protected: true,
        description:
            "К существу, находящемуся в пределах дистанции, устремляется луч потрескивающей энергии. Совершите дальнобойную атаку заклинанием по цели. При попадании цель получает урон силовым полем 1к10.\n\nЗаклинание создаёт ещё один луч, когда вы достигаете больших уровней: два луча на 5-м уровне, три луча на 11-м уровне и четыре луча на 17-м уровне.\n\nВы можете направить лучи в одну цель или в разных. Для каждого луча совершите свой бросок атаки.",
        higherDescription: [
          "5-ый уровень класса: количество лучей равно двум",
          "11-ый уровень класса: количество лучей равно трём",
          "17-ый уровень класса: количество лучей равно четырём"
        ]));
    await spells.put("Tasha's hideous laughter", Spell.smart(
        level: 1,
        school: "очарование",
        name: "Жуткий смех Таши",
        castingTime: 1,
        range: "30 футов",
        verbal: true,
        somatic: true,
        materials: {
          items.get("tasha")!: false},
        duration: "вплоть до одной минуты",
        concentration: true,
        savingModifier: Characteristic.wisdom,
        protected: true,
        description:
            "Существо на ваш выбор, видимое в пределах дистанции, воспринимает всё невероятно смешным и корчится от смеха, если заклинание на него действует. Цель должна преуспеть в спасброске Мудрости, иначе она падает ничком, становится недееспособной и в течение действия заклинания не может встать. Существа со значением Интеллекта 4 и ниже не попадают под действие этого заклинания.\n\nВ конце каждого своего хода и каждый раз при получении урона цель может совершать новый спасбросок Мудрости. Спасбросок совершается с преимуществом, если он был вызван получением урона. При успехе заклинание оканчивается."));
    await spells.put("mage armor", Spell.smart(
      level: 1,
      school: "ограждение",
      name: "Доспехи мага",
      castingTime: 1,
      range: "касание",
      verbal: true,
      somatic: true,
      materials: {items.get("mage armor")!: false},
      duration: "8 часов",
      protected: true,
      description:
          "Вы касаетесь согласного существа, не носящего доспех, и на время действия заклинания его окутывает защитное магическое поле. Базовый КД существа становится равен 13 + его модификатор Ловкости. Заклинание оканчивается, если цель надевает доспех или вы оканчиваете его действием.",
    ));
    await spells.put("invisibility", Spell.smart(
      level: 2,
      school: "иллюзия",
      name: "Невидимость",
      castingTime: 1,
      range: "касание",
      verbal: true,
      somatic: true,
      materials: {items.get("invisibility")!: false},
      concentration: true,
      duration: "вплоть до одного часа",
      protected: true,
      description:
          "Существо, которого вы касаетесь, становится невидимым до окончания действия заклинания. Все, что цель несет или носит, становится невидимым, пока остается у неё. Заклинание оканчивается на цели, если она совершает атаку или накладывает заклинание.",
      higherDescription: [
        "Если вы накладываете это заклинание, используя ячейку 3-го уровня или выше, вы можете сделать целью одно дополнительное существо за каждый уровень ячейки выше второго.Если вы накладываете это заклинание, используя ячейку 3-го уровня или выше, вы можете сделать целью одно дополнительное существо за каждый уровень ячейки выше второго."
      ],
    ));
    await spells.put("misty step", Spell.smart(
      level: 2,
      school: "вызов",
      name: "Туманный шаг",
      bonus: true,
      castingTime: 1,
      range: "на себя",
      verbal: true,
      duration: "мгновенная",
      protected: true,
      description: "Окутавшись серебристым туманом, вы телепортируетесь на 30 футов в свободное пространство, видимое вами.",
    ));
    await spells.put("rope trick", Spell.smart(
      level: 2,
      school: "преобразование",
      name: "Трюк с верёвкой",
      castingTime: 1,
      range: "касание",
      verbal: true,
      somatic: true,
      materials: {items.get("rope trick")!: false},
      duration: "1 час",
      protected: true,
      description: "Вы касаетесь верёвки длиной до 60 футов. Один её конец поднимается в воздух, а остальная часть висит перпендикулярно полу. На верхнем конце верёвки появляется невидимый вход в межпространство, существующий, пока заклинание активно.\n\nВ межпространство можно попасть забравшись по верёвке наверх. В этом межпространстве может поместиться восемь существ с размером не больше Среднего. Верёвку можно затянуть внутрь, после чего снаружи её не будет видно.\n\nАтаки и заклинания не могут проходить через вход внутрь межпространства и наружу, но те, кто находятся внутри, могут все видеть как через окно 3 × 5 футов с центром на верёвке.\n\nВсё, что находится в межпространстве, вываливается наружу, когда заклинание оканчивается.",
    ));
    await spells.put("fireball", Spell.smart(
      level: 3,
      school: "воплощение",
      name: "Огненный шар",
      castingTime: 1,
      range: "150 футов",
      verbal: true,
      somatic: true,
      materials: {items.get("fireball")!: false},
      duration: "мгновенная",
        savingModifier: Characteristic.dexterity,
        impact: {3: {DamageType.fire: [Dice(8, 6, 0)]}, 4: {DamageType.fire: [Dice(9, 6, 0)]}, 5: {DamageType.fire: [Dice(10, 6, 0)]}, 6: {DamageType.fire: [Dice(11, 6, 0)]}, 7: {DamageType.fire: [Dice(12, 6, 0)]}, 8: {DamageType.fire: [Dice(13, 6, 0)]}, 9: {DamageType.fire: [Dice(14, 6, 0)]}},
      protected: true,
      description: "Яркий луч вылетает из вашего указательного пальца в точку, выбранную вами в пределах дистанции, где и происходит взрыв пламени с гулким ревом. Все существа в пределах сферы с радиусом 20 футов с центром в этой точке должны совершить спасбросок Ловкости. Цель получает 8к6 урона огнём при провале или половину этого урона при успехе. Этот огонь огибает углы. Он воспламеняет горючие предметы, которые никто не несет и не носит.",
      higherDescription: ["Если вы накладываете это заклинание, используя ячейку 4-го уровня или выше, урон увеличивается на 1к6 за каждый уровень ячейки выше третьего."],
    ));
    await spells.put("heal", Spell.smart(
      level: 6,
      school: "воплощение",
      name: "Полное исцеление",
      castingTime: 1,
      range: "60 футов",
      verbal: true,
      somatic: true,
      duration: "мгновенная",
      impact: {6: {DamageType.heal: [Dice(0, 0, 70)]}, 7: {DamageType.heal: [Dice(0, 0, 80)]}, 8: {DamageType.heal: [Dice(0, 0, 90)]}, 9: {DamageType.heal: [Dice(0, 0, 100)]}},
      protected: true,
      description: "Выберите существо, видимое в пределах дистанции. Поток положительной энергии омывает его, восстанавливая 70 хитов. Это заклинание также отменяет слепоту, глухоту и все болезни, действующие на цель. Это заклинание не оказывает эффекта на конструктов и нежить.\n\nНа больших уровнях. Если вы накладываете это заклинание, используя ячейку 7-го уровня или выше, количество восстанавливаемых хитов увеличивается на 10 за каждый уровень ячейки выше шестого.",
    ));
  }

  bool get protected => _protected;

  Characteristic get savingModifier => _savingModifier;

  set savingModifier(Characteristic value) {
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

  bool get somatic => _somatic;

  set somatic(bool value) {
    _somatic = value;
  }

  bool get verbal => _verbal;

  set verbal(bool value) {
    _verbal = value;
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

  Map<Item, bool> get materials => _materials;

  set materials(Map<Item, bool> value) {
    _materials = value;
  }

  String get range => _range;

  set range(String value) {
    _range = value;
  }

  Map<int, Map<DamageType, List<Dice>>> get impact => _impact;

  set impact(Map<int, Map<DamageType, List<Dice>>> value) {
    _impact = value;
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
          _impact == other._impact &&
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
      _impact.hashCode ^
      _protected.hashCode;
}
