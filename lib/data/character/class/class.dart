import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:dnd_companion/data/character/class/sub_class_level.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/class_dependency.dart';
import 'package:dnd_companion/data/structures/rest.dart';
import 'package:dnd_companion/data/structures/spellcaster_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'level.dart';
part 'class.g.dart';

@HiveType(typeId: 111)
class Class {
  //TODO выбор стартового снаряжения?
  //TODO выбор умений или инструментов

  @HiveField(0)
  String _name;
  @HiveField(1)
  String _description;
  @HiveField(2)
  String _image;
  @HiveField(3)
  Dice _hits;
  @HiveField(4)
  Set<Characteristic> _savingChecks;

  @HiveField(5)
  bool? _multiClassingLogic; // false = or, true = and
  @HiveField(6)
  int? _multiClassingProficienciesCount;
  @HiveField(7)
  Map<String, int>? _multiClassingRequirements;
  @HiveField(8)
  Set<Proficiency>? _multiClassingProficiencies;
  @HiveField(9)
  Set<Proficiency>? _multiClassingProficiencyChoices;

  @HiveField(10)
  Characteristic _spellCastingAbility;
  @HiveField(11)
  String? _focusItem;
  @HiveField(12)
  bool _hasSpecialMagicTable;
  @HiveField(13)
  int _spellcasterStartLevel;
  @HiveField(14)
  SpellcasterType _spellcasterType;

  @HiveField(15)
  int _proficiencyCount;
  @HiveField(16)
  Set<Proficiency> _proficiencyChoices;
  @HiveField(17)
  Set<Proficiency> _proficiencies;

  @HiveField(18)
  Set<SkillCheck> _skillChecks;
  @HiveField(19)
  int _skillChecksCount;
  @HiveField(20)
  Set<SkillCheck> _skillCheckChoices;

  @HiveField(21)
  Rest? _restType; // points regen rest type
  @HiveField(22)
  String? _classPointsName;
  @HiveField(23)
  String? _classDiceName;
  @HiveField(24)
  List<Level> _levels;

  @HiveField(25)
  Map<Item, int> _items;

  //Characteristic _preparedSpellCounter; // TODO check this for duplicating spellCastingAbility
  //String? _activeState; //TODO active states like animal forms or barbarian rage

  @HiveField(26)
  int _subClassChooseLevel;
  @HiveField(27)
  List<SubClass> _subClasses;

  //late int? _unarmoredArmorConst;
  //late Set<String>? _unarmoredArmor;
  //late List<FightingStyle> styles;

  @HiveField(28)
  bool _protected;

  Class(
      this._name,
      this._description,
      this._image,
      this._hits,
      this._savingChecks,
      this._multiClassingLogic,
      this._multiClassingProficienciesCount,
      this._multiClassingRequirements,
      this._multiClassingProficiencies,
      this._multiClassingProficiencyChoices,
      this._spellCastingAbility,
      this._focusItem,
      this._hasSpecialMagicTable,
      this._spellcasterStartLevel,
      this._spellcasterType,
      this._proficiencyCount,
      this._proficiencyChoices,
      this._proficiencies,
      this._skillChecks,
      this._skillChecksCount,
      this._skillCheckChoices,
      this._restType,
      this._classPointsName,
      this._classDiceName,
      this._levels,
      this._items,
      this._subClassChooseLevel,
      this._subClasses,
      this._protected);

