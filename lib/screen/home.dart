import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pick_up_game/common/color.dart';
import 'package:pick_up_game/lay_out/deflault_layout.dart';
import 'package:pick_up_game/screen/Guest/guest_main.dart';
import 'package:pick_up_game/screen/profile_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  bool isLoading = true;

  Future signOut() async {
    try {
      print('sign out complete');
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('sign out failed');
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: bodyTextColor,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball_outlined), label: '게스트'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: '팀'),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_device_information_rounded), label: '조회'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0.2,
          title: Container(
            padding: EdgeInsets.only(left: 4,top: 10),
              height:50,
              child: Image.asset('asset/img/logo2.png',)),
          centerTitle: false,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            GuestMain(),
            Center(
              child: Container(
                child: Text('팀'),
              ),
            ),
            Center(
              child: Container(
                child: Text('신청'),
              ),
            ),
            UserProfilePage()
          ],
        ),
      ),
    );
  }
}
