import 'package:flutter/material.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    int _startHour = 0;
    int _endHour = 24;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20,),
          Row(
            children: List.generate(
              _endHour - _startHour + 1,
                  (index) {
                final hour = _startHour + index;

                final time = (hour % 24).toString().padLeft(2, '0') + ':00';
                final isSelected = (hour >= _startHour && hour <= _endHour);

                if (hour == -1 || hour == 24) {
                  return Column(
crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      time,

                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (hour != 24)
                      Container(
                      ),
                  ]);
                }

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (_startHour == hour && _endHour == hour) {
                        _startHour = 0;
                        _endHour = 24;
                      } else if (_startHour == hour) {
                        _startHour += 1;
                      } else if (_endHour == hour) {
                        _endHour -= 1;
                      } else if (hour < _startHour) {
                        _startHour = hour;
                      } else if (hour > _endHour) {
                        _endHour = hour;
                      }
                    });
                  },
                  child: Column(

                      children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (hour != 24)
                    Container(
                      width: 60.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ]),
                );
              },
            ),
          ),
        SizedBox(width: 20,)],
      ),
    );
  }
}
