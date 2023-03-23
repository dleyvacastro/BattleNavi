import 'dart:math';

import 'package:batlle/my_flutter_app_icons.dart';
import 'package:batlle/ui/controller/GameController.dart';
import 'package:batlle/ui/pages/MyHome.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var icons = {
    "U": Icons.arrow_upward,
    "R": Icons.arrow_forward,
    "D": Icons.arrow_downward,
    "L": Icons.arrow_back,
  };

  GameController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    
    Icon getBoardIcon(index){
      if (controller.currentPlayer == "A"){
        if (controller.ships.contains(index)){
          return const Icon(Icons.directions_boat, color: Colors.brown);
        } else {
          return const Icon(Icons.waves, color: Colors.blue);

        }
      } else {
        if (controller.pressed.contains(index)){
          if (controller.ships.contains(index)){
            return const Icon(Icons.whatshot,color: Colors.red);
          } else {
            return const Icon(Icons.close, color: Colors.grey);

          }
        } else {
          return const Icon(Icons.waves, color: Colors.blue,);

        }
      }
    }
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
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Text('Let\'s Play Player ${controller.currentPlayer}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      controller.currentPlayer == "B" ? ElevatedButton(
                        onPressed: () {
                          // go back
                          controller.changePlayer();
                          controller.reset();
                          Get.back();
                        },
                        child: const Text('Return'),
                      ) : ElevatedButton.icon(
                        onPressed: () {
                          controller.rotateOrientation();
                          setState(() {
                          });
                        },
                        icon: Icon(icons[controller.orientation]), label: const Text('Rotate'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: controller.currentPlayer == "A" && controller.counter >=4 ? ElevatedButton(
                          onPressed: () {
                            Get.back();
                            controller.changePlayer();
                          },
                          child: const Text('Return'),
                        ) : Container(),
                      ),

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

                            controller.addShip(index);
                          } else{
                            controller.addPressed(index);
                          }
                          setState(() {});
                          controller.checkWin(index);
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
                          child: getBoardIcon(index),
                        ))),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
