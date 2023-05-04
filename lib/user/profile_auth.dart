import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/common/color.dart';
import 'package:pick_up_game/screen/profile_page.dart';

import '../screen/home.dart';
import '../screen/signUp/sign_up.dart';

class ProfileAuth extends StatefulWidget {
  const ProfileAuth({Key? key}) : super(key: key);

  @override
  State<ProfileAuth> createState() => _ProfileAuthState();
}


class _ProfileAuthState extends State<ProfileAuth> {
  @override
  void initState() {
    super.initState();
    _checkProfileCompletion();
  }
  Future<bool> isProfileComplete(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot userDocument =
    await firestore.collection('users').doc(userId).get();

    if (userDocument.exists) {
      // 프로필이 완료되었는지 확인

      bool hasName = userDocument['name'] != null;
      bool hasLocation = userDocument['location'] != null;
      bool hasAge = userDocument['age'] != null;
      bool hasGender = userDocument['gender'] != null;

      return
          hasName &&

          hasLocation &&
          hasAge &&
          hasGender;
    }

    return false;
  }
// isProfileComplete 함수를 이곳으로 옮깁니다.
  bool? isLoading;
  Future<void> _checkProfileCompletion() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool profileComplete = await isProfileComplete(user.uid);
      setState(() {
        isLoading = false;
      });
      if (profileComplete) {
        Get.offAll(() => Home(), transition: Transition.noTransition);
      } else {
        Get.offAll(() => SignUp(),transition: Transition.cupertino);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/logo.png'),
            SizedBox(height: 128,)
          ],
        )),


      ),
    );
  }
}
