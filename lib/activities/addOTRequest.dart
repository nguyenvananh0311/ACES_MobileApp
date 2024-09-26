import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widget_component/addLeaveRequestView/phoneNumberField.dart';
import '../assets/widget_component/addLeaveRequestView/reasonField.dart';
import '../assets/widget_component/addOTRequest/datetimePicker.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/leave/monthlyLeave.dart';
import '../models/overtime/overtimeRequest.dart';
import '../models/response/ApiResponse.dart';
import '../models/workingday/workday.dart';
import '../services/apiService.dart';

class AddOvertimeRequestScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final List<OvertimeRequest>? requests;
  const AddOvertimeRequestScreen({super.key, required this.companyId, required this.employeeId, this.requests});

  @override
  _AddOvertimeRequestState createState() => _AddOvertimeRequestState();
}

String _convertToBase64(PlatformFile file)  {
  File imageFile = File(file.path!);
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}
class _AddOvertimeRequestState extends State<AddOvertimeRequestScreen> {
  late Future<List<dynamic>> futureData;
  bool isLoading = false;

  late Future<ApiResponse<MonthlyLeave>> futureMonthlyLeave;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  double _totalHours = 0;
  String _fromDate = "", _toDate = "";
  String _fileName = 'No file selected', _fileBase64 = "";
  bool _dateError = false, _reasonError = false, _phoneError = false;
  String typeErrorLog = "", dateErrorLog = "";
  DateTime now = DateTime.now();


  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd MMM y HH:mm').format(now);
    _fromDate = formattedDate;
    _toDate = formattedDate;
    futureData = fetchData();
  }
  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchWorkingDay(widget.employeeId, widget.companyId),
    ]);
  }
  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
  void _calculateTotalDays() {

    DateTime? fromDate = _fromDate == ""
        ? DateTime.now()
        : DateFormat('dd MMM y HH:mm').parse(_fromDate);

    DateTime? toDate = _toDate == ""
        ? DateTime.now()
        : DateFormat('dd MMM y HH:mm').parse(_toDate);

    if ((fromDate.isBefore(toDate))) {
      setState(() {
        try{
          _totalHours = (fromDate.isAtSameMomentAs(toDate) ? 0 : (toDate.difference(fromDate).inHours.toDouble()));
          if(_totalHours > 12){
            _dateError = true;
            dateErrorLog = AppLocalizations.of(context)!.overtimeExceed;
          }
          else{
            _dateError = false;
            dateErrorLog = "";
          }
        }
        catch(e){
          print(e);
        }
      });
    }
    else if(fromDate.isAfter(toDate)){
      setState(() {
        _dateError = true;
        dateErrorLog = AppLocalizations.of(context)!.pleaseSelectStartBeforeEnd;
      });
    }
  }
  void _checkWorkingTime(List<WorkDay> workDays, String day) {
    DateTime? day0 = day == ""
        ? DateTime(now.year, now.month, now.day, 0, 0, 0)
        : DateFormat('dd MMM y hh:mm').parse(day);
    final weekday = dayOfWeek(day0.weekday);
    var workDay = workDays.firstWhere((x) => x.day == weekday);
    TimeOfDay time = TimeOfDay.fromDateTime(day0);
    bool isOutsideWorkingHours = true;

    if (workDay.status &&  workDay.morCheckInTime != null && workDay.morCheckOutTime != null) {
      TimeOfDay morCheckInTime = TimeOfDay(
        hour: int.parse(workDay.morCheckInTime!.split(":")[0]),
        minute: int.parse(workDay.morCheckInTime!.split(":")[1]),
      );
      TimeOfDay morCheckOutTime = TimeOfDay(
        hour: int.parse(workDay.morCheckOutTime!.split(":")[0]),
        minute: int.parse(workDay.morCheckOutTime!.split(":")[1]),
      );

      if (!_isOutsideWorkingTime(time, morCheckInTime, morCheckOutTime)) {
        isOutsideWorkingHours = false;
      }
    }

    if (workDay.status && workDay.aftCheckInTime != null && workDay.aftCheckOutTime != null) {
      TimeOfDay aftCheckInTime = TimeOfDay(
        hour: int.parse(workDay.aftCheckInTime!.split(":")[0]),
        minute: int.parse(workDay.aftCheckInTime!.split(":")[1]),
      );
      TimeOfDay aftCheckOutTime = TimeOfDay(
        hour: int.parse(workDay.aftCheckOutTime!.split(":")[0]),
        minute: int.parse(workDay.aftCheckOutTime!.split(":")[1]),
      );

      if (!_isOutsideWorkingTime(time, aftCheckInTime, aftCheckOutTime)) {
        isOutsideWorkingHours = false;
      }
    }

    if (!isOutsideWorkingHours) {
      setState(() {
        _dateError = true;
        dateErrorLog = "Cannot overtime in working time";
      });
    }
  }
  void checkRequestTimeExist(List<OvertimeRequest>? requests, DateTime fromTime, DateTime toTime){
    if(requests == null) return;
    var filteredData = requests.where((request) {return request.status != "Rejected";}).where((request) {
      return (request.fromDate.isBefore(fromTime) && fromTime.isBefore(request.toDate))
          || (request.fromDate.isBefore(toTime) && fromTime.isBefore(request.toDate)) ;}).toList();
    if(filteredData.isNotEmpty){
      setState(() {
        _dateError = true;
        dateErrorLog = AppLocalizations.of(context)!.haveRegisterRequest;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus(); // Ẩn bàn phím
        },
        child: Scaffold(
        appBar: CustomAppBarScreen(title: localization!.requestOvertime, isBack: true,),
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
                return Center(child: Text(localization.error(snapshot.error.toString())));
              } else if (snapshot.hasData) {
                final workDays = snapshot.data![0].response;
                return SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(20,5,20,20),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("${localization.from}:", textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.bold),),
                          DateTimePicker(
                            onDateTimeChanged: (String datetime){
                              setState(() {
                                _fromDate = datetime;
                                _calculateTotalDays();
                                _checkWorkingTime(workDays, _fromDate);
                              });
                            },
                            label: _fromDate,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${localization.to}:",
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DateTimePicker(
                            onDateTimeChanged: (String datetime){
                              setState(() {
                                _toDate = datetime;
                                _calculateTotalDays();
                                _checkWorkingTime(workDays, _toDate);
                              });
                            },
                            label: _toDate,
                          ),
                          if(_dateError)
                            Text(dateErrorLog, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          Text("${localization.total}: $_totalHours ${localization.hours}", style: const TextStyle(fontWeight: FontWeight.bold),),

                          PhoneNumberField(controller: _phoneNumberController),
                          if(_phoneError)
                             Text(localization.pleaseEnterPhoneNumber, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          ReasonField(
                              fileName: _fileName,
                              controller: _reasonController,
                              onFileSelected: (PlatformFile file){
                                setState(()  {
                                  String? fileExtension = file.extension;
                                  _fileName = file.name.length > 15? "${file.name.substring(0, 10)}...$fileExtension" : file.name;
                                  _fileBase64 =  _convertToBase64(file);
                                });
                                
                              }
                          ),

                          if(_reasonError)
                             Text(localization.pleaseEnterLeaveReason, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          isLoading ? const Center(child: CircularProgressIndicator())
                              : Center(
                            child: ElevatedButton(
                              onPressed: () async {

                                setState(() {
                                  if(_totalHours <= 0) {
                                    _dateError = true;
                                    dateErrorLog = localization.pleaseSelectStartBeforeEnd;
                                  } else{
                                    _dateError = false;
                                  }
                                  if(_phoneNumberController.text == ""){
                                    _phoneError = true;
                                  } else{
                                    _phoneError = false;
                                  }
                                  if(_reasonController.text == "") {
                                    _reasonError = true;
                                  } else {
                                    _reasonError = false;
                                  }
                                });
                                _checkWorkingTime(workDays, _fromDate);
                                _checkWorkingTime(workDays, _toDate);
                                checkRequestTimeExist(widget.requests, _fromDate == "" ? now : DateFormat('dd MMM y HH:mm').parse(_fromDate),
                                    _toDate == "" ? now : DateFormat('dd MMM y HH:mm').parse(_toDate));
                                if(_dateError || _phoneError || _reasonError ) {
                                  return;
                                }
                                OvertimeRequest request = OvertimeRequest(employeeId: widget.employeeId, reason: _reasonController.text,
                                    fromDate: _fromDate == "" ? now : DateFormat('dd MMM y HH:mm').parse(_fromDate),
                                    toDate: _toDate == "" ? now : DateFormat('dd MMM y HH:mm').parse(_toDate),
                                    duration: _totalHours, contactNumber: _phoneNumberController.text, status: "Pending", fileName: _fileBase64 ==''? null : _fileName,
                                    image: _fileBase64
                                );
                                setState(() {
                                  isLoading = true;
                                });

                                var response = await ApiService().addOTRequest(request, widget.companyId);

                                setState(() {
                                  isLoading = false;
                                });

                                if (response.isSuccess) {
                                  successToast(localization.submitSuccess);
                                  Navigator.pop(context);
                                } else {
                                  errorToast(localization.submitFailure);
                                }
                              },
                              child: Text(localization.submit),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else {
                return Center(child: Text(localization.no_data));
              }
            }
        )

    ));
  }

  bool _isOutsideWorkingTime(TimeOfDay time, TimeOfDay startTime, TimeOfDay endTime) {
    return !compareTime(time, startTime) ||  compareTime(time, endTime);
  }
  bool compareTime(TimeOfDay time1,TimeOfDay time2){
    int t1 =  time1.hour*60 + time1.minute;
    int t2 = time2.hour*60 + time2.minute;
    return t1>=t2;
  }
  int dayOfWeek(int weekday){
    if(weekday == 7) {
      return 0;
    } else {
      return weekday;
    }
  }
}

