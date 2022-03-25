import 'package:dnd_companion/data/spell/spell.dart';
import 'package:flutter/material.dart';

class SpellView extends StatefulWidget {
  const SpellView({Key? key}) : super(key: key);

  @override
  State<SpellView> createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  @override
  Widget build(BuildContext context) {
    final Spell spell = ModalRoute.of(context)!.settings.arguments as Spell;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60,),
          Text(
            "Название: " + spell.name,
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Описание: " + spell.description,
            style: const TextStyle(fontSize: 24),
          ),
          (spell.higherDescription.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Описания уровней:",
                      style: TextStyle(fontSize: 24),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: spell.higherDescription.length,
                        itemBuilder: (BuildContext context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  spell.higherDescription[index],
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            )),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )
              : Container()),
          Text(
            "Дальность: " + spell.range.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Метки: " + spell.getMarks(),
            style: const TextStyle(fontSize: 24),
          ),
          Visibility(
              visible: spell.materials.isNotEmpty,
              maintainSize: false,
              child: Text(
                "Материалы: " + spell.getMaterials(),
                style: const TextStyle(fontSize: 24),
              )),
          Text(
            "Продолжительность: " + spell.duration.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Время применения: " + spell.castingTime.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Уровень: " + spell.level.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            "Тип урона: " +
                (spell.damageType.isEmpty()
                    ? "Физический"
                    : spell.damageType.getTypes()),
            style: const TextStyle(fontSize: 24),
          ),
          Visibility(
              visible: spell.impact.isNotEmpty,
              maintainSize: false,
              child: Text(
                "Воздействие: " + spell.getDices(),
                style: const TextStyle(fontSize: 24),
              )),
          Text(
            "Постоянное воздействие: " + spell.constImpact.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    ));
  }
}
