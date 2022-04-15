import 'package:dnd_companion/adapters/armor_adapter.dart';
import 'package:dnd_companion/adapters/background_adapter.dart';
import 'package:dnd_companion/adapters/character_adapter.dart';
import 'package:dnd_companion/adapters/class_adapter.dart';
import 'package:dnd_companion/adapters/feat_adapter.dart';
import 'package:dnd_companion/adapters/level_adapter.dart';
import 'package:dnd_companion/adapters/proficiency_adapter.dart';
import 'package:dnd_companion/adapters/race_adapter.dart';
import 'package:dnd_companion/adapters/resist_adapter.dart';
import 'package:dnd_companion/adapters/skill_check_adapter.dart';
import 'package:dnd_companion/adapters/sub_race_adapter.dart';
import 'package:dnd_companion/adapters/weapon_adapter.dart';
import 'package:dnd_companion/adapters/weapon_hotkey_adapter.dart';
import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/characteristics/spell_slots.dart';
import 'package:dnd_companion/data/hotkeys/weapon_hotkey.dart';
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
import 'adapters/item_adapter.dart';
import 'adapters/spell_adapter.dart';
import 'data/character/class/class.dart';
import 'data/character/race/race.dart';
import 'data/character/race/sub_race.dart';
import 'data/characteristics/damage_type.dart';
import 'data/dice/dice.dart';
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
    await skillCheckBox.addAll(SkillCheck.getStandartSkillChecks());
    await skillCheckBox.close();

    Box<Spell> spellBox = await Hive.openBox<Spell>("Spells");
    await spellBox.addAll(Spell.getStandartSpells());
    await spellBox.close();

    //Box<Weapon> weaponBox = await Hive.openBox<Weapon>("Weapons");
    //await weaponBox.addAll(Weapon.getStandartWeapons());
    //await weaponBox.close();

    Box<Item> weaponBox = await Hive.openBox<Item>("items");
    await weaponBox.addAll(Weapon.getStandartWeapons());


    Box<Armor> armorBox = await Hive.openBox<Armor>("Armor");
    await armorBox.addAll(Armor.getStandartArmor());
    await armorBox.close();

    SubRace subRace = SubRace.smart(name: "Человек");
    Class cClass = Class.smart(name: "Воин", savingChecks: {"str", "con"});
    Box<Character> characterBox = await Hive.openBox<Character>("Characters");
    Character character = Character.smart(name: "Василий", characterClass: {cClass: 7}, race: subRace, stats: {"str": 14, "dex": 9, "con": 12, "int": 8, "wis": 5, "cha": 11, });
    character.inventory[weaponBox.getAt(0)!] = 1;
    character.inventory[weaponBox.getAt(2)!] = 1;
    character.inventory[weaponBox.getAt(5)!] = 1;
    character.inventory[weaponBox.getAt(7)!] = 1;
    await characterBox.add(character);
    await weaponBox.close();
    await characterBox.close();

    settings.put("initializedData", true);
  }
  settings.close();
  return;
}