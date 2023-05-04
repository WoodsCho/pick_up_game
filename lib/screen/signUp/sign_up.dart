import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/common/color.dart';
import 'package:pick_up_game/screen/profile_page.dart';

import 'package:pick_up_game/screen/signUp/gender_page.dart';

import 'package:pick_up_game/screen/signUp/pickture_page.dart';
import 'package:pick_up_game/user/login_screen.dart';

import '../home.dart';
import 'age.dart';
import 'basketball_skill.dart';
import 'location.dart';
import 'name_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  bool _isLoading = false;
  String? profilePictureUrl;
  String? name;
  int? basketballSkill;
  String? location;
  int? age;
  String? gender;

  PageController _pageController = PageController();

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<void> saveUserProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'profilePictureUrl': profilePictureUrl,
      'name': name,
      'basketballSkill': basketballSkill,
      'location': location,
      'age': age,
      'gender': gender,
    });
  }

  Future<void> _backToLogin() async {
    if (!Platform.isAndroid) {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text(
              '프로필작성을 그만두시겠습니까?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('진행중인 작업이 사라집니다'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('홈으로'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.off(() => LoginScreen(),
                      transition: Transition.cupertino);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              '프로필작성을 그만두시겠습니까?',
              style: TextStyle(fontWeight: FontWeight.w500),),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('진행중인 작업이 사라집니다'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('홈으로'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.off(() => LoginScreen(),
                      transition: Transition.cupertino);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: _backToLogin,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey,
                ),
              );
            },
          ),
          title: Text('프로필 작성'),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          },
          children: [
            NameInputPage(
              onNext: nextPage,
              onNameChanged: (name) {
                setState(() {
                  this.name = name;
                });
              },
            ),
            ProfilePicturePage(
              onPrevious: previousPage,
              onNext: nextPage,
              onPictureChanged: (url) => profilePictureUrl = url,
            ),
            BasketballSkillInputPage(
              onPrevious: previousPage,
              onNext: nextPage,
              onSkillChanged: (skill) => basketballSkill = skill,
            ),
            LocationInputPage(
              onPrevious: previousPage,
              onNext: nextPage,
              onLocationChanged: (location) => this.location = location,
            ),
            AgeInputPage(
              onPrevious: previousPage,
              onNext: nextPage,
              onAgeChanged: (age) => this.age = age,
            ),
            GenderInputPage(
              onPrevious: previousPage,
              onNext: () async {
                setState(() {

                  _isLoading = true;
                });
                await saveUserProfile();
                setState(() {
                  _isLoading = false;
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Home()));
              },
              onGenderChanged: (gender) => this.gender = gender,
            )
          ],
        ),
      ),
    );
  }
}
