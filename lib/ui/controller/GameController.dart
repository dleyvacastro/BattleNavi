import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  var ships = [].obs;
  var pressed = [].obs;
  var orientations = {}.obs;
  var currentPlayer = "A";
  var counter = 0.obs;
  //var score = 0.obs;
  var orientation = "U";
  var icons = ["U","R","D","L"].obs;
  var valid = false.obs;
  var hasWinner = false.obs;

  void changePlayer() {
    currentPlayer = currentPlayer == "A" ? "B" : "A";
  }

  void showInvalidDialog(context, String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            Text(message),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      )
    );
  }

  void addShip(int ship) {
    if (counter > 3){
      // remove the first two elements of the list
      ships.removeRange(0, 2);
      counter -= 2;
    }

    if (!ships.contains(ship) && counter <=3){
      bool valid = true;
      if (orientation == "U"){
        if (ship > 4 && !ships.contains(ship - 5)){
          ships.add(ship);
          ships.add(ship - 5);
          counter += 2;
          orientations[ship] = ["U", 0];
          orientations[ship-5] =  ["U", 1];
        } else {
          valid = false;
          print('invalid');
        }
      } else if (orientation == "R"){
        if (ship % 5 != 4 && !ships.contains(ship + 1)){
          ships.add(ship);
          ships.add(ship + 1);
          counter += 2;
          orientations[ship] = ["R", 0];
          orientations[ship+1] =  ["R", 1];
        } else {
          valid = false;
        }
      } else if (orientation == "D"){
        if (ship < 20 && !ships.contains(ship + 5)){
          ships.add(ship);
          ships.add(ship + 5);
          counter += 2;
          orientations[ship] = ["D", 0];
          orientations[ship+5] =  ["D", 1];
        } else {
          valid = false;
        }
      } else if (orientation == "L"){
        if (ship % 5 != 0 && !ships.contains(ship - 1)){
          ships.add(ship);
          ships.add(ship - 1);
          counter += 2;
          orientations[ship] = ["L", 0];
          orientations[ship-1] =  ["L", 1];
        }  else {
          valid = false;
        }
      }
      if(!valid){
        //Get.snackbar("Invalid Position", "You can't place the ship there");
        showInvalidDialog(Get.context, 'Invalid position.');
      }

    }



    // //if (counter >= 4 && currentPlayer == "A") {
    //   //Get.back();
    //   currentPlayer = "B";
    // }
  }

  void addPressed(int ship){
    if (!pressed.contains(ship)){
      pressed.add(ship);
    }
  }

  List validPosition(int index){
    var valid = [];
    if (index % 5 != 0) {
    valid.add(index - 1);
    }
    if (index % 5 != 4) {
      valid.add(index + 1);
    }
    if (index > 4) {
      valid.add(index - 5);
    }
    if (index < 20) {
      valid.add(index + 5);
    }
    return valid;
  }

  bool checkShip(int ship){
    return ships.contains(ship);
  }

  void rotateOrientation(){ // si
    if (orientation == "U"){
      orientation = "R";
    } else if (orientation == "R"){
      orientation = "D";
    } else if (orientation == "D"){
      orientation = "L";
    } else if (orientation == "L"){
      orientation = "U";
    }
  }

  void checkWin(ship){
    bool win = (ships.isEmpty || pressed.isEmpty) ? false : true;
    for (var i in ships){
      if (!pressed.contains(i)){
        win = false;
      }
    }
    if (win){
      Get.back();
      showInvalidDialog(Get.context, "You Win in ${pressed.length} shots");
      reset();
    }

  }
  void reset() {
    ships.clear();
    pressed.clear();
    orientation = "U";
    counter = 0.obs;
    currentPlayer = "A";
  }
}
