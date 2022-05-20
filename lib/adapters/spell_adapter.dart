/*
import 'package:dnd_companion/data/characteristics/damage_type.dart';
import 'package:dnd_companion/data/dice/dice.dart';
import 'package:dnd_companion/data/equipment/item.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:hive/hive.dart';

class SpellAdapter extends TypeAdapter<Spell> {
  @override
  Spell read(BinaryReader reader) {
    final String name = reader.readString();
    final int level = reader.readInt();
    final school = reader.readString();
    final String description = reader.readString();
    final List<String> higherDescription = reader.readStringList();
    final int range = reader.readInt();
    final bool verbal = reader.readBool();
    final bool somatic = reader.readBool();
    final Map<Item, int> materials = Map.castFrom(reader.readMap());
    final bool ritual = reader.readBool();
    final String duration = reader.readString();
    final bool concentration = reader.readBool();
    final bool bonus = reader.readBool();
    final int castingTime = reader.readInt();
    final String savingModifier = reader.readString();
    final bool armorPenetration = reader.readBool();
    final DamageType damageType = reader.read();
    final Map<int, List<Dice>> impact = Map.castFrom(reader.readMap());
    final int constImpact = reader.readInt();
    final bool protected = reader.readBool();
    return Spell(
        name,
        level,
        school,
        description,
        higherDescription,
        range,
        verbal,
        somatic,
        materials,
        ritual,
        duration,
        concentration,
        bonus,
        castingTime,
        savingModifier,
        armorPenetration,
        damageType,
        impact,
        constImpact,
        protected);
  }

  @override
  final typeId = 71;

  @override
  void write(BinaryWriter writer, Spell obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.level);
    writer.writeString(obj.school);
    writer.writeString(obj.description);
    writer.writeStringList(obj.higherDescription);
    writer.writeInt(obj.range);
    writer.writeBool(obj.verbal);
    writer.writeBool(obj.somatic);
    writer.writeMap(obj.materials);
    writer.writeBool(obj.ritual);
    writer.writeString(obj.duration);
    writer.writeBool(obj.concentration);
    writer.writeBool(obj.bonus);
    writer.writeInt(obj.castingTime);
    writer.writeString(obj.savingModifier);
    writer.writeBool(obj.armorPenetration);
    writer.write(obj.damageType);
    writer.writeMap(obj.impact);
    writer.writeInt(obj.constImpact);
    writer.writeBool(obj.protected);
  }
}
*/
