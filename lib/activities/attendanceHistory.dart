import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/attendanceView/attendanceCard.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';


class AttendanceHistoryScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const AttendanceHistoryScreen({super.key, required this.companyId, required this.employeeId});

  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}


TimeOfDay parseTime(String timeString) {
  final format = DateFormat.Hms();
  final dateTime = format.parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

class _AttendanceHistoryState extends State<AttendanceHistoryScreen> {
  late Future<List<dynamic>> futureData;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool isLoading = false;
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchAttendance(widget.employeeId, widget.companyId, DateFormat("yyyy-MM-dd").format(_selectedDay)),
    ]);
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBarScreen(title: localization!.attendance_history, isBack: true,),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().add(const Duration(days: -365)),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                futureData = fetchData();
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
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                {
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
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(localization.error(snapshot.error.toString())));
                  } else if (snapshot.hasData) {
                    final attendance = snapshot.data![0].response;
                    return Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.all(20),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AttendanceCard(
                                  title: localization.morning,
                                  time: attendance.morCheckIn,
                                  status: "in",
                                  timeDiff: attendance?.morCheckInDiff,
                                ),
                                AttendanceCard(
                                  title: localization.morning,
                                  time: attendance.morCheckOut,
                                  status: "out",
                                  timeDiff: attendance?.morCheckOutDiff,
                                ),
                                AttendanceCard(
                                  title: localization.afternoon,
                                  time: attendance.aftCheckIn,
                                  status: "in",
                                  timeDiff: attendance?.aftCheckInDiff,
                                ),
                                AttendanceCard(
                                  title: localization.afternoon,
                                  time: '${attendance.aftCheckOut}',
                                  status: "out",
                                  timeDiff: attendance?.aftCheckOutDiff,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                      ],
                    );
                  } else {
                    return Center(child: Text(localization.no_data));
                  }
                },
              ),
          )
        ],
      )

    );
  }

}
