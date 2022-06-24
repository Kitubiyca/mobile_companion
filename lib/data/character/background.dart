import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill_check.dart';
import 'package:hive/hive.dart';

class Background {

  //TODO сделать определение направленности или события

  String _name;
  String _description;
  String _skillName;
  String _skill;
  Set<SkillCheck> _skillChecks;
  Set<Proficiency> _proficiencies;
  double _coins;
  Map<Item, int> _items; //TODO сделать нормальный выбор предметов и наборов
  Set<String> _languages; //TODO сделать нормальный выбор языков
  bool _protected;

  Background(
      this._name,
      this._description,
      this._skillName,
      this._skill,
      this._skillChecks,
      this._proficiencies,
      this._coins,
      this._items,
      this._languages,
      this._protected);

  Background.smart({
      required String name,
      String description = "",
      required String skillName,
      String skill = "",
      Set<SkillCheck>? skillChecks,
      Set<Proficiency>? proficiencies,
      double coins = 0,
      Map<Item, int>? items,
      Set<String>? languages,
      bool protected = false})
      : _name = name,
        _description = description,
        _skillName = skillName,
        _skill = skill,
        _skillChecks = skillChecks ?? {},
        _proficiencies = proficiencies ?? {},
        _coins = coins,
        _items = items ?? {},
        _languages = languages ?? {},
        _protected = protected;

  /*Background.copyFrom(Background object){
    _name = object.name;
    _description = object.description;
    _skillName = object.skillName;
    _skill = object.skill;
    for(int i = 0; i < object.skillChecks.length; i++){
      _skillChecks.add(SkillCheck.copyFrom(object.skillChecks.elementAt(i)));
    }
    for(int i = 0; i < object.proficiencies.length; i++){
      _proficiencies.add(Proficiency.copyFrom(object.proficiencies.elementAt(i)));
    }
    for(int i = 0; i < object.items.length; i++){
      _items.add(Item.copyFrom(object.items.elementAt(i)));
    }
    _languages.addAll(object.languages);
    _protected = false;
  }*/

