import 'package:dnd_companion/adapters/background_adapter.dart';
import 'package:dnd_companion/adapters/feat_adapter.dart';
import 'package:dnd_companion/adapters/race_adapter.dart';
import 'package:dnd_companion/adapters/resist_adapter.dart';
import 'package:dnd_companion/adapters/skill_check_adapter.dart';
import 'package:dnd_companion/adapters/sub_race_adapter.dart';
import 'package:dnd_companion/adapters/weapon_hotkey_adapter.dart';
import 'package:dnd_companion/data/characteristics/spell_slots.dart';
import 'package:dnd_companion/data/skill/proficiency.dart';
import 'package:dnd_companion/screens/characters/character_view.dart';
import 'package:dnd_companion/screens/characters/characters_list.dart';
import 'package:dnd_companion/screens/items/item_view.dart';
import 'package:dnd_companion/screens/items/items_list.dart';
import 'package:dnd_companion/screens/main_menu.dart';
import 'package:dnd_companion/screens/spells/spells_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'adapters/damage_type_adapter.dart';
import 'adapters/dice_adapter.dart';
import 'data/equipment/armor.dart';
import 'data/equipment/item.dart';
import 'data/equipment/weapon.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/spells': (context) => const SpellList(),
        '/spells/view': (context) => const SpellView(),
        '/items': (context) => const ItemList(),
        '/items/view': (context) => const ItemView(),
        '/characters': (context) => const CharacterList(),
        '/characters/view': (context) => const CharacterView(),
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
  Hive.registerAdapter(SubRaceAdapter());
  Hive.registerAdapter(WeaponAdapter());
  Hive.registerAdapter(WeaponHotkeyAdapter());

  var settings = await Hive.openBox("settings");
  if(!settings.containsKey("initializedData")){

    Box<SkillCheck> skillCheckBox = await Hive.openBox<SkillCheck>("SkillChecks");
    Box<Proficiency> proficiencyBox = await Hive.openBox<Proficiency>("Proficiencies");
    Box<Item> itemBox = await Hive.openBox<Item>("Items");
    Box<Spell> spellBox = await Hive.openBox<Spell>("Spells");

    await SkillCheck.unpack(skillCheckBox);
    await Proficiency.unpack(proficiencyBox);
    await Item.unpack(itemBox, proficiencyBox);
    await Weapon.unpack(itemBox, proficiencyBox);
    await Armor.unpack(itemBox, proficiencyBox);
    await Spell.unpack(spellBox, itemBox);

    //SubRace subRace = SubRace.smart(name: "Человек");
    //Class cClass = Class.smart(name: "Воин", savingChecks: {"str", "con"});
    //Box<Character> characterBox = await Hive.openBox<Character>("Characters");
    //Character character = Character.smart(name: "Астерион", characterClass: {cClass: 7}, race: subRace, stats: {"str": 14, "dex": 9, "con": 12, "int": 8, "wis": 5, "cha": 11});
    //character.inventory[itemBox.getAt(0)!] = 1;
    //character.inventory[itemBox.getAt(2)!] = 1;
    //character.inventory[itemBox.getAt(5)!] = 1;
    //character.inventory[itemBox.getAt(7)!] = 1;

    //character.weaponHotkeys.add(WeaponHotkey.smart("Удар посохом", itemBox.getAt(0)! as Weapon));
    //character.weaponHotkeys.add(WeaponHotkey.smart("Удар палицей", itemBox.getAt(7)! as Weapon));

    //await characterBox.add(character);

    //characterBox.getAt(0)!.inventory[itemBox.getAt(0)!] = 1;
    //characterBox.getAt(0)!.inventory[itemBox.getAt(2)!] = 1;
    //characterBox.getAt(0)!.inventory[itemBox.getAt(5)!] = 1;
    //characterBox.getAt(0)!.inventory[itemBox.getAt(7)!] = 1;

    //SubRace subRace1 = SubRace.smart(name: "Тифлинг");
    //Class cClass1 = Class.smart(name: "Чародей", savingChecks: {"con", "cha"});
    //Class cClass2 = Class.smart(name: "Воин", savingChecks: {"str", "con"});
    //Class cClass3 = Class.smart(name: "Плут", savingChecks: {"dex", "int"});
    //Character character1 = Character.smart(name: "Ифни", characterClass: {cClass1: 5, cClass2: 3, cClass3: 2}, race: subRace1, stats: {"str": 9, "dex": 11, "con": 14, "int": 13, "wis": 5, "cha": 13});
    //character1.inventory[itemBox.getAt(3)!] = 1;
    //character1.inventory[itemBox.getAt(6)!] = 1;
    //character1.inventory[itemBox.getAt(7)!] = 1;
    //await characterBox.add(character1);

    //await characterBox.close();

    await skillCheckBox.close();
    await proficiencyBox.close();
    await itemBox.close();
    await spellBox.close();

    settings.put("initializedData", true);
  }
  settings.close();
  return;
}