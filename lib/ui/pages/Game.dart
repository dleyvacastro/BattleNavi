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
  Widget build(BuildContext context) {

    
    Widget getBoardIcon(index){
      if (controller.currentPlayer == "A"){
        if (controller.ships.contains(index)){
          var boatOrientation = controller.orientations[index];
          if (boatOrientation[0] == "U"){
            return Image(image: AssetImage("assets/boatv_${boatOrientation[1]}.png"), width: 50, height: 50,);
          } else if (boatOrientation[0] == "D") {
            if (boatOrientation[1] == 1) {
              return Image(image: AssetImage("assets/boatv_0.png"), width: double.infinity, height: double.infinity,);
            } else {
              return Image(image: AssetImage("assets/boatv_1.png"), width: double.infinity, height: double.infinity,);
            }
          }
          else if (boatOrientation[0] == "L") {
            if (boatOrientation[1] == 1) {
              return Image(image: AssetImage("assets/boath_0.png"), width: double.infinity, height: double.infinity,);
            } else {
              return Image(image: AssetImage("assets/boath_1.png"), width: double.infinity, height: double.infinity,);
            }
          } else {
            return Image(image: AssetImage("assets/boath_${boatOrientation[1]}.png"), width: 50, height: 50,);
          }
        } else {
          return const Icon(Icons.waves, color: Colors.blue, size: 50,);
        }
      } else {
        if (controller.pressed.contains(index)){
          if (controller.ships.contains(index)){
            return const Icon(Icons.whatshot,color: Colors.red, size: 50,);
          } else {
            return const Icon(Icons.close, color: Colors.grey, size: 50,);

          }
        } else {
          return const Icon(Icons.waves, color: Colors.blue, size: 50,);

        }
      }
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: controller.currentPlayer == 'A' ? Colors.teal : Colors.red,
      ),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Text('Let\'s Play Player ${controller.currentPlayer}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Container(
                  // alingto center
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
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
                          controller.checkWin(index);
                          setState(() {});
                        },

                        child: getBoardIcon(index)
                    )
                  ),
                )
              ],
            ),
          )),
    );
  }
}
