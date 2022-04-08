import 'package:hive/hive.dart';
class Test1 {
  String name;
  Test2 test2;
  Test1(this.name, this.test2);
  @override
  String toString() {
    return 'Test1{name: $name, test2: $test2}';
  }
}
class Test2{
  int num;
  Test1? test1;
  Test2(this.num, this.test1);
  Test2.low(this.num);
  @override
  String toString() {
    return 'Test2{num: $num, test1: $test1}';
  }
}
class Test1Adapter extends TypeAdapter<Test1>{
  @override
  Test1 read(BinaryReader reader) {
    final String name = reader.readString();
    final Test2 test2 = reader.read();
    return Test1(name, test2);
  }

  @override
  final int typeId = 222;

  @override
  void write(BinaryWriter writer, Test1 obj) {
    writer.writeString(obj.name);
    writer.write(obj.test2);
  }
}
class Test2Adapter extends TypeAdapter<Test2>{
  @override
  Test2 read(BinaryReader reader) {
    final int num = reader.readInt();
    final Test1 test1 = reader.read();
    return Test2(num, test1);
  }

  @override
  final int typeId = 223;

  @override
  void write(BinaryWriter writer, Test2 obj) {
    writer.writeInt(obj.num);
    writer.write(obj.test1);
  }
}
