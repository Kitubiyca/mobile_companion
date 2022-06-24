import 'dart:math';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class Dice{

  int _count;
  int _max;
  int _add;

  Dice(this._count, this._max, this._add);

  List<int> rollAdvantage(bool advantage){
    int ret1 = 0;
    int ret2 = 0;
    if(_max > 0){
      ret1 = Random().nextInt(_max);
      ret2 = Random().nextInt(_max);
    }
    ret1 += _count;
    ret2 += _count;
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
      if(_max > 0){
        ret.add(Random().nextInt(_max) + 1);
      } else {
        ret.add(0);
      }
    }
    for (int element in ret) {ret[0]+=element;}
    ret[0] += _add;
    return ret;
  }

  int get count => _count;

  int get max => _max;

  String get name => _count.toString() + "к" + _max.toString() + (_add == 0 ? "" : (_add > 0 ? " +" + _add.toString() : " " + _add.toString()));

  int get add => _add;

  set add(int value) {
    _add = value;
  }

  void rollWithAlert(BuildContext context){
    Utils.showAlertRoll(context, "Бросок " + name, {name: roll().first});
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dice &&
          runtimeType == other.runtimeType &&
          _count == other._count &&
          _max == other._max &&
          _add == other._add;

  @override
  int get hashCode => _count.hashCode ^ _max.hashCode ^ _add.hashCode;
}