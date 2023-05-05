import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pick_up_game/common/color.dart';
import 'package:pick_up_game/component/custom_text.dart';
import 'package:pick_up_game/screen/Guest/recruit/recruit_form.dart';

import 'guest_recruitment.dart';

class GuestMain extends StatefulWidget {
  const GuestMain({Key? key}) : super(key: key);

  @override
  State<GuestMain> createState() => _GuestMainState();
}

class _GuestMainState extends State<GuestMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              TabBar(
                physics: ScrollPhysics(),
                isScrollable: true,
                padding: EdgeInsets.only(left: 16),
                labelPadding: EdgeInsets.only(right: 10),
                indicatorPadding: EdgeInsets.only(right: 13),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: PRIMARY_COLOR,
                unselectedLabelColor: Colors.black,
                indicatorColor: SECOND_PRIMARY_COLOR,
                tabs: [
                  CustomMainText(text: '구인'),
                  CustomMainText(text: '구팀'),
                  CustomMainText(text: '픽업')
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GuestRecruitment(),
            Center(child: CustomMainText(text: '구팀')),
            Center(child: CustomMainText(text: '픽업'))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            setState(() {
              Get.off(RecruitForm(), transition: Transition.cupertino);
            });
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
