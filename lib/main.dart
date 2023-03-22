import 'package:batlle/ui/controller/GameController.dart';
import 'package:batlle/ui/pages/MyHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<GameController>(() => GameController());
  runApp(App());
}