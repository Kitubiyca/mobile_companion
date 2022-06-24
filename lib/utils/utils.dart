import 'package:dnd_companion/data/dice/dice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Utils{

  static void showAlertRoll(BuildContext context, String title, Map<String, int> result){
    String alertText = "";
    int alertResult = 0;
    for(String key in result.keys){
      if(result[key] != null){
        alertText += key + ": " + result[key].toString() + "\n\n";
        alertResult += result[key]!;
      }
    }
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(title, style: const TextStyle(fontSize: 24, color: Colors.white),),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: const Color(0xff182026),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          children: [
            Flexible(flex: 1, child: Center(child: SingleChildScrollView(child: Text(alertText, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),)),
            const Flexible(flex: 1, child: Center(child: Text("=", style: TextStyle(fontSize: 40,color: Color(0xff33424f)),))),
            Flexible(flex: 1, child: Center(child: Text(alertResult.toString(), style: const TextStyle(fontSize: 50, color: Colors.white)),),),
          ],
        ),
      ),
    ));
  }

  static Widget diceOverlayMenu(BuildContext context){
    return SpeedDial(
      child: Container(
        child: Image.asset("resources/icons/dice/d20.png", width: 40, height: 40,),
        decoration: BoxDecoration(
          color: const Color(0xffc53131),
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: const Color(0xffc53131),),
        ),
      ),
      activeChild: Container(
        child: const Icon(Icons.clear_rounded, size: 40,),
        decoration: BoxDecoration(
          color: const Color(0xff182026),
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: const Color(0xff182026),),
        ),
      ),
      backgroundColor: const Color(0xffc53131),
      renderOverlay: false,
      children: [
        SpeedDialChild(
          label: "к4",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d4.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 4, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к8",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d8.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 8, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к6",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d6.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 6, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к100",
          labelStyle: const TextStyle(fontSize: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("resources/icons/dice/d10.png", width: 25, height: 25,),
              Image.asset("resources/icons/dice/d10.png", width: 25, height: 25,),
            ],
          ),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 100, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к10",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d10.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 10, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к12",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d12.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 12, 0).rollWithAlert(context);},
        ),
        SpeedDialChild(
          label: "к20",
          labelStyle: const TextStyle(fontSize: 16),
          child: Image.asset("resources/icons/dice/d20.png", width: 30, height: 30,),
          backgroundColor: const Color(0xff182026),
          onTap: (){Dice(1, 20, 0).rollWithAlert(context);},
        ),
      ],
    );
  }

}