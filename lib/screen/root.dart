import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/controller/authcontroller.dart';
import 'package:pick_up_game/model/pickup_game_user.dart';
import 'package:pick_up_game/screen/home.dart';
import 'package:pick_up_game/screen/login_screen.dart';
import 'package:pick_up_game/screen/sugnup_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            //TODO: 내부 파이어베이스 유저정보를 조회 with user.data.uid

            return FutureBuilder<PUser?>(
                future: controller.loginUser(user.data!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const Home();
                  } else {
                    return  Obx(() =>controller.user.value.uid != null ? const Home() : SignupPage(uid :user.data!.uid));
                  }
                });
          } else {
            return LoginScreen();
          }
        });
  }
}
