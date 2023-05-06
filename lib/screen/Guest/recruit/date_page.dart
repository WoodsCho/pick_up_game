import 'package:flutter/material.dart';
import 'package:pick_up_game/component/custom_text.dart';
import 'package:time_range/time_range.dart';

import '../../../common/color.dart';
import '../../../component/bottom_button.dart';

class DatePage extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;

  const DatePage({required this.onNext, required this.onPrevious, Key? key})
      : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    int _startHour = 0;
    int _endHour = 24;

    return Container(
      padding: EdgeInsets.all(16),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(mainText: '게임시간', subText: '을\n선택해주세요'),
            SizedBox(
              height: 200,
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: inputBgColor,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: TimeRange(
                fromTitle: const Text(
                  '시작시간',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: PRIMARY_COLOR,
                      fontSize: 16),
                ),
                toTitle: const Text(
                  '종료시간',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: PRIMARY_COLOR,
                      fontSize: 16),
                ),
                borderColor: Colors.white,
                backgroundColor: inputBgColor,
                activeBackgroundColor: PRIMARY_COLOR,
                activeBorderColor: Colors.white,
                activeTextStyle: TextStyle(color: Colors.white),
                timeStep: 30,
                timeBlock: 30,
                onRangeCompleted: (range) => setState(() => print(range)),
                firstTime: TimeOfDay(hour: 0, minute: 0),
                lastTime: TimeOfDay(hour: 24, minute: 0),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            NextAndPrevioussButton(
                onPressed: widget.onPrevious,
                flex: 1,
                text: '이전',
                color: Colors.grey.shade300,
                textColor: Colors.grey),
            NextAndPrevioussButton(
                onPressed: widget.onNext,
                flex: 2,
                text: '다음',
                color: PRIMARY_COLOR,
                textColor: Colors.white)
          ]),
        )
      ]),
    );
  }
}