  Class.smart({
      required String name,
      String description = "",
      String image = "question-mark.png",
      required Dice hits,
      required Set<Characteristic> savingChecks,
      bool? multiClassingLogic,
      int? multiClassingProficienciesCount,
      Map<String, int>? multiClassingRequirements,
      Set<Proficiency>? multiClassingProficiencies,
      Set<Proficiency>? multiClassingProficiencyChoices,
      Characteristic spellCastingAbility = Characteristic.none,
      String? focusItem,
      bool hasSpecialMagicTable = false,
      int spellcasterStartLevel = 0,
      SpellcasterType spellcasterType = SpellcasterType.none,
      int proficiencyCount = 0,
      Set<Proficiency>? proficiencyChoices,
      Set<Proficiency>? proficiencies,
      Set<SkillCheck>? skillChecks,
      int skillChecksCount = 0,
      Set<SkillCheck>? skillCheckChoices,
      Rest? restType,
      String? classPointsName,
      String? classDiceName,
      required List<Level> levels,
      Map<Item, int>? items,
      int subClassChooseLevel = 2,
      List<SubClass>? subClasses,
      bool protected = false})
      : _name = name,
        _description = description,
        _image = image,
        _hits = hits,
        _savingChecks = savingChecks,
        _multiClassingLogic = multiClassingLogic,
        _multiClassingProficienciesCount = multiClassingProficienciesCount,
        _multiClassingRequirements = multiClassingRequirements,
        _multiClassingProficiencies = multiClassingProficiencies,
        _multiClassingProficiencyChoices = multiClassingProficiencyChoices,
        _spellCastingAbility = spellCastingAbility,
        _focusItem = focusItem,
        _hasSpecialMagicTable = hasSpecialMagicTable,
        _spellcasterStartLevel = spellcasterStartLevel,
        _spellcasterType = spellcasterType,
        _proficiencyCount = proficiencyCount,
        _proficiencyChoices = proficiencyChoices ?? {},
        _proficiencies = proficiencies ?? {},
        _skillChecks = skillChecks ?? {},
        _skillChecksCount = skillChecksCount,
        _skillCheckChoices = skillCheckChoices ?? {},
        _restType = restType,
        _classPointsName = classPointsName,
        _classDiceName = classDiceName,
        _levels = levels,
        _items = items ?? {},
        _subClassChooseLevel = subClassChooseLevel,
        _subClasses = subClasses ?? [],
        _protected = protected;

