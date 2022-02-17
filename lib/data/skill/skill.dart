class Skill{

  String _name;
  String _description;
  int _castTime;
  int _duration;
  int _range;
  Set<String> _notes;
  List<String> _usedClassPoints;
  static List<ActiveSkill> skills = [];
  bool _protected;

}