  static Future<void> unpack(Box<Background> backgrounds, Box<Proficiency> proficiencies, Box<SkillCheck> skillChecks, Box<Item> items) async {
    await backgrounds.put("urchin", Background.smart(name: "Беспризорник", coins: 1000, items: {items.get("small knife")!: 1, items.get("city map")!: 1, items.get("pet mouse")!: 1, items.get("token")!: 1, items.get("common clothes")!: 1}, proficiencies: {proficiencies.get("thieves tools")!, proficiencies.get("disguise kit")!},  skillChecks: {skillChecks.get("sleight of hand")!, skillChecks.get("stealth")!}, skillName: "Городские тайны", skill: "Вы знаете тайные лазы и проходы городских улиц, позволяющие пройти там, где другие не увидят пути. Вне боя вы (и ведомые вами союзники) можете перемещаться по городу вдвое быстрее обычного.", description: "Вы выросли на улице в бедности и одиночестве, лишённые родителей. Никто не присматривал и не заботился о вас, и вам пришлось научиться делать это самому. Вам приходилось постоянно бороться за еду и следить за другими неприкаянными душами, способными обокрасть вас. Вы спали на чердаках и в переулках, мокли под дождём и боролись с болезнями, не получая медицинской помощи или приюта. Вы выжили, невзирая на все трудности, и сделали это благодаря своей сноровке, силе или скорости.\n\nВы начинаете приключение с суммой денег, достаточной, чтоб скромно, но уверенно прожить десять дней. Как вы получили эти деньги? Что позволило вам перейти к нормальной жизни, преодолев нищету?"));
    await backgrounds.put("sailor", Background.smart(name: "Моряк", coins: 1000, items: {items.get("club")!: 1, items.get("silk rope")!: 1, items.get("lucky charm")!: 1, items.get("common clothes")!: 1}, proficiencies: {proficiencies.get("navigators tools")!, proficiencies.get("vehicles(water)")!}, skillChecks: {skillChecks.get("athletics")!, skillChecks.get("perception")!}, skillName: "Поездка на корабле", skill: "Если понадобится, вы можете получить бесплатную поездку на паруснике для себя и своих спутников. Это может быть ваш старый корабль, или другой корабль, с которым вы находитесь в хороших отношениях (возможно, им командует ваш бывший напарник). Вам оказывают услугу, поэтому вы не можете устанавливать распорядок и прокладывать маршрут. Мастер сообщит, сколько времени уйдёт на плавание. В обмен на бесплатную поездку от вас и ваших спутников ожидают посильную помощь экипажу во время плавания.", description: "Вы много лет плавали на морском судне. Вы видели могучие шторма, глубоководных чудовищ и тех, кто хотел отправить вас на дно. Первая любовь осталась далеко за горизонтом, и настало время попробовать что-то новое.\n\nРешите вместе с Мастером, на каком корабле вы до этого плавали. Это было торговое, пассажирское, исследовательское или пиратское судно? Насколько оно прославилось (в хорошем или дурном смысле)? Много ли вы путешествовали? Оно всё еще на плаву, потоплено или утеряно?\n\nКем вы были на борту — боцманом, капитаном, лоцманом, коком или кем-то другим? Кем были капитан и его первый помощник? Вы расстались с экипажем в хороших отношениях или поссорились с ними?"));
    await backgrounds.put("hermit", Background.smart(name: "Отшельник", coins: 500, items: {items.get("scroll case")!: 1, items.get("winter blanket")!: 1, items.get("common clothes")!: 1, items.get("herbalism kit")!: 1}, proficiencies: {proficiencies.get("herbalism kit")!}, skillChecks: {skillChecks.get("medicine")!, skillChecks.get("religion")!}, skillName: "Откровение", skill: "Тихое уединение в долгом отшельничестве дало вам доступ к великому откровению. Точная природа этого откровения зависит от характера вашего уединения. Это может быть истина о вселенной, божествах, влиятельных созданиях на внешних планах, или силах природы. Это может быть место, которое никто и никогда не видел. Вы могли обнаружить что-то, что давно было забыто, или найти реликвию прошлого, способную переписать историю. Это может быть информация, которая может причинить вред тем, кто изгнал вас, и тем самым ставшая причиной возвращения в общество.\n\nПридумайте вместе с Мастером детали вашего откровения и его влияние на кампанию.", description: "Вы значительную часть своей жизни прожили в уединении — либо в закрытой общине, такой как монастырь, либо вообще в одиночестве. Вдали от шумного общества вы нашли тишину, спокойствие, а возможно, и ответы на важные вопросы."));
    await backgrounds.put("acolyte", Background.smart(name: "Прислужник", coins: 1500, items: {items.get("holy symbol")!: 1, items.get("prayer book")!: 1, items.get("incense stick")!: 5, items.get("cassock")!: 1, items.get("common clothes")!: 1}, skillChecks: {skillChecks.get("insight")!, skillChecks.get("religion")!}, skillName: "Приют для верующих", skill: "Вы и ваши спутники можете рассчитывать на бесплатное лечение и уход в храмах, святынях и других подобных местах, посвящённых вашей вере. Вам придётся предоставить материальные компоненты для заклинаний, если таковые понадобятся. Те, кто разделяют вашу веру, могут обеспечить вам (но только вам) скромное существование.\n\nУ вас также могут быть связи с каким-то конкретным храмом, посвящённым вашему божеству или пантеону, в котором у вас есть жилая комната. Пока вы находитесь с этим храмом в хороших отношениях, находясь неподалёку от него, вы можете попросить у его служителей помощи, если она не подвергнет их опасности.", description: "Вы провели свою жизнь, служа в храме, посвящённому какому-то конкретному богу или же пантеону богов. Вы — посредник между царством небесным и миром живых. Вы совершали священные ритуалы и приносили жертвоприношения для того чтобы молящиеся могли предстать пред ликом богов. Вы не обязательно жрец — совершение священных обрядов не то же самое, что направление божественной силы.\n\nВыберите божество, пантеон богов или полубожественную сущность из тех, что перечислены в приложении Б книги игрока или предложены Мастером, и продумайте вместе с Мастером природу вашего религиозного служения. Вы были младшим служкой в храме, с детства помогающим священникам? Или вы верховный жрец, получивший видение, как можно послужить своему богу? Возможно, вы — лидер небольшого культа, не имеющего своего храма, или даже представитель оккультных сил, служивший чудовищному повелителю, но отрёкшийся от него."));
    await backgrounds.put("soldier", Background.smart(name: "Солдат", coins: 1000, items: {items.get("insignia of rank")!: 1, items.get("enemy trophy")!: 1, items.get("bone dice")!: 1, items.get("common clothes")!: 1}, proficiencies: {proficiencies.get("dice sets")!, proficiencies.get("vehicles(land)")!}, skillChecks: {skillChecks.get("athletics")!, skillChecks.get("intimidation")!}, skillName: "Воинское звание", skill: "Будучи солдатом, вы заслужили звание. Солдаты, верные военной организации, которой вы раньше принадлежали, всё еще признают вашу власть и влияние, и они подчиняются вам, если их звание ниже вашего. С помощью своего звания вы можете оказывать влияние на других солдат и брать во временное пользование простое снаряжение или лошадей. Возможно, вас пропустят внутрь военного лагеря или крепости, если к вашему званию отнесутся с уважением.", description: "Сколько вы помните, в вашей жизни всегда была война. С молодости вы проходили тренировки, учились использовать оружие и доспехи, изучали технику выживания, включая то, как оставаться живым на поле боя. Вы могли быть частью армии страны или отряда наёмников, а может, были местным ополченцем во время войны.\n\nВыбрав эту предысторию, определите вместе с Мастером, в какой военной организации вы состояли, до какого звания вы дослужились, и что вам за это время довелось пережить. Что это было, регулярная армия, городская стража или деревенское ополчение? Это могла быть частная армия наёмников дворянина или самостоятельный бродячий отряд наёмников."));
  }

