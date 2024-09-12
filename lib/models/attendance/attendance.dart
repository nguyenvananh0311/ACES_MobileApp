import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendance{
  final String id;
  final int employeeId;
  final String employeeName;
  final String date;
  final bool workStatus;
  final double workHours;
  final double workHoursStandard;
  final String status;
  final String? morCheckIn;
  final String? morCheckOut;
  final String? aftCheckIn;
  final String? aftCheckOut;
  final String? checkInStatus;
  final String? checkOutStatus;
  final int morCheckInDiff;
  final int morCheckOutDiff;
  final int aftCheckInDiff;
  final int aftCheckOutDiff;
  final TimeOfDay? morCheckInStandard;
  final TimeOfDay? morCheckOutStandard;
  final TimeOfDay? aftCheckInStandard;
  final TimeOfDay? aftCheckOutStandard;


  Attendance({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    required this.workStatus,
    required this.workHours,
    required this.status,
    required this.morCheckInDiff,
    required this.morCheckOutDiff,
    required this.aftCheckInDiff,
    required this.aftCheckOutDiff,
    required this.workHoursStandard,
    this.aftCheckIn,
    this.aftCheckOut,
    this.morCheckIn,
    this.morCheckOut,
    this.checkInStatus,
    this.checkOutStatus,
    this.morCheckInStandard,
    this.morCheckOutStandard,
    this.aftCheckInStandard,
    this.aftCheckOutStandard,
  });
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      date: json['date'],
      aftCheckInDiff: json['aftCheckInDiff'],
      aftCheckOutDiff: json['aftCheckOutDiff'],
      morCheckInDiff: json['morCheckInDiff'],
      morCheckOutDiff: json['morCheckOutDiff'],
      status: json['status'],
      workHours: double.parse(json['workHours'].toString()),
      workStatus: json['workStatus'],
      aftCheckIn: json['aftCheckIn'],
      aftCheckOut: json['aftCheckOut'],
      checkInStatus: json['checkInStatus'],
      checkOutStatus: json['checkOutStatus'],
      morCheckIn: json['morCheckIn'],
      morCheckOut: json['morCheckOut'],
      aftCheckInStandard: json['aftCheckInStandard'] == null ? null : parseTime(json['aftCheckInStandard']),
      aftCheckOutStandard: json['aftCheckOutStandard'] == null ? null : parseTime(json['aftCheckOutStandard']),
      morCheckInStandard: json['morCheckInStandard'] == null ? null : parseTime(json['morCheckInStandard']),
      morCheckOutStandard: json['morCheckOutStandard'] == null ? null : parseTime(json['morCheckOutStandard']),
      workHoursStandard:json['workHoursStandard'] == null ? 0 : double.parse(json['workHoursStandard'].toString())
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId' : employeeId,
      'employeeName': employeeName,
      'date': date,
      'aftCheckInDiff': aftCheckInDiff,
      'aftCheckOutDiff': aftCheckOutDiff,
      'morCheckInDiff': morCheckInDiff,
      'morCheckOutDiff': morCheckOutDiff,
      'status': status,
      'workHours': workHours,
      'workStatus': workStatus,
      'aftCheckIn': aftCheckIn,
      'aftCheckOut':aftCheckOut,
      'checkInStatus': checkInStatus,
      'checkOutStatus': checkOutStatus,
      'morCheckIn': morCheckIn,
      'morCheckOut': morCheckOut,
      'workHoursStandard': workHoursStandard,
      'aftCheckInStandard': aftCheckInStandard,
      'aftCheckOutStandard':aftCheckOutStandard,
      'morCheckInStandard': morCheckInStandard,
      'morCheckOutStandard': morCheckOutStandard,
    };
  }
}
TimeOfDay parseTime(String timeString) {
  final format = DateFormat.Hms();
  final dateTime = format.parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}