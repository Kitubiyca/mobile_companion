class Skill{

  String _name;
  String _description;
  int _castTime;
  int _duration;
  int _range;
  Set<String> _notes;
  List<String> _usedClassPoints;
  bool _protected;

  static List<ActiveSkill> skills = [];

}