import 'package:dnd_companion/data/character/race/race.dart';
import '../skill/skill_check.dart';
import 'class.dart';

class Character{

  static List<Character> characters = [];

  String _name;
  Map<Class, int> _class;
  String _background;
  String _playerName;
  Race _race;
  String _Alignment;
  int _experience;

  Map<String, int> _stats;
  Map<String, int> _maxStats;

  //int _strength;
  //int _maxStrength;
  //int _dexterity;
  //int _maxDexterity;
  //int _constitution;
  //int _maxConstitution;
  //int _intelligence;
  //int _maxIntelligence;
  //int _wisdom;
  //int _maxWisdom;
  //int _charisma;
  //int _maxCharisma;

  int _inspiration;
  int _proficiencyBonus;

  Set<SkillCheck> _skillChecks;

}