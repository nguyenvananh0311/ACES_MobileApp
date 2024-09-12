import 'package:ems/activities/scanQRcode.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/attendanceView/attendanceComponent.dart';
import '../assets/widget_component/attendanceView/attendanceReason.dart';
import '../l10n/app_localizations.dart';
import '../models/attendance/attendance.dart';
import '../models/attendance/branch.dart';

import '../services/apiService.dart';
import '../services/location.dart';
import 'attendanceHistory.dart';

class AttendanceScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const AttendanceScreen({super.key, required this.companyId, required this.employeeId});

  @override
  _AttendanceState createState() => _AttendanceState();
}


bool compareTimes(TimeOfDay time1, TimeOfDay time2) {
  if (time1.hour < time2.hour) {
    return true;
  } else if (time1.hour == time2.hour && time1.minute < time2.minute) {
    return true;
  }
  return false;
}

TimeOfDay parseTime(String timeString) {
  final format = DateFormat.Hms();
  final dateTime = format.parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

class _AttendanceState extends State<AttendanceScreen> {
  late Future<List<dynamic>> futureData;
  final TextEditingController _reasonController = TextEditingController();
  bool isLoading = false;
  TimeOfDay timeNow = TimeOfDay.now();
  TimeOfDay endOfMorning = const TimeOfDay(hour: 12, minute: 30);

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchAttendance(widget.employeeId, widget.companyId,null),
    ]);
  }
  Future<bool> _checkLocationAndShowDialog(Attendance attendance, Branch branch) async {
    setState(() {
      isLoading = true;
    });

    bool isCorrectLocation = await checkLocation(branch.latitude, branch.longitude, branch.distance);
    setState(() {
      isLoading = false;
    });

    if (isCorrectLocation) {
      if((compareTimes(attendance.morCheckInStandard!, timeNow) && compareTimes(timeNow, attendance.morCheckOutStandard!) && attendance.morCheckIn == null)
      || (compareTimes(timeNow, attendance.morCheckOutStandard!) && attendance.morCheckIn != null)
      || (compareTimes(attendance.aftCheckInStandard!, timeNow) && attendance.aftCheckIn == null)
      || (compareTimes(timeNow, attendance.aftCheckOutStandard!) && attendance.aftCheckIn != null)) {
        showReasonDialog(context, _reasonController, _reloadData, widget.employeeId, widget.companyId, true,branch.name );
      }
      else{
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanQRScreen(employeeId: widget.employeeId, companyId: widget.companyId,branch: branch.name,)),
        );
        setState(() {
          futureData = fetchData();
        });
      }
    }
    return isCorrectLocation;
  }


  void _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, request again
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      // Handle appropriately, maybe show a dialog
    }
  }

  void _reloadData() {
    setState(() {
      futureData = fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM y').format(now);

    return Scaffold(
      appBar: CustomAppBarScreen(
        title: localization!.attendance,
        actions: IconButton(
              icon: const Icon(Icons.history, size: 30, color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceHistoryScreen(
                      companyId: widget.companyId,
                      employeeId: widget.employeeId,
                    ),
                  ),
                );
              },
            ),
        isBack: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final attendance = snapshot.data![0].response;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x0f53a8c7),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 1, color: Colors.lightBlueAccent)
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              Text(DateFormat('EEEE').format(now), style: const TextStyle(fontSize: 18),),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.calendar_month_rounded, size: 70, color: Colors.lightBlueAccent,)
                        ],
                      ),
                    ]
                  )
                ),

                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(localization.morning, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        const SizedBox(height: 5.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AttendanceComponent(timeDiff: attendance?.morCheckInDiff, time: attendance?.morCheckIn, status: "in",),
                            const SizedBox(height: 5,),
                            AttendanceComponent(timeDiff: attendance?.morCheckOutDiff, time: attendance?.morCheckOut, status: "out",),
                          ],
                        ),
                        const SizedBox(height: 15.0,),
                        Text(localization.afternoon, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        const SizedBox(height: 5.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AttendanceComponent(timeDiff: attendance?.aftCheckInDiff, time: attendance?.aftCheckIn, status: "in",),
                            const SizedBox(height: 5,),
                            AttendanceComponent(timeDiff: attendance?.aftCheckOutDiff, time: attendance?.aftCheckOut, status: "out",),
                          ],
                        ),
                      ],
                    ),
                  ),

                const Spacer(),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                  onPressed: () async {
                    var response = await ApiService().fetchBranch(widget.employeeId, widget.companyId);
                    if (response.isSuccess) {
                      List<Branch>? branches = response.response;
                      bool isCorrectBranch = false;
                      for(int i =0; i< branches!.length; i++){
                         bool result = await _checkLocationAndShowDialog(attendance!, branches[i]);
                         if(result){
                           isCorrectBranch = true;
                           break;
                         }
                      }
                      if(!isCorrectBranch){
                        showErrorDialog(context);
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: localization.cannot_check_in,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.lightBlueAccent)
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        Text("Scan now", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        SizedBox(width: 10,),
                        Icon(Icons.qr_code_scanner, color: Colors.white,),
                        Spacer(),
                      ],
                    ),
                  )
                  ,
                ),
                const SizedBox(height: 20,)
              ],
            );
          } else {
            return Center(child: Text(localization.no_data));
          }
        },
      ),
    );
  }
}
