import 'package:flutter/material.dart';
import 'package:pick_up_game/common/color.dart';
import '../../component/guest_card.dart';

class GuestRecruitment extends StatefulWidget {
  const GuestRecruitment({Key? key}) : super(key: key);

  @override
  State<GuestRecruitment> createState() => _GuestRecruitmentState();
}

class _GuestRecruitmentState extends State<GuestRecruitment> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: ListView.builder(
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: inputBorderColor,
                    ),
                    height: 100.0,
                    child: Center(
                      child: Text(
                        '광고',
                        style: TextStyle(color: PRIMARY_COLOR, fontSize: 40),
                      ),
                    ),
                  ),
                );
              }
              final item = items[index - 1];
              return ListTile(
                title: GuestCard(),
              );
            },
          ),
        ),
      ),

    );
  }
}
