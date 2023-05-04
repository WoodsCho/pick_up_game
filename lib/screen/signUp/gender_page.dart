import 'package:flutter/material.dart';
import 'package:pick_up_game/component/custom_text.dart';

import '../../common/color.dart';
import '../../component/bottom_button.dart';

class GenderInputPage extends StatefulWidget {
final Function onNext;
final Function onPrevious;
final Function(String) onGenderChanged;

GenderInputPage({required this.onPrevious,required this.onNext, required this.onGenderChanged});

@override
_GenderInputPageState createState() => _GenderInputPageState();
}

class _GenderInputPageState extends State<GenderInputPage> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
        child: Stack(
          children:[ Column(
crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(mainText: '성별', subText: '을\n선택해주세요'),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        gender = "남성";
                      });
                    },
                    child: Text("남성"),
                    style: ElevatedButton.styleFrom(
                        primary: gender == "남성" ? PRIMARY_COLOR : Colors.grey.shade300,
                    foregroundColor: gender =="남성" ? Colors.white : Colors.grey),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        gender = "여성";
                      });
                    },
                    child: Text("여성"),
                    style: ElevatedButton.styleFrom(
                        primary: gender == "여성" ? PRIMARY_COLOR : Colors.grey.shade300,
                        foregroundColor: gender =="여성" ? Colors.white : Colors.grey),
                  ),
                ],
              ),




            ],
          ),
            Align(
              alignment: Alignment.bottomCenter
              ,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [NextAndPrevioussButton(onPressed: widget.onPrevious, flex: 1, text: '이전', color: Colors.grey.shade300,textColor: Colors.grey,),
                  NextAndPrevioussButton(onPressed: () {
                    if (gender != null) {
                      widget.onGenderChanged(gender!);
                      widget.onNext();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("성별을 선택해주세요."),
                          duration: Duration(seconds: 2)));
                      null;
                    }
                  }, flex: 2, text: '다음',color: PRIMARY_COLOR,textColor: Colors.white)]
            ),
            )]
        ),

    );
  }
}