class DamageType {

  bool _bludgeoning = false; //Дробящий
  bool _sound = false; //Звук
  bool _radiant = false; //Излучение
  bool _acid = false; //Кислота
  bool _piercing = false; //Колющий
  bool _necrotic = false; //Некротический
  bool _fire = false; //Огонь
  bool _psychic = false; //Психический
  bool _slashing = false; //Рубящий
  bool _force = false; //Силовой
  bool _cold = false; //Холод
  bool _electric = false; //Электрический
  bool _poison = false; //Яд

  DamageType(this._bludgeoning,
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
      this._poison);

  DamageType.empty();

  DamageType.copyFrom(DamageType object){
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

  bool get bludgeoning => _bludgeoning;

  set bludgeoning(bool value) {
    _bludgeoning = value;
  }

  bool get sound => _sound;

  set sound(bool value) {
    _sound = value;
  }

  bool get radiant => _radiant;

  set radiant(bool value) {
    _radiant = value;
  }

  bool get acid => _acid;

  set acid(bool value) {
    _acid = value;
  }

  bool get piercing => _piercing;

  set piercing(bool value) {
    _piercing = value;
  }

  bool get necrotic => _necrotic;

  set necrotic(bool value) {
    _necrotic = value;
  }

  bool get fire => _fire;

  set fire(bool value) {
    _fire = value;
  }

  bool get psychic => _psychic;

  set psychic(bool value) {
    _psychic = value;
  }

  bool get slashing => _slashing;

  set slashing(bool value) {
    _slashing = value;
  }

  bool get force => _force;

  set force(bool value) {
    _force = value;
  }

  bool get cold => _cold;

  set cold(bool value) {
    _cold = value;
  }

  bool get electric => _electric;

  set electric(bool value) {
    _electric = value;
  }

  bool get poison => _poison;

  set poison(bool value) {
    _poison = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DamageType &&
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