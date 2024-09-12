import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../assets/widget_component/addLeaveRequestView/datePicker.dart';
import '../assets/widget_component/addLeaveRequestView/dropdown.dart';
import '../assets/widget_component/addLeaveRequestView/leaveTypeSelector.dart';
import '../assets/widget_component/addLeaveRequestView/phoneNumberField.dart';
import '../assets/widget_component/addLeaveRequestView/reasonField.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/leave/leaveRequest.dart';
import '../models/leave/monthlyLeave.dart';
import '../models/workingday/publicHoliday.dart';
import '../models/workingday/workday.dart';
import '../services/apiService.dart';
import '../services/function.dart';


class AddLeaveRequestScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final List<LeaveRequest>? requests;
  const AddLeaveRequestScreen({super.key, required this.companyId, required this.employeeId, this.requests});

  @override
  _AddLeaveRequestState createState() => _AddLeaveRequestState();
}


String _convertToBase64(PlatformFile file)  {
  File imageFile = File(file.path!);
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}

class _AddLeaveRequestState extends State<AddLeaveRequestScreen> {
  bool isLoading = false;
  late Future<List<dynamic>> futureData;

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  double _totalDay = 1;
  String _fromTime = "Morning", _toTime = "Afternoon";
  String _fromDate = "", _toDate = "";
  String _leaveType = 'Annual';
  String _fileName = 'No file selected', _fileBase64 = "";
  bool _dateError = false, _reasonError = false, _phoneError = false, _typeError = false;
  String typeErrorLog = "";
  String dateErrorLog = "";
  final List<String> _leaveTypes = ['Annual', 'Unpaid','Replace'];
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
      ApiService().fetchMonthlyLeave(widget.employeeId, widget.companyId),
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
  void _checkType(MonthlyLeave monthlyLeave){
    if(_leaveType == "Annual" ){
      if(monthlyLeave.earnedAnnualDay - monthlyLeave.usedAnnualDay < _totalDay){
        _typeError = true;
        typeErrorLog = AppLocalizations.of(context)!.annualDayNotEnough(monthlyLeave.earnedAnnualDay - monthlyLeave.usedAnnualDay);
      }
      else {
        _typeError = false;
      }
      return;
    }
    else if(_leaveType == "Replace" ){
      if( monthlyLeave.earnedReplaceDay - monthlyLeave.usedReplaceDay < _totalDay){
        _typeError = true;
        typeErrorLog = AppLocalizations.of(context)!.replaceDayNotEnough(monthlyLeave.earnedReplaceDay - monthlyLeave.usedReplaceDay);
      }
      else {
        _typeError = false;
      }
      return;
    }
    else{
      _typeError = false;
    }
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

    if ((fromDate.isBefore(toDate) || fromDate.isAtSameMomentAs(toDate))) {
      setState(() {
        try{
          _totalDay = (fromDate!.isAtSameMomentAs(toDate!) ? 1 : (toDate.difference(fromDate).inDays.toDouble()+1));
          if(fromDate.isAtSameMomentAs(toDate) && _fromTime == "Afternoon" && _toTime == "Morning"){
            _dateError = true;
            dateErrorLog = AppLocalizations.of(context)!.pleaseSelectStartBeforeEnd;
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
  void checkRequestTimeExist(List<LeaveRequest>? requests, DateTime fromTime, DateTime toTime){
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
  void _checkDayOff(List<WorkDay> workDays, List<PublicHoliday> holidays, DateTime fromDate, DateTime toDate){
    toDate = DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59);
    if(!fromDate.isBefore(toDate)) return;
    for(DateTime dateTime = fromDate; dateTime.isBefore(toDate); dateTime = dateTime.add(const Duration(days: 1))){
      final weekday = Functions().dayOfWeek(dateTime.weekday);
      final isHoliday = holidays.any((holiday) => isSameDay(holiday.date, dateTime));
      final isNotWorkday = workDays.any((workday) => workday.day == weekday && !workday.status);
      if(isHoliday || isNotWorkday){
        setState(() {
          _dateError = true;
          dateErrorLog = AppLocalizations.of(context)!.dayOffError(DateFormat('dd MMMM y').format(dateTime));
        });
        return;
      }
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
          appBar: CustomAppBarScreen(title: localization!.requestLeave, isBack: true,),
          body: FutureBuilder<List<dynamic>>(
            future: futureData,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(localization.error(snapshot.error.toString())));
              } else if (snapshot.hasData) {
                final monthlyLeave = snapshot.data![0].response;
                final workDays = snapshot.data![1].response;
                final holidays = snapshot.data![2].response;
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
                                  _checkType(monthlyLeave!);
                                });
                              },
                              title: "${localization.from}:"),
                          DatePicker(
                            label: _fromDate,
                            controller: _fromDateController,
                            onDateSelected: (String value) {
                              setState(() {
                                _fromDate = value;
                                _calculateTotalDays();
                                _checkType(monthlyLeave!);
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
                                  _checkType(monthlyLeave!);
                                });
                              },
                              title: "${localization.to}:"),
                          DatePicker(
                            label: _toDate,
                            controller: _toDateController,
                            onDateSelected: (String value) {
                              _toDate = value;
                              _calculateTotalDays();
                              _checkType(monthlyLeave!);
                            },
                          ),
                          if(_dateError)
                            Text(dateErrorLog , style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 16),
                          Text("${localization.total}: $_totalDay ${localization.days}", style: const TextStyle(fontWeight: FontWeight.bold),),
                          DropdownSelector(
                            label:  Row(
                              children: [
                                Text(localization.typeOfLeave, style: const TextStyle(fontWeight: FontWeight.bold),),
                                const Text("*", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                              ],
                            ),
                            items: _leaveTypes,
                            selectedValue: _leaveType,
                            onChanged: (String? newValue) {
                              setState(() {
                                _leaveType = newValue!;
                                _checkType(monthlyLeave!);
                              });
                            },
                          ),
                          if(_typeError)
                            Text(typeErrorLog, style: const TextStyle(color: Colors.red),),
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
                                  _checkType(monthlyLeave!);
                                });
                                checkRequestTimeExist(widget.requests, _fromDateController.text == "" ? DateTime(now.year, now.month, now.day, 0, 0, 0) : DateFormat('EEE dd MMMM y').parse(_fromDateController.text),
                                    _toDateController.text == "" ? DateTime(now.year, now.month, now.day, 23, 59, 59) : DateFormat('EEE dd MMMM y').parse(_toDateController.text));

                                _checkDayOff(workDays, holidays,_fromDateController.text == "" ? DateTime(now.year, now.month, now.day, 0, 0, 0) : DateFormat('EEE dd MMMM y').parse(_fromDateController.text),
                                    _toDateController.text == "" ? DateTime(now.year, now.month, now.day, 23, 59, 59) : DateFormat('EEE dd MMMM y').parse(_toDateController.text));

                                if(_dateError || _phoneError || _reasonError || _typeError) {
                                  return;
                                }
                                LeaveRequest request = LeaveRequest(employeeId: widget.employeeId, type: _leaveType, reason: _reasonController.text,
                                    fromDate: _fromDateController.text == "" ? DateTime(now.year, now.month, now.day, 0, 0, 0) : DateFormat('EEE dd MMMM y').parse(_fromDateController.text),
                                    isFromMorning: _fromTime == "Morning", isToAfternoon: _toTime == "Afternoon",
                                    toDate: _toDateController.text == "" ? DateTime(now.year, now.month, now.day, 23, 59, 59) : DateFormat('EEE dd MMMM y').parse(_toDateController.text),
                                    duration: _totalDay, contactNumber: _phoneNumberController.text, status: "Pending", fileName: _fileBase64 =='No file selected'? null : _fileName,
                                    image: _fileBase64
                                );
                                setState(() {
                                  isLoading = true;
                                });
                                var response = await ApiService().addLeaveRequest(request, widget.companyId);
                                setState(() {
                                  isLoading = false;
                                });
                                if (response.isSuccess) {
                                  successToast(localization.successLeaveRequest);
                                  Navigator.pop(context);
                                } else {
                                  errorToast(localization.errorLeaveRequest);
                                }
                              },
                              child: Text(localization.submit),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                ;
              } else {
                return Center(child: Text(localization.no_data));
              }
            },
          )
      ),
    );
  }
}

