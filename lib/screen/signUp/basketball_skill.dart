
import 'package:flutter/material.dart';
import 'package:pick_up_game/component/bottom_button.dart';
import 'package:pick_up_game/component/custom_text.dart';

import '../../common/color.dart';

class BasketballSkillInputPage extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;
  final void Function(int)? onSkillChanged;

  const BasketballSkillInputPage({required this.onPrevious,required this.onNext, required this.onSkillChanged, Key? key}) : super(key: key);

  @override
  _BasketballSkillInputPageState createState() => _BasketballSkillInputPageState();
}

class _BasketballSkillInputPageState extends State<BasketballSkillInputPage> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(mainText: '농구실력', subText: '을\n입력해주세요'),

              SizedBox(height: 30),
              Column(
                children: [

                  SizedBox(height: 50,),
                  Text(
                  _currentValue.toString(),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                  SizedBox(height: 30),
                  Slider(
                    value: _currentValue.toDouble(),
                    min: 0,
                    activeColor: PRIMARY_COLOR,
                    max: 99,
                    divisions: 99,
                    label: _currentValue.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentValue = value.toInt();
                      });
                    },
                  ),],
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 4, color: Colors.blue.shade100),borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('75-99 = 상\n\n50-74 = 중\n\n0-49   = 하',

                        style: TextStyle(fontSize: 20,
                            color: PRIMARY_COLOR),),
                    ),
                  ),
                ],
              ),


            ],
          ),
          Align(
            alignment: Alignment.bottomCenter
            ,child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [NextAndPrevioussButton(onPressed: widget.onPrevious, flex: 1, text: '이전', color: Colors.grey.shade300,textColor: Colors.grey),
              NextAndPrevioussButton(onPressed:() {
                widget.onSkillChanged?.call(_currentValue);
                widget.onNext();
              }, flex: 2, text: '다음',color: PRIMARY_COLOR,textColor: Colors.white)],
          )
          )]
        ),
      ),
    );
  }
}