  static Future<void> unpack(Box<Class> classes, Box<Proficiency> proficiencies, Box<SkillCheck> skillChecks, Box<Item> items) async {
    await classes.put("fighter", Class.smart(
        name: "Воин",
        description: "Опытный гладиатор сражается на арене и хорошо знает, как использовать свои трезубец и сеть, чтобы опрокинуть противника и обойти его, вызывая ликование публики и получая тактическое преимущество. Меч его противника вспыхивает голубым светом и испускает сверкающую молнию. Все эти герои — воины. Представители, возможно, самого разнообразного класса в мире D&D. Странствующие рыцари, военачальники-завоеватели, королевские чемпионы, элитная пехота, бронированные наёмники и короли разбоя — будучи воинами, все они мастерски владеют оружием, доспехами, и приёмами ведения боя. А еще они хорошо знакомы со смертью — они несут её сами, и часто смотрят в её холодные глаза.",
        hits: Dice(1, 10, 0),
        subClassChooseLevel: 3,
        savingChecks: {Characteristic.strength, Characteristic.constitution},
        proficiencies: {proficiencies.get("all armor")!, proficiencies.get("shields")!, proficiencies.get("simple weapons")!, proficiencies.get("martial weapons")!},
        skillChecksCount: 2,
        skillCheckChoices: {skillChecks.get("acrobatics")!, skillChecks.get("athletics")!, skillChecks.get("perception")!, skillChecks.get("survival")!, skillChecks.get("intimidation")!, skillChecks.get("history")!, skillChecks.get("insight")!, skillChecks.get("animal handling")!},
        items: {items.get("chain mail")!: 1, items.get("long sword")!: 1, items.get("shield")!: 1, items.get("crossbow, light")!: 1, items.get("bolt")!: 20},
        image: "fighter.png",
        levels: [
          Level.smart(skills: {Skill.smart(name: "Второе дыхание", maxCharges: {0: 1}, rechargeRequirement: Rest.both, diceImpact: {0: Dice(1, 10, 0)}, addClassLevel: true, description: "Вы обладаете ограниченным источником выносливости, которым можете воспользоваться, чтобы уберечь себя. В свой ход вы можете бонусным действием восстановить хиты в размере 1к10 + ваш уровень воина.\n\n Использовав это умение, вы должны завершить короткий либо продолжительный отдых, чтобы получить возможность использовать его снова.")}),
          Level.smart(skills: {Skill.smart(name: "Всплеск действий", maxCharges: {0: 1, 17: 2}, rechargeRequirement: Rest.both, description: "Вы получаете возможность на мгновение преодолеть обычные возможности. В свой ход вы можете совершить одно дополнительное действие помимо обычного и бонусного действий. Использовав это умение, вы должны завершить короткий или продолжительный отдых, чтобы получить возможность использовать его снова. Начиная с 17-го уровня вы можете использовать это умение дважды, прежде чем вам понадобится отдых, но в течение одного хода его всё равно можно использовать лишь один раз.")}),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(skills: {Skill.smart(name: "Дополнительная атака", description: "Если вы в свой ход совершаете действие Атака, вы можете совершить две атаки вместо одной.\n\nКоличество атак увеличивается до трёх на 11-м уровне этого класса, и до четырёх на 20-м уровне.")}),
          Level.smart(abilityScorePoints: 2),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(skills: {Skill.smart(name: "Упорный", maxCharges: {0: 1, 13: 2, 17: 3}, rechargeRequirement: Rest.long, description: "Вы можете перебросить проваленный спасбросок, и должны использовать новый результат. После этого вы можете повторно использовать это умение только после завершения продолжительного отдыха.\n\nВы можете использовать это умение дважды между периодами продолжительного отдыха после достижения 13-го уровня, и трижды после достижения 17-го уровня.")}),
          Level.smart(),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(),
          Level.smart(),
          Level.smart(abilityScorePoints: 2),
          Level.smart(),
        ],
      subClasses: [
        SubClass.smart(
            name: "Мистический рыцарь",
            description: "Архетип мистического рыцаря совмещает в себе воинское искусство и тщательное изучение волшебства. Мистические рыцари используют приёмы, схожие с практиками волшебников. Но они сосредоточились на изучении двух из восьми школ магии: Воплощения и Ограждения. Заклинания Ограждения обеспечивают мистическим рыцарям дополнительную защиту в бою, а Воплощения причиняют урон сразу нескольким противникам за раз, увеличивая возможности рыцаря в бою. Эти рыцари владеют относительно небольшим количеством заклинаний, что позволяет постоянно держать их в памяти и не использовать книгу заклинаний.",
            spellcasterType: SpellcasterType.third,
            spellCastingAbility: Characteristic.intelligence,
            subClassSkills: { // TODO repair the eldritch knight model on level 3 ("": 1:3 => 1:1) and other levels
              3: SubClassLevel.smart(name: "Использование заклинаний + связь с оружием", spellChoices: {"Волшебник": {"": {0: 2, 1: 3}, "Воплощение": {1: 1}, "Заграждение": {1: 1}}}, description: "К своим воинским талантам вы добавляете возможность накладывать заклинания.", skills: {Skill.smart(name: "Связь с оружием", maxCharges: {0: 2}, rechargeRequirement: Rest.none, description: "Вы узнаёте ритуал, позволяющий создать магическую связь между вами и одним оружием. Вы выполняете ритуал в течение 1 часа, и он может быть совершён в течение короткого отдыха. Оружие во время проведения ритуала должно находиться на доступном расстоянии от вас, и в конце вы должны прикоснуться к нему и создать связь.\n\nКак только вы привязали к себе оружие, вы не можете быть обезоруженным, пока не станете недееспособным. Если оружие находится на одном плане существования с вами, вы можете в свой ход бонусным действием призвать его, телепортируя себе в руку.\n\nУ вас может быть не более двух привязанных оружий одновременно, и бонусным действием вы призываете их по одному. Если вы попытаетесь создать связь с третьим оружием, вам придётся разорвать связь с одним из первых двух.")}),
              4: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {1: 1}}}),
              7: SubClassLevel.smart(name: "Боевая магия + дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}, skills: {Skill.smart(name: "Боевая магия", description: "Если вы действием накладываете заговор, вы можете бонусным действием совершить одну атаку оружием.")}),
              10: SubClassLevel.smart(name: "Мистический удар + дополнительные заклинание и заговор", spellChoices: {"Волшебник": {"": {0:1, 2: 1}}}, skills: {Skill.smart(name: "Мистический удар", description: "Вы узнаёте, как с помощью удара оружием снизить сопротивляемость цели вашим заклинаниям. Если вы попадаете по существу атакой оружием, это существо совершает следующий спасбросок от вашего заклинания, использованного до конца вашего следующего хода, с помехой.")}),
              11: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
              13: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
              14: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
              15: SubClassLevel.smart(name: "Волшебный рывок", skills: {Skill.smart(name: "Волшебный рывок", description: "Вы получаете возможность телепортироваться на 30 футов в свободное пространство, которое вы видите, когда используете «Всплеск действий». Вы можете телепортироваться до или после дополнительного действия.")}),
              16: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
              18: SubClassLevel.smart(name: "Улучшенная боевая магия", skills: {Skill.smart(name: "Улучшенная боевая магия", description: "Если вы действием накладываете заклинание, вы можете бонусным действием совершить одну атаку оружием.")}),
              19: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
              20: SubClassLevel.smart(name: "Дополнительное заклинание", spellChoices: {"Волшебник": {"": {2: 1}}}),
            }),
        SubClass.smart(
            name: "Мастер боевых искусств",
            description: "Тот, кто выбрал архетип мастера боевых искусств, полагается на техники, выработанные поколениями бойцов. Для такого воина сражение сродни академической задаче, и часто включает вещи, далёкие от боя, вроде кузнечного мастерства или каллиграфии. Не все воины способны впитать уроки истории, теорию и артистизм, отражённые в архетипе мастера боевых искусств, но те, кто смог сделать это, являются отлично подготовленными воинами, обладающими прекрасными навыками и знаниями.",
            diceName: "кости превосходства",
            dice: {0: Dice(1, 8, 0), 10: Dice(1, 10, 0), 18: Dice(1, 12, 0)},
            subClassSkills: {
              3: SubClassLevel.smart(name: "Боевое превосходство + ученик войны", proficiencies: {proficiencies.get("smith's tools")!}, skills: {
                Skill.smart(name: "Активное перемещение", consumedPointsCount: 1, consumedPointsDependency: ClassDependency.subClass, description: "Активное уклонение. При перемещении вы можете потратить одну кость превосходства, совершить её бросок и добавить выпавшее значение к КД, пока не прекратите перемещение."),
                Skill.smart(name: "Атака с выпадом.", consumedPointsCount: 1, attack: true, consumedPointsDependency: ClassDependency.subClass, description: "Если вы в свой ход совершаете рукопашную атаку оружием, вы можете потратить одну кость превосходства, чтобы увеличить досягаемость этой атаки на 5 футов. В случае попадания вы добавляете кость превосходства к броску урона этой атаки."),
                Skill.smart(name: "Точная атака", consumedPointsCount: 1, attack: true, consumedPointsDependency: ClassDependency.subClass, description: "Если вы совершаете бросок атаки оружием по существу, вы можете потратить одну кость превосходства, чтобы добавить её к броску. Вы можете использовать этот приём до или после совершения броска атаки, но до применения эффектов атаки."),
              }),
              7: SubClassLevel.smart(name: "Познай своего врага", skills: {Skill.smart(name: "Познай своего врага", description: "Если вы потратите как минимум 1 минуту, рассматривая, или по другому взаимодействуя с существом вне боя, вы можете узнать некоторую информацию о его способностях в сравнении с вашими.")}),
              10: SubClassLevel.smart(name: "Улучшенное боевое превосходство", description: "Ваша кость превосходства увеличивается до к10."),
              15: SubClassLevel.smart(name: "Неослабевающий", skills: {Skill.smart(name: "Неослабевающий", consumedPointsCount: -1, consumedPointsDependency: ClassDependency.subClass, description: "Если вы совершаете бросок инициативы, не имея костей превосходства, вы получаете одну.")}),
              18: SubClassLevel.smart(name: "Улучшенное боевое превосходство", description: "Ваша кость превосходства увеличивается до к12."),
            }),
      ]
    ));
    await classes.put("wizard", Class.smart(
        name: "Волшебник",
        description: "Волшебники — адепты высшей магии, объединяющиеся по типу своих заклинаний. Опираясь на тонкие плетения магии, пронизывающей вселенную, волшебники способны создавать заклинания взрывного огня, искрящихся молний, тонкого обмана и грубого контроля над сознанием. Их магия вызывает чудовищ с других планов бытия, предсказывает будущее и обращает поверженных врагов в зомби. Их самые могущественные заклинания могут превращать одно вещество в другое, вызывать метеориты с небес и открывать порталы в другие миры.",
        hits: Dice(1, 6, 0),
        subClassChooseLevel: 2,
        spellCastingAbility: Characteristic.intelligence,
        spellcasterType: SpellcasterType.full,
        proficiencies: {proficiencies.get("daggers")!, proficiencies.get("darts")!, proficiencies.get("slings")!, proficiencies.get("quarterstaffs")!, proficiencies.get("hand crossbows")!},
        savingChecks: {Characteristic.intelligence, Characteristic.wisdom},
        skillChecksCount: 2,
        skillCheckChoices: {skillChecks.get("history")!, skillChecks.get("arcana")!, skillChecks.get("medicine")!, skillChecks.get("insight")!, skillChecks.get("investigation")!, skillChecks.get("religion")!},
        items: {items.get("quarterstaff")!: 1, items.get("component pouch")!: 1, items.get("spellbook")!: 1},
        image: "wizard.png",
        levels: [
          Level.smart(spellChoices: {"Волшебник": {"": {0: 3}}},skills: {Skill.smart(name: "Магическое восстановление", addClassLevel: true, levelMultiplier: 0.5, description: "Вы знаете как восстанавливать часть магической энергии, изучая книгу заклинаний. Один раз в день, когда вы заканчиваете короткий отдых, вы можете восстановить часть использованных ячеек заклинаний. Ячейки заклинаний могут иметь суммарный уровень, который не превышает половину уровня вашего волшебника (округляя в большую сторону), и ни одна из ячеек не может быть шестого уровня или выше.\n\nНапример, если вы волшебник 4-го уровня, вы можете восстановить ячейки заклинаний с суммой уровней не больше двух. Вы можете восстановить одну ячейку заклинаний 2-го уровня, или две ячейки заклинаний 1-го уровня.")}),
          Level.smart(),
          Level.smart(),
          Level.smart(abilityScorePoints: 2, spellChoices: {"Волшебник": {"": {0: 1}}}),
          Level.smart(),
          Level.smart(),
          Level.smart(),
          Level.smart(abilityScorePoints: 2, ),
          Level.smart(),
          Level.smart(spellChoices: {"Волшебник": {"": {0: 1}}}),
          Level.smart(),
          Level.smart(abilityScorePoints: 2, ),
          Level.smart(),
          Level.smart(),
          Level.smart(),
          Level.smart(abilityScorePoints: 2, ),
          Level.smart(),
          Level.smart(skills: {Skill.smart(name: "Мастерство заклинателя", description: "Вы достигаете такого мастерства в отношении некоторых заклинаний, что можете накладывать их неограниченное количество раз. Выберите одно заклинание волшебника 1-го уровня и одно заклинание волшебника 2-го уровня, которые есть в вашей книге заклинаний. Вы можете накладывать эти заклинания без увеличения их уровня, не тратя ячейки заклинаний, при условии, что вы их подготовили. Если вы хотите увеличить уровень этих заклинаний, вы должны потратить ячейку заклинаний как обычно.\n\nПотратив 8 часов на обучение, вы можете изменить одно или оба эти заклинания по своему усмотрению на заклинания тех же уровней.")}),
          Level.smart(abilityScorePoints: 2, ),
          Level.smart(skills: {Skill.smart(name: "Фирменное заклинание", maxCharges: {0: 3}, rechargeRequirement: Rest.both, description: "Вы получаете власть над двумя мощными заклинаниями и можете накладывать их без усилий. Выберите два заклинания волшебника 3-го уровня из своей книги заклинаний в качестве фирменных заклинаний. Для вас эти заклинания всегда считаются подготовленными, они не учитываются в количестве подготовленных заклинаний, и вы можете наложить каждое из этих заклинаний 3-го уровня, не тратя ячейку заклинаний. Когда вы так поступаете, вы не можете наложить их повторно таким же образом, пока не закончите короткий или продолжительный отдых.\n\nЕсли вы хотите наложить заклинание более высокого уровня, вы должны потратить ячейку заклинаний как обычно.")}),
        ],
      subClasses: [
        SubClass.smart(
            name: "Школа воплощения",
            description: "Вы сосредоточили свои исследования на магии, которая создаёт могущественные стихийные эффекты, такие как ледяной холод, жгучее пламя, раскатистый гром, трещащие молнии и едкая кислота. Некоторые боевые маги находят своё призвание в армии, идя на службу в артиллерию и уничтожая вражеские армии издалека. Другие используют свои впечатляющие возможности, чтобы защитить слабых. Остальные же ищут свою собственную выгоду на поприще бандита, искателя приключений или начинающего тирана.",
            subClassSkills: {
              2:SubClassLevel.smart(name: "Мастер воплощения + построение заклинаний", skills: {Skill.smart(name: "Мастер воплощения", description: "Золото и время, которое вы тратите на копирование заклинания школы Воплощения в свою книгу заклинаний, уменьшаются вдвое."), Skill.smart(name: "Построение заклинаний", description: "Когда вы накладываете разрушительное заклинание, то можете создать относительно безопасные участки внутри зоны поражения, которые оно не затрагивает. При накладывании заклинания школы Воплощения, воздействующего на других существ, которых вы видите, вы можете выбрать количество существ, равное 1 + уровень заклинания. Выбранные существа автоматически преуспевают в спасбросках от этого заклинания и не получают урона, если по описанию должны получить половину урона от заклинания при успешном спасении.")}),
              6:SubClassLevel.smart(name: "Мощный заговор", skills: {Skill.smart(name: "Мощный заговор", description: "Ваши наносящие урон заговоры воздействуют даже на тех существ, которые избегают основного эффекта. Если существо преуспевает в спасброске от вашего заговора, оно получает половину урона от него (если есть), но не получает дополнительных эффектов от него.")}),
              10:SubClassLevel.smart(name: "Усиленное воплощение", skills: {Skill.smart(name: "Усиленное воплощение", description: "При броске урона от заклинания школы Воплощения, наложенного вами, вы добавляете к одному броску урона свой модификатор Интеллекта.")}),
              14:SubClassLevel.smart(name: "Перегрузка", skills: {Skill.smart(name: "Перегрузка", diceImpact: {0: Dice(1, 12, 0)}, description: "Вы можете увеличить силу своих простейших заклинаний. Когда вы накладываете наносящее урон заклинание волшебника 5-го уровня или ниже, вы можете нанести им максимальный урон. Это умение не распространяется на заговоры.\n\nБез вреда для себя вы можете использовать это умение один раз. Если вы повторно используете это умение до окончания продолжительного отдыха, то получаете 2к12 урона некротической энергией за каждый уровень заклинания сразу после его накладывания. Каждый следующий раз при использовании данного умения до окончания продолжительного отдыха урон некротической энергией увеличивается на 1к12. Этот урон игнорирует сопротивление и иммунитет.")}),
            }),
        SubClass.smart(
            name: "Школа вызова",
            description: "Являясь вызывателем, вы предпочитаете заклинания, которые создают предметы и существ из воздуха. Вы можете силой мысли вызвать клубящиеся облака убийственного тумана или призвать откуда угодно существ для битвы на вашей стороне. С ростом мастерства вы узнаёте заклинания перемещения и сможете в мгновение ока телепортироваться на огромные расстояния, и даже на другие планы существования.",
            subClassSkills: {
              2:SubClassLevel.smart(name: "Мастер созидания + малый вызов", skills: {Skill.smart(name: "Мастер созидания", description: "Золото и время, которое вы тратите на копирование заклинания школы Вызова в свою книгу заклинаний, уменьшаются вдвое."), Skill.smart(name: "Малый вызов", description: "Вы можете действием создать неодушевлённый предмет в своей руке или на земле в свободном пространстве, которое вы можете видеть, и которое расположено в пределах 10 футов от вас. Этот предмет не должен превышать в длину 3 фута (90 сантиметров) и весить более 10 фунтов, и его форма должна быть как у немагического предмета, который вы уже видели. Видно, что предмет магический, и он излучает тусклый свет в пределах 5 футов.\n\nПредмет исчезает через 1 час, когда вы используете это умение вновь, или когда он получает любой урон.")}),
              6:SubClassLevel.smart(name: "Безопасное перемещение", skills: {Skill.smart(name: "Безопасное перемещение", maxCharges: {0: 1}, rechargeRequirement: Rest.long, description: "Вы можете действием телепортироваться на 30 футов в свободное пространство, которое можете видеть. В качестве альтернативы, вы можете выбрать пространство в пределах этого диапазона, занятое существом Маленького или Среднего размера. Если это существо согласно, вы оба телепортируетесь, меняясь местами. Использовав это умение один раз, вы не можете использовать его вновь до окончания продолжительного отдыха или пока не наложите заклинание школы Вызова 1-го уровня или выше.")}),
              10:SubClassLevel.smart(name: "Фокусированный вызов", skills: {Skill.smart(name: "Фокусированный вызов", description: "Когда вы концентрируетесь на заклинании школы Вызова, ваша концентрация не может быть нарушена в результате получения урона.")}),
              14:SubClassLevel.smart(name: "Надёжный призыв", skills: {Skill.smart(name: "Надёжный призыв", description: "Все призванные или созданные вами заклинанием школы Вызова существа имеют 30 временных хитов.")}),
            }),
      ],
    ));
  }

  AssetImage getImage(){
    if(_image != ""){
      return AssetImage("resources/icons/classes/" + _image);
    } else {
      return const AssetImage("resources/icons/question-mark.png");
    }
  }

  bool get protected => _protected;

  set protected(bool value) {
    _protected = value;
  }

  List<SubClass> get subClasses => _subClasses;

  set subClasses(List<SubClass> value) {
    _subClasses = value;
  }

  int get subClassChooseLevel => _subClassChooseLevel;

  set subClassChooseLevel(int value) {
    _subClassChooseLevel = value;
  }

  List<Level> get levels => _levels;

  set levels(List<Level> value) {
    _levels = value;
  }

  String? get classDiceName => _classDiceName;

  set classDiceName(String? value) {
    _classDiceName = value;
  }

  String? get classPointsName => _classPointsName;

  set classPointsName(String? value) {
    _classPointsName = value;
  }

  Rest? get restType => _restType;

  set restType(Rest? value) {
    _restType = value;
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  set proficiencies(Set<Proficiency> value) {
    _proficiencies = value;
  }

  Set<Proficiency> get proficiencyChoices => _proficiencyChoices;

  set proficiencyChoices(Set<Proficiency> value) {
    _proficiencyChoices = value;
  }

  int get proficiencyCount => _proficiencyCount;

  set proficiencyCount(int value) {
    _proficiencyCount = value;
  }

  SpellcasterType get spellcasterType => _spellcasterType;

  set spellcasterType(SpellcasterType value) {
    _spellcasterType = value;
  }

  int get spellcasterStartLevel => _spellcasterStartLevel;

  set spellcasterStartLevel(int value) {
    _spellcasterStartLevel = value;
  }

  bool get hasSpecialMagicTable => _hasSpecialMagicTable;

  set hasSpecialMagicTable(bool value) {
    _hasSpecialMagicTable = value;
  }

  String? get focusItem => _focusItem;

  set focusItem(String? value) {
    _focusItem = value;
  }

  Characteristic get spellCastingAbility => _spellCastingAbility;

  set spellCastingAbility(Characteristic value) {
    _spellCastingAbility = value;
  }

  Set<Proficiency>? get multiClassingProficiencyChoices =>
      _multiClassingProficiencyChoices;

  set multiClassingProficiencyChoices(Set<Proficiency>? value) {
    _multiClassingProficiencyChoices = value;
  }

  Set<Proficiency>? get multiClassingProficiencies =>
      _multiClassingProficiencies;

  set multiClassingProficiencies(Set<Proficiency>? value) {
    _multiClassingProficiencies = value;
  }

  Map<String, int>? get multiClassingRequirements => _multiClassingRequirements;

  set multiClassingRequirements(Map<String, int>? value) {
    _multiClassingRequirements = value;
  }

  int? get multiClassingProficienciesCount => _multiClassingProficienciesCount;

  set multiClassingProficienciesCount(int? value) {
    _multiClassingProficienciesCount = value;
  }

  bool? get multiClassingLogic => _multiClassingLogic;

  set multiClassingLogic(bool? value) {
    _multiClassingLogic = value;
  }

  Dice get hits => _hits;

  set hits(Dice value) {
    _hits = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Map<Item, int> get items => _items;

  set items(Map<Item, int> value) {
    _items = value;
  }

  Set<Characteristic> get characteristics => _savingChecks;

  set characteristics(Set<Characteristic> value) {
    _savingChecks = value;
  }

  Set<SkillCheck> get skillCheckChoices => _skillCheckChoices;

  set skillCheckChoices(Set<SkillCheck> value) {
    _skillCheckChoices = value;
  }

  int get skillChecksCount => _skillChecksCount;

  set skillChecksCount(int value) {
    _skillChecksCount = value;
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  set skillChecks(Set<SkillCheck> value) {
    _skillChecks = value;
  }

  Set<Characteristic> get savingChecks => _savingChecks;

  set savingChecks(Set<Characteristic> value) {
    _savingChecks = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Class &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _image == other._image &&
          _hits == other._hits &&
          _savingChecks == other._savingChecks &&
          _multiClassingLogic == other._multiClassingLogic &&
          _multiClassingProficienciesCount ==
              other._multiClassingProficienciesCount &&
          _multiClassingRequirements == other._multiClassingRequirements &&
          _multiClassingProficiencies == other._multiClassingProficiencies &&
          _multiClassingProficiencyChoices ==
              other._multiClassingProficiencyChoices &&
          _spellCastingAbility == other._spellCastingAbility &&
          _focusItem == other._focusItem &&
          _hasSpecialMagicTable == other._hasSpecialMagicTable &&
          _spellcasterStartLevel == other._spellcasterStartLevel &&
          _spellcasterType == other._spellcasterType &&
          _proficiencyCount == other._proficiencyCount &&
          _proficiencyChoices == other._proficiencyChoices &&
          _proficiencies == other._proficiencies &&
          _skillChecks == other._skillChecks &&
          _skillChecksCount == other._skillChecksCount &&
          _skillCheckChoices == other._skillCheckChoices &&
          _restType == other._restType &&
          _classPointsName == other._classPointsName &&
          _classDiceName == other._classDiceName &&
          _levels == other._levels &&
          _items == other._items &&
          _subClassChooseLevel == other._subClassChooseLevel &&
          _subClasses == other._subClasses &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _image.hashCode ^
      _hits.hashCode ^
      _savingChecks.hashCode ^
      _multiClassingLogic.hashCode ^
      _multiClassingProficienciesCount.hashCode ^
      _multiClassingRequirements.hashCode ^
      _multiClassingProficiencies.hashCode ^
      _multiClassingProficiencyChoices.hashCode ^
      _spellCastingAbility.hashCode ^
      _focusItem.hashCode ^
      _hasSpecialMagicTable.hashCode ^
      _spellcasterStartLevel.hashCode ^
      _spellcasterType.hashCode ^
      _proficiencyCount.hashCode ^
      _proficiencyChoices.hashCode ^
      _proficiencies.hashCode ^
      _skillChecks.hashCode ^
      _skillChecksCount.hashCode ^
      _skillCheckChoices.hashCode ^
      _restType.hashCode ^
      _classPointsName.hashCode ^
      _classDiceName.hashCode ^
      _levels.hashCode ^
      _items.hashCode ^
      _subClassChooseLevel.hashCode ^
      _subClasses.hashCode ^
      _protected.hashCode;
}
