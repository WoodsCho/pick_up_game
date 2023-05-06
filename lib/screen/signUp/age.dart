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
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return
          SizedBox(
            height: 400,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,

                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16,top: 10),
                    child: TextButton(onPressed: () => Navigator.pop(context), child: Text('Done',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)),
                  )
                ],
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: ScrollDatePicker(

              onDateTimeChanged: (newDateTime) {
                setState(() {
                  _selectedDate = newDateTime;
                  _age = DateTime.now().year - _selectedDate.year;
                  widget.onAgeChanged(_age);
                });
              }, selectedDate: _selectedDate,
              maximumDate: DateTime.utc(2023,12,31),
              locale: Locale('ko'),
              options: DatePickerOptions(isLoop: false,itemExtent: 40),
              scrollViewOptions: DatePickerScrollViewOptions(year: ScrollViewDetailOptions(label: '년',margin: EdgeInsets.only(right: 8)),
                  month: ScrollViewDetailOptions(label: '월',margin: EdgeInsets.only(right: 8)),
                  day: ScrollViewDetailOptions(label: '일',margin: EdgeInsets.only(right: 8))),


        ),
            ),
          );
      },
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

    return SafeArea(
      bottom: true,
      child: Container(
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
      ),
    );
  }
}