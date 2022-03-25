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
import 'data/characteristics/damage_type.dart';
import 'data/dice/dice.dart';
import 'data/equipment/item.dart';
import 'data/spell/spell.dart';
import 'screens/spells/spell_view.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DiceAdapter());
  Hive.registerAdapter(DamageTypeAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(SpellAdapter());

  Spell spell1 = Spell(
    "Волшебная стрела",
    "Вы создаете три светящихся дротика из магической силы. Каждый дротик попадает в существо на ваш выбор, видимое в пределах дистанции. Каждый дротик причиняет урон силовым полем 1к4 + 1. Все дротики атакуют одновременно, и вы можете направить их как в одно существо, так и в разных.",
    ["На больших уровнях. Если вы накладываете это заклинание, используя ячейку 2 уровня или выше, заклинание создает по одному дополнительному дротику за каждый уровень ячейки выше первого."],
    120,
    true,
    true,
    {},
    false,
    "Мгновенная",
    false,
    1,
    1,
    false,
    false,
    "",
    DamageType.smart(force: true),
    [Dice(1, 4)],
    1,
    true);

  Spell spell2 = Spell(
    "Щит",
    "Невидимый барьер из магической силы появляется, защищая вас. Вы получаете до начала своего следующего хода бонус +5 к КД, в том числе и против вызвавшей срабатывание атаки, и вы не получаете урон от волшебной стрелы.",
    [],
    0,
    true,
    true,
    {},
    false,
    "1 раунд",
    false,
    1,
    1,
    false,
    false,
    "",
    DamageType.empty(),
    [],
    5,
    true
  );

  //Spell spell = Spell('name', 'desc', ['desc1', 'desc2'], 20, true, true, {}, false, '1 day', true, 3, 7, false, false, "cha", DamageType.empty(), [], 6, false);
  Box<Spell> box = await Hive.openBox<Spell>('spells');
  box.add(spell1);
  box.add(spell2);
  box.close();

  //box.put('test', spell);
  //box.close();
  //box.deleteFromDisk();

  Item item1 = Item("Книга", "Книга, подробно рассказывающая о похождениях великого рыцаря.", 5, 25, {}, false);
  Item item2 = Item("Кошель", "", 1, 5, {"дырявый", "выцветший"}, false);
  Item item3 = Item("Лютня", "Инструмент барда.", 3, 35, {"потрескавшаяся"}, false);

  Box<Item> boxItem = await Hive.openBox<Item>('items');
  boxItem.add(item1);
  boxItem.add(item2);
  boxItem.add(item3);
  box.close();

  //Dice dice = Dice(2, 20);
  //SpellLevel obj = SpellLevel(1, 1, 2, 4, dice, 10);
  //box.put('spell', obj);
  //SpellLevel obj = box.get('spell');
  //print(obj.level);
  //print(obj.constImpact);
  //print(obj.impact.max);

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
      },
      title: 'DnD Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}