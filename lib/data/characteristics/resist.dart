class Resist{

  int _bludgeoning = 0; //Дробящий
  int _sound = 0; //Звук
  int _radiant = 0; //Излучение
  int _acid = 0; //Кислота
  int _piercing = 0; //Колющий
  int _necrotic = 0; //Некротический
  int _fire = 0; //Огонь
  int _psychic = 0; //Психический
  int _slashing = 0; //Рубящий
  int _force = 0; //Силовой
  int _cold = 0; //Холод
  int _electric = 0; //Электрический
  int _poison = 0;

  Resist(
      this._bludgeoning,
      this._sound,
      this._radiant,
      this._acid,
      this._piercing,
      this._necrotic,
      this._fire,
      this._psychic,
      this._slashing,
      this._force,
      this._cold,
      this._electric,
      this._poison); //Яд

  Resist.empty(); // 0-neutral 1-resist 2-immune -1-vulnerable

  Resist.copyFrom(Resist object){
    _bludgeoning = object.bludgeoning;
    _sound = object.sound;
    _radiant = object.radiant;
    _acid = object.acid;
    _piercing = object.piercing;
    _necrotic = object.necrotic;
    _fire = object.fire;
    _psychic = object.psychic;
    _slashing = object.slashing;
    _force = object.force;
    _cold = object.cold;
    _electric = object.electric;
    _poison = object.poison;
  }

  int get poison => _poison;

  set poison(int value) {
    _poison = value;
  }

  int get electric => _electric;

  set electric(int value) {
    _electric = value;
  }

  int get cold => _cold;

  set cold(int value) {
    _cold = value;
  }

  int get force => _force;

  set force(int value) {
    _force = value;
  }

  int get slashing => _slashing;

  set slashing(int value) {
    _slashing = value;
  }

  int get psychic => _psychic;

  set psychic(int value) {
    _psychic = value;
  }

  int get fire => _fire;

  set fire(int value) {
    _fire = value;
  }

  int get necrotic => _necrotic;

  set necrotic(int value) {
    _necrotic = value;
  }

  int get piercing => _piercing;

  set piercing(int value) {
    _piercing = value;
  }

  int get acid => _acid;

  set acid(int value) {
    _acid = value;
  }

  int get radiant => _radiant;

  set radiant(int value) {
    _radiant = value;
  }

  int get sound => _sound;

  set sound(int value) {
    _sound = value;
  }

  int get bludgeoning => _bludgeoning;

  set bludgeoning(int value) {
    _bludgeoning = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resist &&
          runtimeType == other.runtimeType &&
          _bludgeoning == other._bludgeoning &&
          _sound == other._sound &&
          _radiant == other._radiant &&
          _acid == other._acid &&
          _piercing == other._piercing &&
          _necrotic == other._necrotic &&
          _fire == other._fire &&
          _psychic == other._psychic &&
          _slashing == other._slashing &&
          _force == other._force &&
          _cold == other._cold &&
          _electric == other._electric &&
          _poison == other._poison;

  @override
  int get hashCode =>
      _bludgeoning.hashCode ^
      _sound.hashCode ^
      _radiant.hashCode ^
      _acid.hashCode ^
      _piercing.hashCode ^
      _necrotic.hashCode ^
      _fire.hashCode ^
      _psychic.hashCode ^
      _slashing.hashCode ^
      _force.hashCode ^
      _cold.hashCode ^
      _electric.hashCode ^
      _poison.hashCode;

}