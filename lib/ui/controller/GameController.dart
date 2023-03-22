import 'package:get/get.dart';

class GameController extends GetxController {
  var ships = [].obs;
  var pressed = [].obs;
  var currentPlayer = "A";
  var counter = 0.obs;

  void changePlayer() {
    currentPlayer = currentPlayer == "A" ? "B" : "A";
  }

  void addShip(int ship) {
    counter++;
    if (counter >= 4 && currentPlayer == "A") {
      Get.back();
      currentPlayer = "B";
    }

    ships.add(ship);
    print("Counter: $counter");
  }

  void addPressed(int ship){
    pressed.add(ship);
  }

  bool checkShip(int ship){
    return ships.contains(ship);
  }

  void reset() {
    ships.clear();
  }
}
