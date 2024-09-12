// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.
// @dart=2.12
// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  static m0(remainingDays) => "You have ${remainingDays} annual day(s). Not enough to leave";

  static m1(date) => "The day ${date} is a day off";

  static m2(error) => "Error: ${error}";

  static m3(date) => "The day ${date} is not a day off";

  static m4(remainingDays) => "You have ${remainingDays} replace day(s). Not enough to leave";

  static m5(totalDays) => "Total: ${totalDays} day(s)";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'add_leave_request': MessageLookupByLibrary.simpleMessage('Add Leave Request'),
    'afternoon': MessageLookupByLibrary.simpleMessage('Afternoon'),
    'all': MessageLookupByLibrary.simpleMessage('All'),
    'alreadyCheckedOut': MessageLookupByLibrary.simpleMessage('You have already checked out'),
    'annualDayNotEnough': m0,
    'annual_leave': MessageLookupByLibrary.simpleMessage('Annual Leave'),
    'appVersion': MessageLookupByLibrary.simpleMessage('App Version'),
    'approved': MessageLookupByLibrary.simpleMessage('Approved'),
    'approvedBy': MessageLookupByLibrary.simpleMessage('Approved by'),
    'attendance': MessageLookupByLibrary.simpleMessage('Attendance'),
    'attendanceSubtitle': MessageLookupByLibrary.simpleMessage('Checkin/Checkout'),
    'attendanceSuccessful': MessageLookupByLibrary.simpleMessage('Attendance successful!'),
    'attendanceTitle': MessageLookupByLibrary.simpleMessage('Attendance'),
    'attendance_history': MessageLookupByLibrary.simpleMessage('Attendance History'),
    'calendarSubtitle': MessageLookupByLibrary.simpleMessage('Workday & Holiday'),
    'calendarTitle': MessageLookupByLibrary.simpleMessage('My Calendar'),
    'cancel': MessageLookupByLibrary.simpleMessage('CANCEL'),
    'canceledSuccessfully': MessageLookupByLibrary.simpleMessage('Canceled successfully'),
    'cannot_check_in': MessageLookupByLibrary.simpleMessage('Cannot check in'),
    'check': MessageLookupByLibrary.simpleMessage('Check'),
    'check_in': MessageLookupByLibrary.simpleMessage('Check-in'),
    'check_out': MessageLookupByLibrary.simpleMessage('Check-out'),
    'checkinTimeOutsideOvertime': MessageLookupByLibrary.simpleMessage('Check-in time is outside the overtime'),
    'code': MessageLookupByLibrary.simpleMessage('Code'),
    'comment': MessageLookupByLibrary.simpleMessage('Comment'),
    'confirm_logout': MessageLookupByLibrary.simpleMessage('Confirm Logout'),
    'created_date': MessageLookupByLibrary.simpleMessage('Created Date'),
    'date': MessageLookupByLibrary.simpleMessage('Date'),
    'dateErrorBeforeEnd': MessageLookupByLibrary.simpleMessage('Please select the start date before the end date'),
    'dateErrorEnd': MessageLookupByLibrary.simpleMessage('Please select the end date after now'),
    'dateErrorMonth': MessageLookupByLibrary.simpleMessage('Please select a date range within the same month.'),
    'dateErrorStart': MessageLookupByLibrary.simpleMessage('Please select the start date after now'),
    'day': MessageLookupByLibrary.simpleMessage('day'),
    'dayOff': MessageLookupByLibrary.simpleMessage('Day off'),
    'dayOffError': m1,
    'dayOffErrorEnd': MessageLookupByLibrary.simpleMessage('This end date is not a day off'),
    'dayOffErrorStart': MessageLookupByLibrary.simpleMessage('This start date is not a day off'),
    'days': MessageLookupByLibrary.simpleMessage('day(s)'),
    'department': MessageLookupByLibrary.simpleMessage('Department'),
    'description': MessageLookupByLibrary.simpleMessage('Description'),
    'doneButton': MessageLookupByLibrary.simpleMessage('DONE'),
    'duration': MessageLookupByLibrary.simpleMessage('Duration'),
    'early': MessageLookupByLibrary.simpleMessage('Early'),
    'error': m2,
    'errorLeaveRequest': MessageLookupByLibrary.simpleMessage('Failed to add leave request'),
    'errorTitle': MessageLookupByLibrary.simpleMessage('Error'),
    'failedToAddLeaveRequest': MessageLookupByLibrary.simpleMessage('Failed to add leave request:'),
    'failedToCancel': MessageLookupByLibrary.simpleMessage('Failed to cancel'),
    'failedToLogIn': MessageLookupByLibrary.simpleMessage('Failed to log in'),
    'feedback': MessageLookupByLibrary.simpleMessage('Feedback'),
    'from': MessageLookupByLibrary.simpleMessage('From'),
    'give_feedback': MessageLookupByLibrary.simpleMessage('Give Feedback'),
    'haveRegisterRequest': MessageLookupByLibrary.simpleMessage('You have registered a request at this time, please check again.'),
    'holiday': MessageLookupByLibrary.simpleMessage('Holiday'),
    'home': MessageLookupByLibrary.simpleMessage('HOME'),
    'hours': MessageLookupByLibrary.simpleMessage('hour(s)'),
    'iAmSick': MessageLookupByLibrary.simpleMessage('I am sick'),
    'joinAt': MessageLookupByLibrary.simpleMessage('Join At'),
    'late': MessageLookupByLibrary.simpleMessage('Late'),
    'leave': MessageLookupByLibrary.simpleMessage('Leave'),
    'leaveRequestDetail': MessageLookupByLibrary.simpleMessage('Leave Request Detail'),
    'leaveSubtitle': MessageLookupByLibrary.simpleMessage('History and request leave'),
    'leaveTitle': MessageLookupByLibrary.simpleMessage('Leave'),
    'leaveType': MessageLookupByLibrary.simpleMessage('Type of Leave'),
    'loading': MessageLookupByLibrary.simpleMessage('Loading...'),
    'locationError': MessageLookupByLibrary.simpleMessage('You are not in the correct location to check-in.'),
    'logInSuccessfully': MessageLookupByLibrary.simpleMessage('Log in successfully'),
    'logout': MessageLookupByLibrary.simpleMessage('Logout'),
    'logout_confirmation': MessageLookupByLibrary.simpleMessage('Are you sure you want to logout?\nIf you log out, you will need a QR code provided by your manager to log in again.'),
    'markAllAsRead': MessageLookupByLibrary.simpleMessage('Mark all as read'),
    'me': MessageLookupByLibrary.simpleMessage('ME'),
    'member': MessageLookupByLibrary.simpleMessage('Member'),
    'membersSubtitle': MessageLookupByLibrary.simpleMessage('List all members'),
    'membersTitle': MessageLookupByLibrary.simpleMessage('Members'),
    'month': MessageLookupByLibrary.simpleMessage('month'),
    'months': MessageLookupByLibrary.simpleMessage('months'),
    'morning': MessageLookupByLibrary.simpleMessage('Morning'),
    'no': MessageLookupByLibrary.simpleMessage('No'),
    'noDataAvailable': MessageLookupByLibrary.simpleMessage('No data available'),
    'noFileSelected': MessageLookupByLibrary.simpleMessage('No file selected'),
    'no_data': MessageLookupByLibrary.simpleMessage('No data available'),
    'notDayOffError': m3,
    'noteHint': MessageLookupByLibrary.simpleMessage('Please write your note here...'),
    'noteTitle': MessageLookupByLibrary.simpleMessage('Note'),
    'notification': MessageLookupByLibrary.simpleMessage('Notification'),
    'ot_checkin_note': MessageLookupByLibrary.simpleMessage('Please check in no later than 30 minutes before and no later than 1 hour after the registration time!'),
    'overtimeExceed': MessageLookupByLibrary.simpleMessage('Overtime cannot exceed 12 hours'),
    'overtimeRequestDetail': MessageLookupByLibrary.simpleMessage('Overtime Request Detail'),
    'overtimeSubtitle': MessageLookupByLibrary.simpleMessage('History and request overtime'),
    'overtimeTitle': MessageLookupByLibrary.simpleMessage('Overtime'),
    'pending': MessageLookupByLibrary.simpleMessage('Pending'),
    'phoneNumber': MessageLookupByLibrary.simpleMessage('Phone number'),
    'phoneNumberError': MessageLookupByLibrary.simpleMessage('Please enter your phone number'),
    'pleaseEnterLeaveReason': MessageLookupByLibrary.simpleMessage('Please enter your reason'),
    'pleaseEnterPhoneNumber': MessageLookupByLibrary.simpleMessage('Please enter your phone number'),
    'pleaseSelectStartBeforeEnd': MessageLookupByLibrary.simpleMessage('Please select the start date before the end date'),
    'pleaseTryAgainOrContactYourManager': MessageLookupByLibrary.simpleMessage('Please try again or contact your manager.'),
    'position': MessageLookupByLibrary.simpleMessage('Position'),
    'profile': MessageLookupByLibrary.simpleMessage('Profile'),
    'qrCodeScanner': MessageLookupByLibrary.simpleMessage('QR Code Scanner'),
    'rate_experience': MessageLookupByLibrary.simpleMessage('How would you rate your experience?'),
    'reason': MessageLookupByLibrary.simpleMessage('Reason'),
    'reasonPlaceholder': MessageLookupByLibrary.simpleMessage('Please write your reason here...'),
    'recommendation': MessageLookupByLibrary.simpleMessage('Recommendation'),
    'rejected': MessageLookupByLibrary.simpleMessage('Rejected'),
    'replace': MessageLookupByLibrary.simpleMessage('Replace'),
    'replaceDayNotEnough': m4,
    'replaceRequestDetail': MessageLookupByLibrary.simpleMessage('Replace Request Detail'),
    'replaceRequestTitle': MessageLookupByLibrary.simpleMessage('Request Replace'),
    'replaceSubtitle': MessageLookupByLibrary.simpleMessage('History and request replace'),
    'replaceTitle': MessageLookupByLibrary.simpleMessage('Replacement'),
    'replace_leave': MessageLookupByLibrary.simpleMessage('Replace Leave'),
    'requestLeave': MessageLookupByLibrary.simpleMessage('Request Leave'),
    'requestOvertime': MessageLookupByLibrary.simpleMessage('Request Overtime'),
    'scanACode': MessageLookupByLibrary.simpleMessage('Scan a code'),
    'scanQRCodeToLogin': MessageLookupByLibrary.simpleMessage('Scan QR code to login'),
    'seniority': MessageLookupByLibrary.simpleMessage('Seniority'),
    'settings': MessageLookupByLibrary.simpleMessage('Settings'),
    'skipButton': MessageLookupByLibrary.simpleMessage('SKIP'),
    'sorryLate': MessageLookupByLibrary.simpleMessage('Sorry I am late'),
    'status': MessageLookupByLibrary.simpleMessage('Status'),
    'submit': MessageLookupByLibrary.simpleMessage('Submit'),
    'submitFailure': MessageLookupByLibrary.simpleMessage('Submit failure'),
    'submitNotePrompt': MessageLookupByLibrary.simpleMessage('Please submit your note before you scan'),
    'submitSuccess': MessageLookupByLibrary.simpleMessage('Submit successfully'),
    'successLeaveRequest': MessageLookupByLibrary.simpleMessage('Leave request added successfully'),
    'title': MessageLookupByLibrary.simpleMessage('Workplace'),
    'to': MessageLookupByLibrary.simpleMessage('To'),
    'total': MessageLookupByLibrary.simpleMessage('Total'),
    'totalDays': m5,
    'typeOfLeave': MessageLookupByLibrary.simpleMessage('Type of Leave'),
    'unchecked': MessageLookupByLibrary.simpleMessage('Unchecked'),
    'unpaid': MessageLookupByLibrary.simpleMessage('Unpaid'),
    'upload_failed': MessageLookupByLibrary.simpleMessage('Upload failed'),
    'upload_success': MessageLookupByLibrary.simpleMessage('Upload successfully'),
    'workdayTime': MessageLookupByLibrary.simpleMessage('Workday / Time'),
    'workingTime': MessageLookupByLibrary.simpleMessage('Working Time'),
    'write_feedback': MessageLookupByLibrary.simpleMessage('Please write your feedback here...'),
    'write_recommendation': MessageLookupByLibrary.simpleMessage('Please write your recommendation here...'),
    'year': MessageLookupByLibrary.simpleMessage('year'),
    'years': MessageLookupByLibrary.simpleMessage('years'),
    'yes': MessageLookupByLibrary.simpleMessage('Yes')
  };
}
