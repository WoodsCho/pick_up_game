import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pick_up_game/screen/home.dart';
import 'package:pick_up_game/screen/login_screen.dart';
class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user){
          if (user.hasData){
            //TODO: 내부 파이어베이스 유저정보를 조회 with user.data.uid
            return const Home();
          } else {
            return LoginScreen();
          }
        });
  }
}
