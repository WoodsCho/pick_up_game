import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_up_game/common/color.dart';

import 'package:pick_up_game/screen/home.dart';
import 'package:pick_up_game/screen/signUp/sign_up.dart';
import 'package:pick_up_game/user/profile_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to home screen on successful login
      Get.off(() => ProfileAuth(), transition: Transition.noTransition);

      return userCredential;
    } catch (e) {
      // Print error message on login failure
      print('Failed to sign in with Google: $e');
      Get.snackbar('로그인 실패', 'Google 로그인에 실패했습니다.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: StreamBuilder<User?>(
          stream: null,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('asset/img/logo.png'),
                SizedBox(
                  height: 30.0,
                ),
                _appleLoginButton(),
                SizedBox(height: 2,),
                _googleloginButton()
              ],
            );
          }),
    );
  }

  Widget _googleloginButton() {
    return SignInButton(
      Buttons.GoogleDark,
      onPressed: signInWithGoogle,
      
    );
  }
  Widget _appleLoginButton() {
    return SignInButton(Buttons.Apple, onPressed: (){});
  }
}
