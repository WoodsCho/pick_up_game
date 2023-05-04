import 'package:flutter/material.dart';
import 'package:pick_up_game/component/custom_text.dart';

import '../../common/color.dart';
import '../../component/bottom_button.dart';

class LocationInputPage extends StatefulWidget {
  final void Function(String) onLocationChanged;
  final void Function() onNext;
  final void Function() onPrevious;

  const LocationInputPage(
      {required this.onPrevious,
      required this.onNext,
      required this.onLocationChanged});

  @override
  _LocationInputPageState createState() => _LocationInputPageState();
}

class _LocationInputPageState extends State<LocationInputPage> {
  String _selectedLocation = '서울특별시';

  final List<String> _locations = [
    '서울특별시',
    '경기도',
    '인천광역시',
    '강원도',
    '충청북도',
    '충청남도',
    '대전광역시',
    '경상북도',
    '대구광역시',
    '울산광역시',
    '부산광역시',
    '경상남도',
    '전라북도',
    '전라남도',
    '광주광역시',
    '제주특별자치도',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(mainText: '지역', subText: '을\n입력해주세요.'),
                SizedBox(
                  height: 100,
                ),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20),
                  menuMaxHeight: 300,
                  isExpanded: true,
                  value: _selectedLocation,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocation = value!;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(
                        location,
                        style: TextStyle(fontSize: 20, color: PRIMARY_COLOR),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NextAndPrevioussButton(
                      onPressed: widget.onPrevious,
                      flex: 1,
                      text: '이전',
                      color: Colors.grey.shade300,
                        textColor: Colors.grey
                    ),
                    NextAndPrevioussButton(
                      onPressed: () {
                        widget.onLocationChanged(_selectedLocation);
                        widget.onNext();
                      },
                      flex: 2,
                      text: '다음',
                      color: PRIMARY_COLOR,textColor: Colors.white
                    )
                  ]),
            )
          ],
        ));
  }
}
