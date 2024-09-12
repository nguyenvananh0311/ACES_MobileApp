
import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/workingDay/calendar.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';


class WorkingdayScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const WorkingdayScreen({super.key, required this.companyId, required this.employeeId,});

  @override
  _WorkingDayState createState() => _WorkingDayState();
}

class _WorkingDayState extends State<WorkingdayScreen> {
  late Future<List<dynamic>> futureData;
  bool isLoading = false;
  TimeOfDay timeNow = TimeOfDay.now();
  TimeOfDay endOfMorning = const TimeOfDay(hour: 12, minute: 30);

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchWorkingDay(widget.employeeId, widget.companyId),
      ApiService().fetchHoliday(widget.employeeId, widget.companyId),
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
      appBar: CustomAppBarScreen(title: localization!.workingTime, isBack: true,),
      body: FutureBuilder<List<dynamic>>(
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
            final workingDays = snapshot.data![0].response;
            final holidays = snapshot.data![1].response;
            return CalendarWidget(workdays: workingDays, holidays: holidays);
          } else {
            return  Center(child: Text(localization.no_data));
          }
        },
      ),
    );
  }
}
