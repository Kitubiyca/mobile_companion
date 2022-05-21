// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_dependency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassDependencyAdapter extends TypeAdapter<ClassDependency> {
  @override
  final int typeId = 4;

  @override
  ClassDependency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClassDependency.mainClass;
      case 1:
        return ClassDependency.subClass;
      case 2:
        return ClassDependency.none;
      default:
        return ClassDependency.mainClass;
    }
  }

  @override
  void write(BinaryWriter writer, ClassDependency obj) {
    switch (obj) {
      case ClassDependency.mainClass:
        writer.writeByte(0);
        break;
      case ClassDependency.subClass:
        writer.writeByte(1);
        break;
      case ClassDependency.none:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassDependencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
