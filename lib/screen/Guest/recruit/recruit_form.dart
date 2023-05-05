import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/lay_out/deflault_layout.dart';
import 'package:pick_up_game/screen/Guest/recruit/date_page.dart';
import 'package:pick_up_game/screen/home.dart';

class RecruitForm extends StatefulWidget {
  const RecruitForm({Key? key}) : super(key: key);

  @override
  State<RecruitForm> createState() => _RecruitFormState();
}

class _RecruitFormState extends State<RecruitForm> {
  Future<void> _backToLogin() async {
    if (!Platform.isAndroid) {
      return showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text(
              '게시글 작성을 그만두시겠습니까?',
              style: TextStyle(fontWeight: FontWeight.w600),
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
                  Get.offAll(() => Home(), transition: Transition.fadeIn);
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
              style: TextStyle(fontWeight: FontWeight.w600),
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
                  Get.offAll(() => Home(), transition: Transition.fadeIn);
                },
              ),
            ],
          );
        },
      );
    }
  }
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

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        children: [DatePage()],
        ),
      ),
    );
  }
}
