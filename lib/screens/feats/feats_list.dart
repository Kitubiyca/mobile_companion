import 'package:dnd_companion/data/skill/feat.dart';
import 'package:dnd_companion/data/spell/spell.dart';
import 'package:dnd_companion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FeatList extends StatefulWidget {
  const FeatList({Key? key}) : super(key: key);

  @override
  State<FeatList> createState() => _FeatListState();
}

class _FeatListState extends State<FeatList> {
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
                _drawerElement("Заклинания", "/spells"),
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
                        "Черты",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffebd8b5),
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: false,
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: (){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("WIP, currently unavailable"),));},
                          color: const Color(0xffebd8b5),
                        ),
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
                  future: Hive.openBox<Feat>('Feats'),
                  builder: (context, box) {
                    if (box.hasData) {
                      var feats = box.data as Box;
                      return Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          itemCount: feats.length,
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
                                  //onTap: (){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("WIP, currently unavailable"),));},
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/feats/view",
                                        arguments: feats.getAt(index));
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
                                      feats.getAt(index).name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      _getStringRequirement(feats.getAt(index)),
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

  String _getStringRequirement(Feat feat){
    if (feat.requirement == "") {
      return "-";
    } else{
      return "Требование: " + feat.requirement;
    }
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
        onTap: (){Hive.box<Feat>("Feats").close();Navigator.pushReplacementNamed(context, path);},
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
