import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pick_up_game/component/custom_text.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../common/color.dart';
import '../../component/bottom_button.dart';

class AgeInputPage extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;
  final Function(int) onAgeChanged;

  const AgeInputPage({Key? key, required this.onPrevious,required this.onNext, required this.onAgeChanged})
      : super(key: key);

  @override
  _AgeInputPageState createState() => _AgeInputPageState();
}

class _AgeInputPageState extends State<AgeInputPage> {
  late DateTime _selectedDate;
  late int _age;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _age = DateTime.now().year - _selectedDate.year;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child){
        return Theme(data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: PRIMARY_COLOR,
          )
        ), child: child!);
      },
        locale: Locale(ko),
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _age = DateTime.now().year - _selectedDate.year;
        widget.onAgeChanged(_age);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(mainText: '나이', subText: '를\n입력해주세요'),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text('생일을 선택해주세요'),
                ),
              ],
            ),


            SizedBox(
              height: 16.0,
            ),
            Center(
              child: Text(
                '$_age 살',
                style: TextStyle(fontSize: 30.0,color: PRIMARY_COLOR
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),

          ],
        ),
          Align(
            alignment: Alignment.bottomCenter
            ,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [NextAndPrevioussButton(onPressed: widget.onPrevious, flex: 1, text: '이전', color:Colors.grey.shade300 ,textColor: Colors.grey),
                NextAndPrevioussButton(onPressed:  _age >= 1 ? widget.onNext : null, flex: 2, text: '다음',color: PRIMARY_COLOR,textColor: Colors.white)]
          ),
          )]
      ),
    );
  }
}