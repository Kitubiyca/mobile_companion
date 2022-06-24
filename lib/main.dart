import 'package:dnd_companion/adapters/background_adapter.dart';
import 'package:dnd_companion/adapters/feat_adapter.dart';
import 'package:dnd_companion/adapters/race_adapter.dart';
import 'package:dnd_companion/adapters/resist_adapter.dart';
import 'package:dnd_companion/adapters/skill_check_adapter.dart';
import 'package:dnd_companion/adapters/weapon_hotkey_adapter.dart';
import 'package:dnd_companion/data/character/background.dart';
import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:dnd_companion/data/characteristics/experience.dart';
import 'package:dnd_companion/data/characteristics/spell_slots.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/data/skill/skill.dart';
import 'package:dnd_companion/data/structures/characteristic.dart';
import 'package:dnd_companion/data/structures/class_dependency.dart';
import 'package:dnd_companion/data/structures/rare_type.dart';
import 'package:dnd_companion/data/structures/rest.dart';
import 'package:dnd_companion/data/structures/size_type.dart';
import 'package:dnd_companion/data/structures/spellcaster_type.dart';
import 'package:dnd_companion/data/structures/stats.dart';
import 'package:dnd_companion/data/structures/weapon_feature.dart';
import 'package:dnd_companion/screens/backgrounds/backgrounds_list.dart';
import 'package:dnd_companion/screens/characters/character_add.dart';
import 'package:dnd_companion/screens/characters/character_view.dart';
import 'package:dnd_companion/screens/characters/characters_list.dart';
import 'package:dnd_companion/screens/classes/classes_list.dart';
import 'package:dnd_companion/screens/feats/feats_list.dart';
import 'package:dnd_companion/screens/items/item_view.dart';
import 'package:dnd_companion/screens/items/items_list.dart';
import 'package:dnd_companion/screens/main_menu.dart';
import 'package:dnd_companion/screens/races/races_list.dart';
import 'package:dnd_companion/screens/spells/spell_add.dart';
import 'package:dnd_companion/screens/spells/spells_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'adapters/armor_adapter.dart';
import 'adapters/dice_adapter.dart';
import 'adapters/weapon_adapter.dart';
import 'data/character/character.dart';
import 'data/character/class/class.dart';
import 'data/character/class/level.dart';
import 'data/character/class/sub_class_level.dart';
import 'data/character/race.dart';
import 'data/characteristics/damage_type.dart';
import 'data/equipment/armor.dart';
import 'data/equipment/item.dart';
import 'data/equipment/weapon.dart';
import 'data/skill/feat.dart';
import 'data/skill/skill_check.dart';
import 'data/spell/spell.dart';
import 'screens/spells/spell_view.dart';

Future<void> main() async {

  await Hive.initFlutter();

  await initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/characters',
      routes: {
        '/': (context) => const MainMenu(),
        '/characters': (context) => const CharacterList(),
        '/characters/view': (context) => const CharacterView(),
        '/characters/add': (context) => const CharacterAdd(),
        '/spells': (context) => const SpellList(),
        '/spells/view': (context) => const SpellView(),
        '/spells/add': (context) => const SpellAdd(),
        '/items': (context) => const ItemList(),
        '/items/view': (context) => const ItemView(),
        '/races': (context) => const RaceList(),
        //'/races/view': (context) => const RaceView(),
        '/classes': (context) => const ClassList(),
        //'/classes/view': (context) => const ClassView(),
        '/feats': (context) => const FeatList(),
        //'/feats/view': (context) => const FeatView(),
        '/backgrounds': (context) => const BackgroundList(),
        //'/backgrounds/view': (context) => const BackgroundView(),
      },
      title: 'DnD Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

initializeApp() async {
  SpellSlots.initialize();
  Experience.initialize();

  Hive.registerAdapter(ArmorAdapter());
  Hive.registerAdapter(BackgroundAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(ClassAdapter());
  Hive.registerAdapter(DamageTypeAdapter());
  Hive.registerAdapter(DiceAdapter());
  Hive.registerAdapter(FeatAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(LevelAdapter());
  Hive.registerAdapter(ProficiencyAdapter());
  Hive.registerAdapter(RaceAdapter());
  Hive.registerAdapter(ResistAdapter());
  Hive.registerAdapter(SkillCheckAdapter());
  Hive.registerAdapter(SpellAdapter());
  Hive.registerAdapter(WeaponAdapter());
  Hive.registerAdapter(WeaponHotkeyAdapter());
  Hive.registerAdapter(CharacteristicAdapter());
  Hive.registerAdapter(WeaponFeatureAdapter());
  Hive.registerAdapter(StatsAdapter());
  Hive.registerAdapter(SpellcasterTypeAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(RestAdapter());
  Hive.registerAdapter(SubClassAdapter());
  Hive.registerAdapter(SubClassLevelAdapter());
  Hive.registerAdapter(ClassDependencyAdapter());
  Hive.registerAdapter(RareTypeAdapter());
  Hive.registerAdapter(SizeTypeAdapter());

  Box settings = await Hive.openBox("settings");
  if(!settings.containsKey("initializedData")){

    Box<SkillCheck> skillCheckBox = await Hive.openBox<SkillCheck>("SkillChecks");
    Box<Proficiency> proficiencyBox = await Hive.openBox<Proficiency>("Proficiencies");
    Box<Item> itemBox = await Hive.openBox<Item>("Items");
    Box<Spell> spellBox = await Hive.openBox<Spell>("Spells");
    Box<Feat> featBox = await Hive.openBox("Feats");
    Box<Background> backgroundBox = await Hive.openBox("Backgrounds");
    Box<Race> raceBox = await Hive.openBox("Races");
    Box<Class> classBox = await Hive.openBox("Classes");
    Box<Character> characterBox = await Hive.openBox("Characters");

    await SkillCheck.unpack(skillCheckBox);
    await Proficiency.unpack(proficiencyBox);
    await Item.unpack(itemBox, proficiencyBox);
    await Weapon.unpack(itemBox, proficiencyBox);
    await Armor.unpack(itemBox, proficiencyBox);
    await Spell.unpack(spellBox, itemBox);
    await Feat.unpack(featBox);
    await Background.unpack(backgroundBox, proficiencyBox, skillCheckBox, itemBox);
    await Race.unpack(raceBox, skillCheckBox, proficiencyBox, spellBox);
    await Class.unpack(classBox, proficiencyBox, skillCheckBox, itemBox);
    await Character.unpack(characterBox, classBox, backgroundBox, raceBox);

    await skillCheckBox.close();
    await proficiencyBox.close();
    await itemBox.close();
    await spellBox.close();
    await featBox.close();
    await backgroundBox.close();
    await raceBox.close();
    await classBox.close();
    await characterBox.close();

    settings.put("initializedData", true);
  }
  settings.close();
  return;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}