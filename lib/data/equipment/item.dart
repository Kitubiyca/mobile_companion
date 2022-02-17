class Item{

  String _name;
  String _description;
  int _weight;
  int _cost;
  Set<String> _notes;
  bool _protected;

  static List<Item> _items = [];

  Item(this._name, this._description, this._weight, this._cost, this._notes,
      this._protected){_items.add(this);}

  Item.extendedConstructor(this._name, this._description, this._weight, this._cost, this._notes,
      this._protected);

  bool get protected => _protected;

  Set<String> get notes => _notes;

  addNotes(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.add(value);
  }

  removeNotes(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.remove(value);
  }

  int get cost => _cost;

  set cost(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _cost = value;
  }

  int get weight => _weight;

  set weight(int value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _weight = value;
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
}