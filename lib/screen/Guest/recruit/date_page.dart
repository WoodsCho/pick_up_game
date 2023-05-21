import 'package:flutter/material.dart';
import 'package:pick_up_game/component/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';

import '../../../common/color.dart';
import '../../../component/bottom_button.dart';

class DatePage extends StatefulWidget {
  final Function onNext;
  final Function onPrevious;
  final void Function(DateTime) onStartTimeChanged;
  final void Function(DateTime) onEndTimeChanged;

  const DatePage(
      {required this.onEndTimeChanged,
      required this.onStartTimeChanged,
      required this.onNext,
      required this.onPrevious,
      Key? key})
      : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  DateTime _selectedGameDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 00, minute: 00),
    const TimeOfDay(hour: 01, minute: 00),
  );
  late TimeRangeResult _selectedTimeRange;

  late DateTime _startTime;
  late DateTime _endTIme;

  @override
  void initState() {
    super.initState();
    _selectedTimeRange = _defaultTimeRange;
    _startTime = DateTime.now();
    _endTIme = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: CustomText(mainText: '게임시간', subText: '을\n선택해주세요'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TableCalendar(
                  pageJumpingEnabled: true,
                  calendarStyle: const CalendarStyle(isTodayHighlighted: false),
                  locale: 'ko_KO',
                  selectedDayPredicate: (date) =>
                      date.year == _selectedGameDate.year &&
                      date.month == _selectedGameDate.month &&
                      date.day == _selectedGameDate.day,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedGameDate = selectedDay;
                      _selectedGameDate =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                  headerStyle: const HeaderStyle(
                    headerMargin: EdgeInsets.symmetric(vertical: 10),
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: PRIMARY_COLOR),
                  ),
                  focusedDay: _selectedGameDate,
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
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
                    activeTextStyle: const TextStyle(color: Colors.white),
                    timeStep: 30,
                    timeBlock: 30,
                    onRangeCompleted: (range) {
                      setState(() {
                        _selectedTimeRange = range!;
                        _startTime = DateTime(
                          _selectedGameDate.year,
                          _selectedGameDate.month,
                          _selectedGameDate.day,
                          _selectedTimeRange.start.hour,
                          _selectedTimeRange.start.minute,
                        );
                        _endTIme = DateTime(
                          _selectedGameDate.year,
                          _selectedGameDate.month,
                          _selectedGameDate.day,
                          _selectedTimeRange.end.hour,
                          _selectedTimeRange.end.minute,
                        );
                      });
                    },
                    firstTime: const TimeOfDay(hour: 0, minute: 0),
                    lastTime: const TimeOfDay(hour: 24, minute: 0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${_selectedGameDate.year}년${_selectedGameDate.month}월${_selectedGameDate.day}일',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_selectedTimeRange.start.format(context)} - ${_selectedTimeRange.end.format(context)}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            NextAndPrevioussButton(
                onPressed: widget.onPrevious,
                flex: 1,
                text: '이전',
                color: Colors.grey.shade100,
                textColor: Colors.grey),
            NextAndPrevioussButton(
                onPressed: () {
                  // ignore: unnecessary_null_comparison
                  if (_selectedTimeRange == null) {
                    // 예외 처리 코드
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('시간 범위 선택 필요'),
                          content: const Text('시작 시간과 종료 시간을 선택해주세요.'),
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  widget.onStartTimeChanged(_startTime);
                  widget.onEndTimeChanged(_endTIme);
                  widget.onNext();
                },
                flex: 2,
                text: '다음',
                color: PRIMARY_COLOR,
                textColor: Colors.white)
          ]),
        ),
      ]),
    );
  }
}
