import 'package:flutter/material.dart';

import '../common/color.dart';

class NextButton extends StatelessWidget {
  final dynamic onPressed;
  final double width;



  const NextButton({
  required this.onPressed,
  required this.width,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.all(5),
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: onPressed,
          child: Text("다음"),),

    )
    ;
  }
}
class NextAndPrevioussButton extends StatelessWidget {
  final dynamic onPressed;

  final int flex;
  final String text;
  final Color color;
  final Color textColor;




  const NextAndPrevioussButton({
    required this.textColor,
    required this.text,
    required this.flex,
    required this.onPressed,
  required this.color
    ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,

        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: textColor,
                elevation: 0,



                backgroundColor: color,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: onPressed,
            child: Text(text),),
        ),

    )
    ;
  }
}
