import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../assets/widget_component/addLeaveRequestView/datePicker.dart';
import '../assets/widget_component/addLeaveRequestView/leaveTypeSelector.dart';
import '../assets/widget_component/addLeaveRequestView/phoneNumberField.dart';
import '../assets/widget_component/addLeaveRequestView/reasonField.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/replace/replaceRequest.dart';
import '../models/workingday/publicHoliday.dart';
import '../models/workingday/workday.dart';
import '../services/apiService.dart';
import '../services/function.dart';


class AddReplaceRequestScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final List<ReplaceRequest>? requests;
  const AddReplaceRequestScreen({super.key, required this.companyId, required this.employeeId, this.requests});

  @override
  _AddReplaceRequestState createState() => _AddReplaceRequestState();
}

String _convertToBase64(PlatformFile file)  {
  File imageFile = File(file.path!);
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}

class _AddReplaceRequestState extends State<AddReplaceRequestScreen> {
  late Future<List<dynamic>> futureData;
  bool isLoading = false;

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  double _totalDay = 1;
  String _fromDate = "",
      _toDate = "";
  String _fromTime = "Morning",
      _toTime = "Afternoon";
  String _fileName =  'No file selected',
      _fileBase64 = "";
  bool _dateError = false,
      _reasonError = false,
      _phoneError = false;
  String dateErrorLog = "";
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('EEE dd MMMM y').format(now);
    _fromDate = formattedDate;
    _toDate = formattedDate;
    futureData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchWorkingDay(widget.employeeId, widget.companyId),
      ApiService().fetchHoliday(widget.employeeId, widget.companyId),
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
    DateTime? fromDate = _fromDateController.text == ""
        ? DateTime(now.year, now.month, now.day, 0, 0, 0)
        : DateFormat('EEE dd MMMM y').parse(_fromDateController.text);
    fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day, 0, 0, 0);

    DateTime? toDate = _toDateController.text == ""
        ? DateTime(now.year, now.month, now.day, 23, 59, 59)
        : DateFormat('EEE dd MMMM y').parse(_toDateController.text);
    toDate = DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59);

    if (toDate.month != fromDate.month || toDate.year != fromDate.year) {
      setState(() {
        _dateError = true;
        dateErrorLog =  AppLocalizations.of(context)!.dateErrorMonth;
      });
      return;
    }
    else {
      setState(() {
        _dateError = false;
        dateErrorLog = "";
      });
    }
    if ((fromDate.isBefore(toDate) || fromDate.isAtSameMomentAs(toDate))) {
      setState(() {
        try {
          _totalDay = (fromDate!.isAtSameMomentAs(toDate!) ? 1 : (toDate.difference(fromDate).inDays.toDouble() + 1));
          if(fromDate.isAtSameMomentAs(toDate) && _fromTime == "Afternoon" && _toTime == "Morning"){
            _dateError = true;
            return;
          }
          _dateError = false;
          if (_fromTime == "Afternoon") {
            _totalDay -= 0.5;
          }
          if (_toTime == "Morning") {
            _totalDay -= 0.5;
          }
          if (_totalDay < 0) {
            _totalDay = 0;
          }
        }
        catch (e) {
          print(e);
        }
      });
    }
    else if (fromDate.isAfter(toDate)) {
      setState(() {
        _dateError = true;
        dateErrorLog = AppLocalizations.of(context)!.dateErrorBeforeEnd;
      });
    }
  }
  void _checkDayOff(List<WorkDay> workDays, List<PublicHoliday> holidays, DateTime fromDate, DateTime toDate) {
    toDate = DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59);
    if (!fromDate.isBefore(toDate)) return;
    for (DateTime dateTime = fromDate; dateTime.isBefore(toDate);
    dateTime = dateTime.add(const Duration(days: 1))) {
      final weekday = Functions().dayOfWeek(dateTime.weekday);
      final isHoliday = holidays.any((holiday) =>
          isSameDay(holiday.date, dateTime));
      final isNotWorkday = workDays.any((workday) =>
      workday.day == weekday && !workday.status);
      if (!isHoliday && !isNotWorkday) {
        setState(() {
          _dateError = true;
          dateErrorLog = AppLocalizations.of(context)!.notDayOffError(
              DateFormat('dd MMMM y').format(dateTime));
        });
        return;
      }
    }
  }
  // void _checkDayOff(List<WorkDay> workDays, List<PublicHoliday> holidays, String day, bool isStart){
  //   DateTime? day0 = day == ""
  //       ? DateTime(now.year, now.month, now.day, 0, 0, 0)
  //       : DateFormat('EEE dd MMMM y').parse(day);
  //   final isHoliday = holidays.any((holiday) => isSameDay(holiday.date, day0));
  //   final weekday = Functions().dayOfWeek(day0.weekday);
  //   final isNotWorkday = workDays.any((workday) => workday.day == weekday && !workday.status);
  //   if(!isHoliday && !isNotWorkday){
  //     setState(() {
  //       _dateError = true;
  //       dateErrorLog = isStart? AppLocalizations.of(context)!.dayOffErrorStart : AppLocalizations.of(context)!.dayOffErrorEnd;
  //     });
  //   }
  // }
  void checkRequestTimeExist(List<ReplaceRequest>? requests, DateTime fromTime, DateTime toTime){
    toTime = DateTime(toTime.year,toTime.month,toTime.day,23,59,59);
    if(_fromTime != "Morning") fromTime = fromTime.add(const Duration(hours: 12));
    if(_toTime != "Afternoon") toTime = toTime.add(const Duration(hours: -12));
    if(requests == null) return;
    var filteredData = requests.where((request) {return request.status != "Rejected";}).where((request) {
      return (request.fromDate.add(request.isFromMorning ? const Duration(hours: 0) : const Duration(hours: 12)).isBefore(fromTime)
          && fromTime.isBefore(request.toDate.add(request.isToAfternoon ? const Duration(hours: 0) : const Duration(hours: -12))))
          || (request.fromDate.add(request.isFromMorning ? const Duration(hours: 0) : const Duration(hours: 12)).isBefore(toTime)
              && fromTime.isBefore(request.toDate.add(request.isToAfternoon ? const Duration(hours: 0) : const Duration(hours: -12)))) ;
    }).toList();
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
        appBar: CustomAppBarScreen(title: localization!.replaceRequestTitle, isBack: true,),
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
                final holidays = snapshot.data![1].response;
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
                          LeaveTypeSelector(
                              selectedLeaveType: _fromTime,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _fromTime = newValue!;
                                  _calculateTotalDays();
                                });
                              },
                              title: localization.from),
                          DatePicker(
                            label: _fromDate,
                            controller: _fromDateController,
                            onDateSelected: (String value) {
                              setState(() {
                                _fromDate = value;
                                _calculateTotalDays();
                                // _checkDayOff(workDays, holidays, _fromDate, true);
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          LeaveTypeSelector(
                              selectedLeaveType: _toTime,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _toTime = newValue!;
                                  _calculateTotalDays();
                                });
                              },
                              title: localization.to),
                          DatePicker(
                            label: _toDate,
                            controller: _toDateController,
                            onDateSelected: (String value) {
                              _toDate = value;
                              _calculateTotalDays();
                              // _checkDayOff(workDays, holidays, _toDate, false);
                            },
                          ),
                          if(_dateError)
                            Text(dateErrorLog, style: const TextStyle(
                                color: Colors.red),),
                          const SizedBox(height: 16),
                          Text(
                            "${localization.total}: $_totalDay ${localization.days}", style: const TextStyle(
                              fontWeight: FontWeight.bold),),

                          PhoneNumberField(controller: _phoneNumberController),
                          if(_phoneError)
                            Text(localization.pleaseEnterPhoneNumber, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          ReasonField(
                              fileName: _fileName,
                              controller: _reasonController,
                              onFileSelected: (PlatformFile file) {
                                setState(() {
                                  String? fileExtension = file.extension;
                                  _fileName =
                                  file.name.length > 15
                                      ? "${file.name.substring(
                                      0, 10)}...$fileExtension"
                                      : file.name;
                                  _fileBase64 = _convertToBase64(file);
                                });
                              }
                          ),

                          if(_reasonError)
                            Text(localization.pleaseEnterLeaveReason,
                              style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          isLoading ? const Center(
                              child: CircularProgressIndicator())
                              : Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  if(_totalDay <= 0){
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
                                // _checkDayOff(workDays, holidays, _fromDate, true);
                                // _checkDayOff(workDays, holidays, _toDate, true);
                                _checkDayOff(workDays, holidays, _fromDateController.text == "" ? DateTime(now.year, now.month, now.day, 0, 0, 0) : DateFormat('EEE dd MMMM y').parse(_fromDateController.text),
                                    _toDateController.text == "" ? DateTime(now.year, now.month, now.day, 23, 59, 59) : DateFormat('EEE dd MMMM y').parse(_toDateController.text));

                                checkRequestTimeExist(widget.requests, _fromDateController.text == "" ? DateTime(now.year, now.month, now.day, 0, 0, 0) : DateFormat('EEE dd MMMM y').parse(_fromDateController.text),
                                    _toDateController.text == "" ? DateTime(now.year, now.month, now.day, 23, 59, 59) : DateFormat('EEE dd MMMM y').parse(_toDateController.text));

                                if (_dateError || _phoneError ||
                                    _reasonError) {
                                  return;
                                }
                                ReplaceRequest request = ReplaceRequest(
                                    employeeId: widget.employeeId,
                                    reason: _reasonController.text,
                                    fromDate: _fromDateController.text == ""
                                        ? DateTime(now.year, now.month, now.day, 0, 0, 0)
                                        : DateFormat('EEE dd MMMM y').parse(
                                        _fromDateController.text),
                                    isFromMorning: _fromTime == "Morning",
                                    isToAfternoon: _toTime == "Afternoon",
                                    toDate: _toDateController.text == ""
                                        ? DateTime(now.year, now.month, now.day, 23, 59, 59)
                                        : DateFormat('EEE dd MMMM y').parse(
                                        _toDateController.text),
                                    duration: _totalDay,
                                    contactNumber: _phoneNumberController.text,
                                    status: "Pending",
                                    fileName: _fileBase64 == ''
                                        ? null
                                        : _fileName,
                                    image: _fileBase64
                                );

                                setState(() {
                                  isLoading = true;
                                });

                                var response = await ApiService()
                                    .addReplaceRequest(
                                    request, widget.companyId);

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
                              child: Text(localization.submit, style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              else {
                return const Center(child: Text('No data available'));
              }
            }
        )
    ));
  }

}