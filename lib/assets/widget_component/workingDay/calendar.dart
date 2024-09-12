import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/workingday/publicHoliday.dart';
import '../../../models/workingday/workday.dart';
import 'holidayWidget.dart';
import 'workdayWidget.dart';


class CalendarWidget extends StatefulWidget {
  final List<WorkDay> workdays;
  final List<PublicHoliday> holidays;

  const CalendarWidget({super.key, required this.workdays, required this.holidays});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(now.year, 1, 1),
          lastDay: DateTime.utc(now.year, 12, 31),
          focusedDay: _focusedDay,
          // calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay!, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, // Ẩn nút thay đổi định dạng
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),

          ),

          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: 12.0,
            ),
            weekendStyle: TextStyle(
              fontSize: 12.0,
            ),
          ),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Color(0xF3F3F3FF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border(
                top: BorderSide(color: Colors.blue, width: 1),
                left: BorderSide(color: Colors.blue, width: 1),
                right: BorderSide(color: Colors.blue, width: 1),
                bottom: BorderSide(color: Colors.blue, width: 1),
              ),
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),

            ),
            defaultTextStyle: TextStyle(
              color: Colors.black,
            ),
            outsideTextStyle: TextStyle(
              color: Colors.grey,
            ),
            todayTextStyle: TextStyle(
              color: Colors.black
            )
          ),
          // onFormatChanged: (format) {
          //   if (_calendarFormat != format) {
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   }
          // },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _getEventsForDay,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final isHoliday = widget.holidays.any((holiday) => isSameDay(holiday.date, day));
              final weekday = dayOfWeek(day.weekday);
              final isNotWorkday = widget.workdays.any((workday) => workday.day == weekday && !workday.status);

              if (isHoliday) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(5),
                  child: Center(child: Text('${day.day}', style: const TextStyle(color: Colors.white))),
                );
              } else
                if (isNotWorkday) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFC2BFBF),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(5),
                  child: Center(child: Text('${day.day}', style: const TextStyle(color: Colors.white))),
                );
              } else {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xF3F3F3FF),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(5),
                  child: Center(child: Text('${day.day}', style: const TextStyle(color: Colors.black))),
                );
              }
            },
            outsideBuilder: (context, day, focusedDay) {
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                height: 40,
                width: 40,
                margin: const EdgeInsets.all(5),
                child: Center(child: Text('${day.day}', style: const TextStyle(color: Colors.grey))),
              );
            },
            headerTitleBuilder: (context, header) {
              return Container(
                alignment: Alignment.center, // Center-align the header
                child: Text(
                  DateFormat('MMMM y').format(header),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
        // Workday and Holiday Tabs
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                 TabBar(
                  tabs: [
                    Tab(text: localization?.workdayTime),
                    Tab(text: localization?.holiday),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      WorkdayWidget(workdays: widget.workdays),
                      HolidayWidget(
                        holidays: widget.holidays,
                        onHolidaySelected: (selectedDate) {
                          setState(() {
                            _selectedDay = selectedDate;
                            _focusedDay = selectedDate; // Optionally update focusedDay as well
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    final holidaysForDay = widget.holidays
        .where((holiday) => isSameDay(holiday.date, day))
        .toList();

    return holidaysForDay;
  }

  int dayOfWeek(int weekday){
    if(weekday == 7) {
      return 0;
    } else {
      return weekday;
    }
  }
}
