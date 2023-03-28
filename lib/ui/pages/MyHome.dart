import 'package:batlle/ui/pages/Game.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:batlle/ui/controller/GameController.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Battle Nave GetX',
      theme: ThemeData(
        fontFamily: 'Michroma',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battle Navi'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Battleship Game',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Game());
                },
                child: const Text('Start Game'),
              ),
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Game By: Daniel Leyva, Camilo Fernandez, Felipe Martinez, Guillermo Ribero',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
