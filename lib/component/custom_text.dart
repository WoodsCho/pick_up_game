import 'package:flutter/material.dart';
import 'package:pick_up_game/common/color.dart';

class CustomText extends StatelessWidget {
  final String mainText;
  final String subText;

  const CustomText({required this.mainText, required this.subText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: mainText,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 35,
                color: PRIMARY_COLOR),
            children:  <TextSpan>[
          TextSpan(text: subText, style:const TextStyle(fontWeight: FontWeight.w300))
        ]));
  }
}
class CustomMainText extends StatelessWidget {
  final String text;

  const CustomMainText({
  required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: 30,

    fontWeight: FontWeight.w700),);

  }
}
