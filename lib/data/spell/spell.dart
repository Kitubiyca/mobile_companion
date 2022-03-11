import 'package:dnd_companion/data/equipment/item.dart';

class Spell{

  String _name;
  String _description;
  int _level;
  int _range;
  int _cast;
  int _duration;
  bool _verbal;
  bool _somatic;
  bool _ritual;
  bool _concentration;
  Map<Item, int> _materials;
  bool _protected;

  static List<Spell> spells = [];

}