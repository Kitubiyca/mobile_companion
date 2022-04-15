import 'package:dnd_companion/data/character/character.dart';
import 'package:dnd_companion/data/character/class/class.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.openDrawer();
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  alignment: AlignmentDirectional(0, 0),
                  fit: BoxFit.fitHeight,
                  image: AssetImage("resources/rock.jpg")),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04,
                      bottom: MediaQuery.of(context).size.height * 0.04),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset("resources/icons/dnd.png")),
                ),
                _drawerElement("Заклинания", "/spells"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Предметы", "/items"),
              ],
            ),
          ),
        ),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        endDrawerEnableOpenDragGesture: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: AlignmentDirectional(0.4, 0),
                fit: BoxFit.fitHeight,
                image: AssetImage("resources/backgrounds/characters.jpg")),
          ),
          child: Column(
            children: [
              Container(
                //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                height: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.07,
                child: const Center(
                  child: Text(
                    "Персонажи",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xffebd8b5),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1d262d),
                      Color(0xff58606b),
                      Color(0xff1d262d)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              FutureBuilder(
                  future: Hive.openBox<Character>('Characters'),
                  builder: (context, box) {
                    if (box.hasData) {
                      var characters = box.data as Box;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: characters.length,
                        itemBuilder: (BuildContext context, index) => Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                image: const DecorationImage(
                                  fit: BoxFit.none,
                                  image: AssetImage("resources/paper.jpg"),
                                ),
                              ),
                              child: InkWell(
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, "/characters/view",
                                      arguments: characters.getAt(index))
                                },
                                child: ListTile(
                                  leading: Container(
                                      child: Image.asset(
                                          "resources/icons/question-mark.png"),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(35)),
                                      )),
                                  title: Text(
                                    characters.getAt(index).name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    _getStringClasses(characters.getAt(index)),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (box.hasError) {
                        return const Center(
                          child: Text("Loading Error",
                              style: TextStyle(
                                fontSize: 30,
                              )),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String _getStringClasses(Character character) {
    String ret = "";
    if (character.characterClass.length == 1) {
      ret += character.race.name + " ";
      ret += character.characterClass.keys.elementAt(0).name;
      ret += " уровня ";
      ret += character.characterClass.values.elementAt(0).toString();
    } else {
      for (Class obj in character.characterClass.keys) {
        ret += "/";
        ret += obj.name;
        ret += " ";
        ret += character.characterClass[obj]!.toString();
      }
      if (ret != "") ret = ret.substring(1);
      ret = character.race.name + " " + ret;
    }
    return ret;
  }

  Widget _drawerElement(String name, String path) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        image: const DecorationImage(
          fit: BoxFit.none,
          image: AssetImage("resources/paper.jpg"),
        ),
      ),
      child: InkWell(
        onTap: () => {Navigator.pushNamed(context, path)},
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
