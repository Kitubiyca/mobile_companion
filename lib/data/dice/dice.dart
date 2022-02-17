import 'dart:math';

class Dice{

  int _count;
  late String _name;
  int _max;

  static List<Dice> dices = [];

  Dice(this._count, this._max){
    if(_count<1) throw Exception("Incorrect input data: expected at least 1 roll at count.");
    _name = _count.toString() + "D" + _max.toString();
    Dice.dices.add(this);
  }

  List<int> rollAdvantage(bool advantage){
    int ret1 = Random().nextInt(_max);
    int ret2 = Random().nextInt(_max);
    if (advantage){
      return ret1 > ret2 ? List<int>.filled(ret1, ret2) : List<int>.filled(ret2, ret1);
    }
    else{
      return ret1 > ret2 ? List<int>.filled(ret2, ret1) : List<int>.filled(ret1, ret2);
    }
  }

  List<int> roll(){
    List<int> ret = <int>[0];
    for(int i = 0; i<_count; i++) {
      ret.add(Random().nextInt(_max));
    }
    for (int element in ret) {ret[0]+=element;}
    return ret;
  }

  int get count => _count;

  int get max => _max;

  String get name => _name;
}