import 'package:dnd_companion/data/character/class/sub_class.dart';
import 'package:hive/hive.dart';

class SubClassAdapter extends TypeAdapter<SubClass>{

  @override
  read(BinaryReader reader) {

    return SubClass();
  }

  @override
  final int typeId = 114;

  @override
  void write(BinaryWriter writer, obj) {

  }

}