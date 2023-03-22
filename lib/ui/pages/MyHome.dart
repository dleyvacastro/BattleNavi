import 'package:batlle/ui/pages/Game.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:batlle/ui/controller/GameController.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameController controller = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Battle Nave GetX',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battle Navi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Start Game'),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Game());
                },
                child: const Text('Start Game'),
              ),
              ElevatedButton(
                onPressed: (){
                  var ships = controller.ships;
                  print("Ships: $ships");
                  print("Current Player: ${controller.currentPlayer}");
                },
                child: const Text('Show Ships'),
              )
            ],
          ),
        ),
      ),
    );
  }
}