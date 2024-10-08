import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class AppLocalizations {

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? false ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {return Localizations.of<AppLocalizations>(context, AppLocalizations);}
  String get title {return Intl.message('Workplace', name: 'title');}
  String get attendanceTitle {return Intl.message('Attendance', name: 'attendanceTitle');}
  String get attendanceSubtitle {return Intl.message('Check in/Check out', name: 'attendanceSubtitle');}
  String get leaveTitle {return Intl.message('Leave', name: 'leaveTitle');}
  String get leaveSubtitle {return Intl.message('History and request leave', name: 'leaveSubtitle');}
  String get replaceTitle {return Intl.message('Replacement', name: 'replaceTitle');}
  String get replaceSubtitle {return Intl.message('History and request replacement', name: 'replaceSubtitle');}
  String get overtimeTitle {return Intl.message('Overtime', name: 'overtimeTitle');}
  String get overtimeSubtitle {return Intl.message('History and request overtime', name: 'overtimeSubtitle');}
  String get calendarTitle {return Intl.message('My Calendar', name: 'calendarTitle');}
  String get calendarSubtitle {return Intl.message('Workday & Holiday', name: 'calendarSubtitle');}
  String get membersTitle {return Intl.message('Members', name: 'membersTitle');}
  String get membersSubtitle {return Intl.message('List all members', name: 'membersSubtitle');}
  String get attendance{return Intl.message('Attendance', name: 'attendance');}
  String get morning => Intl.message('Morning', name: 'morning');
  String get afternoon => Intl.message('Afternoon', name: 'afternoon');
  String get check_in => Intl.message('Check-in', name: 'check_in');
  String get check_out => Intl.message('Check-out', name: 'check_out');
  String get cannot_check_in => Intl.message('Cannot check in', name: 'cannot_check_in');
  String get early => Intl.message('Early', name: 'early',);
  String get late => Intl.message('Late', name: 'late',);
  String get check => Intl.message('Check', name: 'check',);
  String get unchecked => Intl.message('Unchecked', name: 'unchecked',);
  String get attendance_history => Intl.message('Attendance History', name: 'attendance_history',);

  String get leave => Intl.message('Leave', name: 'leave',);
  String get annual_leave => Intl.message('Annual Leave', name: 'annual_leave',);
  String get replace_leave => Intl.message('Replace Leave', name: 'replace_leave',);
  String get unpaid => Intl.message('Unpaid', name: 'unpaid',);
  String get no_data => Intl.message('No data available', name: 'no_data',);
  String get pending => Intl.message('Pending', name: 'pending',);
  String get approved => Intl.message('Approved', name: 'approved',);
  String get rejected => Intl.message('Rejected', name: 'rejected',);
  String get loading => Intl.message('Loading...', name: 'loading',);
  String error(String error) => Intl.message('Error: $error', name: 'error', args: [error],);
  String get add_leave_request => Intl.message('Add Leave Request', name: 'add_leave_request',);
  String get created_date => Intl.message('Created Date', name: 'created_date',);
  String get status => Intl.message('Status', name: 'status',);
  String get description => Intl.message('Description', name: 'description',);
  String get duration => Intl.message('Duration', name: 'duration',);

  String get all => Intl.message('All', name: 'all',);
  String get date => Intl.message('Date', name: 'date',);
  String get reason => Intl.message('Reason', name: 'reason',);

  String get leaveRequestDetail { return Intl.message('Leave Request Detail', name: 'leaveRequestDetail',);}
  String get from {return Intl.message('From', name: 'from',);}
  String get to {return Intl.message('To', name: 'to',);}
  String get total {return Intl.message('Total', name: 'total',);}
  String get days {return Intl.message('day(s)', name: 'days',);}
  String get leaveType {return Intl.message('Type of Leave', name: 'leaveType',);}
  String get phoneNumber {return Intl.message('Phone number', name: 'phoneNumber',);}
  String get approvedBy {return Intl.message('Approved by', name: 'approvedBy',);}
  String get comment {return Intl.message('Comment', name: 'comment',);}
  String get cancel {return Intl.message('CANCEL', name: 'cancel',);}
  String get noDataAvailable {return Intl.message('No data available', name: 'noDataAvailable',);}

  String get requestLeave => Intl.message('Request Leave', name: 'requestLeave');
  String get typeOfLeave => Intl.message('Type of Leave', name: 'typeOfLeave');
  String get noFileSelected => Intl.message('No file selected', name: 'noFileSelected');
  String get pleaseSelectStartBeforeEnd => Intl.message('Please select the start date before the end date', name: 'pleaseSelectStartBeforeEnd');
  String get successLeaveRequest => Intl.message('Leave request added successfully', name: 'successLeaveRequest');
  String get errorLeaveRequest => Intl.message('Failed to add leave request', name: 'errorLeaveRequest');
  String get canceledSuccessfully => Intl.message('Leave request canceled successfully', name: 'canceledSuccessfully');
  String get failedToCancel => Intl.message('Failed to cancel leave request', name: 'failedToCancel');
  String get pleaseEnterPhoneNumber => Intl.message('Please enter your phone number', name: 'pleaseEnterPhoneNumber');
  String get pleaseEnterLeaveReason => Intl.message('Please enter your reason', name: 'pleaseEnterLeaveReason');
  String get submit => Intl.message('Submit', name: 'submit');
  String annualDayNotEnough(remainingDays) => Intl.message(
      'You have {remainingDays} annual day(s). Not enough to leave',
      name: 'annualDayNotEnough',
      args: [remainingDays],
      examples: const {'remainingDays': '3'}
  );
  String replaceDayNotEnough(remainingDays) => Intl.message(
      'You have {remainingDays} replace day(s). Not enough to leave',
      name: 'replaceDayNotEnough',
      args: [remainingDays],
      examples: const {'remainingDays': '3'}
  );
  String get reasonPlaceholder => Intl.message('Please write your reason here...', name: 'reasonPlaceholder', desc: 'Placeholder text for reason field');

  String get replaceRequestTitle => Intl.message('Request Replace', name: 'replaceRequestTitle',);
  String get dateErrorStart => Intl.message('Please select the start date after now', name: 'dateErrorStart',);
  String get dateErrorEnd => Intl.message('Please select the end date after now', name: 'dateErrorEnd',);
  String get dateErrorMonth => Intl.message('Please select a date range within the same month.', name: 'dateErrorMonth',);
  String get dateErrorBeforeEnd => Intl.message('Please select the start date before the end date', name: 'dateErrorBeforeEnd',);
  String get dayOffErrorStart => Intl.message('This start date is not a day off', name: 'dayOffErrorStart',);
  String get dayOffErrorEnd => Intl.message('This end date is not a day off', name: 'dayOffErrorEnd',);
  String totalDays(Object totalDays) => Intl.message('Total: $totalDays day(s)', name: 'totalDays', args: [totalDays],);
  String get phoneNumberError => Intl.message('Please enter your phone number', name: 'phoneNumberError',);
  String get submitSuccess => Intl.message('Submit successfully', name: 'submitSuccess',);
  String get submitFailure => Intl.message('Submit failed', name: 'submitFailure',);

  String get overtimeExceed => Intl.message('Overtime cannot exceed 12 hours', name: 'overtimeExceed',);
  String get requestOvertime => Intl.message('Request Overtime', name: 'requestOvertime',);
  // String get pleaseEnterYourReason => Intl.message('Please enter your reason', name: 'pleaseEnterYourReason',);
  // String get addedSuccessfully => Intl.message('Added successfully', name: 'addedSuccessfully',);
  // String get failedToAddRequest => Intl.message('Failed to add request', name: 'failedToAddRequest',);
  String get replace => Intl.message('Replacement', name: 'replace',);
  String get replaceRequestDetail => Intl.message('Replace Request Detail', name: 'replaceRequestDetail',);
  String get overtimeRequestDetail => Intl.message('Overtime Request Detail', name: 'overtimeRequestDetail',);
  String get alreadyCheckedOut => Intl.message('You have already checked out', name: 'alreadyCheckedOut',);
  String get checkinTimeOutsideOvertime => Intl.message('Check-in time is outside the overtime', name: 'checkinTimeOutsideOvertime',);

  String get workingTime => Intl.message('Working Time', name: 'workingTime',);
  String get workdayTime => Intl.message('Workday / Time', name: 'workdayTime',);
  String get holiday => Intl.message('Holiday', name: 'holiday',);
  String get dayOff => Intl.message('Day off', name: 'dayOff',);

  String get profile => Intl.message('Profile', name: 'profile',);
  String get logout => Intl.message('Logout', name: 'logout',);
  String get settings => Intl.message('Settings', name: 'settings',);
  String get department => Intl.message('Department', name: 'department',);
  String get position => Intl.message('Position', name: 'position',);
  String get joinAt => Intl.message('Join At', name: 'joinAt',);
  String get seniority => Intl.message('Seniority', name: 'seniority',);
  String get appVersion => Intl.message('App Version', name: 'appVersion',);
  String get member => Intl.message('Member', name: 'member',);
  String get year => Intl.message('year', name: 'year',);
  String get years => Intl.message('years', name: 'years',);
  String get month => Intl.message('month', name: 'month',);
  String get months => Intl.message('months', name: 'months',);
  String get day => Intl.message('day', name: 'day',);

  String get qrCodeScanner => Intl.message('QR Code Scanner', name: 'qrCodeScanner');
  String get code => Intl.message('Code', name: 'code');
  String get scanACode => Intl.message('Scan a code', name: 'scanACode');
  String get attendanceSuccessful => Intl.message('Attendance successful!', name: 'attendanceSuccessful');
  String get pleaseTryAgainOrContactYourManager => Intl.message('Please try again or contact your manager.', name: 'pleaseTryAgainOrContactYourManager');
  String get failedToLogIn => Intl.message('Failed to log in', name: 'failedToLogIn');
  String get scanQRCodeToLogin => Intl.message('Scan QR code to login', name: 'scanQRCodeToLogin');
  String get home => Intl.message('HOME', name: 'home');
  String get me => Intl.message('ME', name: 'me');
  String get failedToAddLeaveRequest => Intl.message('Failed to add leave request:', name: 'failedToAddLeaveRequest');
  String get logInSuccessfully => Intl.message('Log in successfully', name: 'logInSuccessfully');

  String get notification => Intl.message('Notification', name: 'notification');
  String get markAllAsRead => Intl.message('Mark all as read', name: 'markAllAsRead');

  String get noteTitle {return Intl.message('Note', name: 'noteTitle',);}
  String get submitNotePrompt {return Intl.message('Please submit your note before you scan', name: 'submitNotePrompt',);}
  String get noteHint {return Intl.message('Please write your note here...', name: 'noteHint',);}
  String get sorryLate {return Intl.message('Sorry I am late', name: 'sorryLate',);}
  String get iAmSick {return Intl.message('I am sick', name: 'iAmSick',);}
  String get doneButton {return Intl.message('DONE', name: 'doneButton',);}
  String get skipButton {return Intl.message('SKIP', name: 'skipButton',);}
  String get errorTitle {return Intl.message('Error', name: 'errorTitle',);}
  String get locationError {return Intl.message('You are not in the correct location to check-in.', name: 'locationError',);}
  String get ot_checkin_note {return Intl.message('Please check in no later than 30 minutes before and no later than 1 hour after the registration time!', name: 'ot_checkin_note',);}

  String get hours => Intl.message("hour(s)", name: 'hours');
  String get upload_success => Intl.message("Upload successfully", name: 'upload_success');
  String get upload_failed => Intl.message("Upload failed", name: 'upload_failed');
  String get haveRegisterRequest => Intl.message("You have registered a request at this time, please check again.", name: 'haveRegisterRequest');

  String dayOffError(date) => Intl.message(
      'The day {date} is a day off',
      name: 'dayOffError',
      args: [date],
  );
  String notDayOffError(date) => Intl.message(
      'The day {date} is not a day off',
      name: 'notDayOffError',
      args: [date],
  );

  String get feedback => Intl.message('Feedback', name: 'feedback',);
  String get recommendation => Intl.message('Recommendation', name: 'recommendation',);
  String get give_feedback => Intl.message("Give Feedback", name: 'give_feedback');
  String get write_feedback => Intl.message("Please write your feedback here...", name: 'write_feedback');
  String get write_recommendation => Intl.message("Please write your recommendation here...", name: 'write_recommendation');
  String get rate_experience => Intl.message("How would you rate your experience?", name: 'rate_experience');
  String get confirm_logout => Intl.message("Confirm Logout", name: 'confirm_logout');
  String get logout_confirmation => Intl.message("Are you sure you want to logout?\nIf you log out, you will need a QR code provided by your manager to log in again.", name: 'logout_confirmation');
  String get yes => Intl.message("Yes", name: 'yes');
  String get no => Intl.message("No", name: 'no');

  String get location_dialog_title => Intl.message("Location Permission Denied", name: 'location_dialog_title');
  String get location_dialog_content => Intl.message("You have permanently denied location access. Please enable the permission in system settings.", name: 'location_dialog_content');
  String get go_to_settings => Intl.message("Go to Settings", name: 'go_to_settings');
  String get cancel_lowercase => Intl.message("Cancel", name: 'cancel_lowercase');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi','km'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
