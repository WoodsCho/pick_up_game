import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:pick_up_game/screen/home.dart';
import 'package:pick_up_game/user/login_screen.dart';
import 'package:pick_up_game/user/profile_auth.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // 사용자가 로그인한 상태입니다. 홈 화면으로 이동하세요.
      return ProfileAuth();
    } else {
      // 사용자가 로그인하지 않은 상태입니다. 로그인 화면으로 이동하세요.
      return LoginScreen();
    }
  }
}