import 'dart:io';

import 'package:get/get.dart';

class GameController extends GetxController {
  var ships = [].obs;
  var pressed = [].obs;
  var currentPlayer = "A";
  var counter = 0.obs;
  //var score = 0.obs;
  var orientation = "U";
  var icons = ["U","R","D","L"].obs;

  void changePlayer() {
    currentPlayer = currentPlayer == "A" ? "B" : "A";
  }

  void addShip(int ship) {
    if (!ships.contains(ship)){
      ships.add(ship);

      if (orientation == "U"){
        ships.add(ship - 5);
      } else if (orientation == "R"){
        ships.add(ship + 1);
      } else if (orientation == "D"){
        ships.add(ship + 5);
      } else if (orientation == "L"){
        ships.add(ship - 1);
      }
      counter += 2;

    }

    if (counter >= 4 && currentPlayer == "A") {
      Get.back();
      currentPlayer = "B";
    }

    print("Counter: $counter");
  }

  void addPressed(int ship){
    pressed.add(ship);
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
    bool win = true;
    for (var i in ships){
      if (!pressed.contains(i)){
        win = false;
      }
    }
    if (win){
      Get.back();
      Get.snackbar("You Win", "You Win in ${pressed.length} shots");
      reset();
    }

  }
  void reset() {
    ships.clear();
    pressed.clear();
    orientation = "U";
    counter = 0.obs;
  }
}
