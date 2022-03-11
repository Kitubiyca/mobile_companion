class Item{

  late String _name;
  late String _description;
  late int _weight;
  late int _cost;
  late Set<String> _notes;
  late bool _protected;

  static List<Item> _items = [];

  Item(this._name, this._description, this._weight, this._cost, this._notes, this._protected);

  Item.withAdd(this._name, this._description, this._weight, this._cost, this._notes, this._protected){_items.add(this);}

  Item.copyFrom(Item object){
    _name = object.name;
    _description = object.description;
    _weight = object.weight;
    _cost = object.cost;
    _notes.addAll(object.notes);
    _protected = false;
  }

  bool get protected => _protected;

  Set<String> get notes => _notes;

  addNote(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.add(value);
  }

  addNotes(Set<String> value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.addAll(value);
  }

  removeNote(String value) {
    if (_protected) throw Exception("Denied access to protected data.");
    _notes.remove(value);
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _description == other._description &&
          _weight == other._weight &&
          _cost == other._cost &&
          _notes == other._notes &&
          _protected == other._protected;

  @override
  int get hashCode =>
      _name.hashCode ^
      _description.hashCode ^
      _weight.hashCode ^
      _cost.hashCode ^
      _notes.hashCode ^
      _protected.hashCode;
}