  bool get protected => _protected;

  set protected(bool value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _protected = value;
  }

  Map<Item, int> get items => _items;

  /*void addItems(Map<Item, int> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for (int i = 0; i < value.length; i++) {
      items.add(value.elementAt(i));
    }
  }*/

  void removeItem(Item value) {
    _items.remove(value);
  }

  Set<String> get languages => _languages;

  void addLanguages(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _languages.addAll(value);
  }

  void removeLanguage(String value) {
    _languages.remove(value);
  }

  Set<Proficiency> get proficiencies => _proficiencies;

  void addProficiencies(Set<Proficiency> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for (int i = 0; i < value.length; i++) {
      _proficiencies.add(value.elementAt(i));
    }
  }

  void removeProficiencies(Proficiency value) {
    _proficiencies.remove(value);
  }

  Set<SkillCheck> get skillChecks => _skillChecks;

  void addSkillChecks(Set<SkillCheck> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    for (int i = 0; i < value.length; i++) {
      _skillChecks.add(value.elementAt(i));
    }
  }

  void removeSkillChecks(SkillCheck value) {
    _skillChecks.remove(value);
  }

  String get skill => _skill;

  set skill(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skill = value;
  }

  String get skillName => _skillName;

  set skillName(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _skillName = value;
  }

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

  double get coins => _coins;

  set coins(double value) {
    _coins = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Background && runtimeType == other.runtimeType &&
              _name == other._name && _description == other._description &&
              _skillName == other._skillName && _skill == other._skill &&
              _skillChecks == other._skillChecks &&
              _proficiencies == other._proficiencies &&
              _coins == other._coins && _items == other._items &&
              _languages == other._languages && _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^ _description.hashCode ^ _skillName.hashCode ^ _skill
          .hashCode ^ _skillChecks.hashCode ^ _proficiencies.hashCode ^ _coins
          .hashCode ^ _items.hashCode ^ _languages.hashCode ^ _protected
          .hashCode;


}
