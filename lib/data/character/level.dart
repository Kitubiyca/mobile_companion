import '../skill/skill.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import '../skill/skill.dart';
import 'class.dart';
import '../skill/skill_check.dart';

class Level {

  Class _class;
  int _level;
  int _proficiencyBonus;
  int _abilityScoreImprovement;

  Set<SkillCheck> _skillChecks;
  Set<Skill> _skills;
  Set<ActiveSkill> _activeSkills;
  Set<Spell> _spells;
  Set<Cantrip> _cantrips;

  int _activeSkillsOnLevel;
  int _knownCantrips;
  int _knownSpells;
  int _knownInvocations;

  Dice _martialArts;
  int _unarmoredMovement;
  Dice _sneakAttack;

  List<int> _classPoints;
  List<int> _spellLevels;

  bool _protected;

}