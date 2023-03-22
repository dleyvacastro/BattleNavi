import 'package:batlle/ui/controller/GameController.dart';
import 'package:batlle/ui/pages/MyHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    GameController controller = Get.find();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Game'),
          ),
          body: Center(

            child: ListView(
              children: <Widget>[
                Container(
                  // alingto center
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Let\'s Play', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {
                          // go back
                          controller.changePlayer();
                          Get.back();
                        },
                        child: Text('Return'),
                      )
                    ],
                  ),
                ),

                GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.aspectRatio*6/5,

                  crossAxisCount: 5,
                  shrinkWrap: true,
                  children: List.generate(
                    25,
                    (index) => InkWell(
                        onTap: () {
                          if (controller.currentPlayer == "A"){
                            print("$index");
                            controller.addShip(index);
                          } else{
                            controller.addPressed(index);
                            setState(() {});
                          }
                        },
                        child: GridTile(

                            child: Container(
                              width: 10,
                              height: 10,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Icon(controller.checkShip(index) && controller.pressed.contains(index) ? Icons.circle : !controller.checkShip(index) && controller.pressed.contains(index) ? Icons.close : Icons.question_mark),
                        ))),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
