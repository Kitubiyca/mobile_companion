import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SpellList extends StatefulWidget {
  const SpellList({Key? key}) : super(key: key);

  @override
  State<SpellList> createState() => _SpellListState();
}

class _SpellListState extends State<SpellList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void callback(){setState(() {});}
  Offset? _tapPos;

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
        floatingActionButton: Utils.diceOverlayMenu(context),
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
                _drawerElement("Персонажи", "/characters"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Предметы", "/items"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Расы", "/races"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Классы", "/classes"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Черты", "/feats"),
                const SizedBox(
                  height: 20,
                ),
                _drawerElement("Предыстории", "/backgrounds"),
              ],
            ),
          ),
        ),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
        endDrawerEnableOpenDragGesture: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: AlignmentDirectional(-0.1, 0),
                fit: BoxFit.fitHeight,
                image: AssetImage("resources/backgrounds/spells.jpg")),
          ),
          child: Column(
            children: [
              Container(
                //padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                height: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.07,
                child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: (){_scaffoldKey.currentState!.openDrawer();},
                        color: const Color(0xffebd8b5),
                      ),
                      const Spacer(),
                      const Text(
                        "Заклинания",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffebd8b5),
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add, size: 30,),
                        onPressed: (){Navigator.pushNamed(context, "/spells/add", arguments: callback);},
                        color: const Color(0xffebd8b5),
                      ),
                    ]
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
                  future: Hive.openBox<Spell>('Spells'),
                  builder: (context, box) {
                    if (box.hasData) {
                      var spells = box.data as Box;
                      return Flexible(
                        child: GestureDetector(
                          onLongPressDown: (details) => setState(() => _tapPos = details.globalPosition),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            //shrinkWrap: true,
                            itemCount: spells.length,
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
                                    onLongPress: () async {
                                      if(_tapPos != null){
                                        await showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(_tapPos!.dx, _tapPos!.dy, _tapPos!.dx, 0),
                                          items: [
                                            const PopupMenuItem(
                                              child: Text("Удалить"),
                                              value: true,
                                            ),
                                          ],
                                          elevation: 8.0,
                                        ).then((value){
                                          if(value == true){
                                            if(spells.getAt(index).protected){
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Невозможно удалить стандартное заклинание"),));
                                            } else {
                                              spells.deleteAt(index);
                                              setState(() {});
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Пользовательское заклинание было успешно удалено"),));
                                            }
                                          }
                                        });
                                      }
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/spells/view",
                                          arguments: spells.getAt(index));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                          child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image(image: (spells.getAt(index) as Spell).getImage(),)),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(
                                              width: 2,
                                              color: const Color(0xff3f3f3f),
                                            )
                                          )),
                                      title: Text(
                                        spells.getAt(index).name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        _getStringLevel(spells.getAt(index)),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
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

  String _getStringLevel(Spell spell) {
    if(spell.level == 0) return "Заговор";
    if(spell.level > 0 && spell.level < 10) return "Заклинание уровня ${spell.level}";
    return "Не определено";
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
        onTap: (){Hive.box<Spell>("Spells").close();Navigator.pushReplacementNamed(context, path);},
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
