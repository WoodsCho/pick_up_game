import 'package:flutter/material.dart';

import '../common/color.dart';

class GuestCard extends StatelessWidget {
  const GuestCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 147,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.white),
            left: BorderSide(color: Colors.white),
            right: BorderSide(color: Colors.white),
            bottom: BorderSide(width: 2, color: inputBorderColor),
          ),
        ),
        child: Row(
          children: [
           Container(
                  height: 115,
                  width: 115,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'asset/img/gym.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

            Padding(

              padding: const EdgeInsets.all(16.0),
              child: Column(children: [Text('스포원 체육관',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),)],)),

          ],
        ),

    );
  }
}
