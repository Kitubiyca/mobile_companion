import 'package:dnd_companion/data/character/class/class.dart';
import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:hive/hive.dart';

class SpellAdapter extends TypeAdapter<Spell> {
  @override
  Spell read(BinaryReader reader) {
    final String name = reader.readString();
    final String description = reader.readString();
    final List<String> higherDescription = reader.readStringList();
    final int range = reader.readInt();
    final bool verbal = reader.readBool();
    final bool somatic = reader.readBool();
    final Map<Item, int> materials = Map.castFrom(reader.readMap());
    final bool ritual = reader.readBool();
    final String duration = reader.readString();
    final bool concentration = reader.readBool();
    final int castingTime = reader.readInt();
    final int level = reader.readInt();
    final bool difficultyClass = reader.readBool();
    final bool armorPenetration = reader.readBool();
    final String savingModifier = reader.readString();
    final DamageType damageType = reader.read();
    final List<Dice> impact = List.castFrom(reader.readList());
    final int constImpact = reader.readInt();
    final Set<Class> classes = Set.castFrom(reader.readList().toSet());
    final bool protected = reader.readBool();
    return Spell(
        name,
        description,
        higherDescription,
        range,
        verbal,
        somatic,
        materials,
        ritual,
        duration,
        concentration,
        castingTime,
        level,
        difficultyClass,
        armorPenetration,
        savingModifier,
        damageType,
        impact,
        constImpact,
        classes,
        protected);
  }

  @override
  final typeId = 71;

  @override
  void write(BinaryWriter writer, Spell obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeStringList(obj.higherDescription);
    writer.writeInt(obj.range);
    writer.writeBool(obj.verbal);
    writer.writeBool(obj.somatic);
    writer.writeMap(obj.materials);
    writer.writeBool(obj.ritual);
    writer.writeString(obj.duration);
    writer.writeBool(obj.concentration);
    writer.writeInt(obj.castingTime);
    writer.writeInt(obj.level);
    writer.writeBool(obj.difficultyClass);
    writer.writeBool(obj.armorPenetration);
    writer.writeString(obj.savingModifier);
    writer.write(obj.damageType);
    writer.writeList(obj.impact);
    writer.writeInt(obj.constImpact);
    writer.write(obj.classes.toList());
    writer.writeBool(obj.protected);
  }
}