
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/controller/authcontroller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(AuthController(), permanent: true);
  }
}