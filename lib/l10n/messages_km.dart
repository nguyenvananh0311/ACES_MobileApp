// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a km locale. All the
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
  String get localeName => 'km';

  static m0(remainingDays) => "អ្នកមាន ${remainingDays} ថ្ងៃឈប់សម្រាប់ឆ្នាំនេះ។ មិនគ្រប់គ្រាន់សម្រាប់ការឈប់";

  static m1(date) => "ថ្ងៃ ${date} គឺជាថ្ងៃឈប់សម្រាក។";

  static m2(error) => "កំហុស: ${error}";

  static m3(date) => "ថ្ងៃ ${date} មិនមែនជាថ្ងៃឈប់សម្រាកទេ។";

  static m4(remainingDays) => "អ្នកមាន ${remainingDays} ថ្ងៃប្តូរ។ មិនគ្រប់គ្រាន់ដើម្បីចេញទៅទេ";

  static m5(totalDays) => "សរុប: ${totalDays} ថ្ងៃ";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'add_leave_request': MessageLookupByLibrary.simpleMessage('បន្ថែមសំណើសុំសំរាក'),
    'afternoon': MessageLookupByLibrary.simpleMessage('ល្ងាច'),
    'all': MessageLookupByLibrary.simpleMessage('ទាំងអស់'),
    'alreadyCheckedOut': MessageLookupByLibrary.simpleMessage('អ្នកបានចេញហើយ'),
    'annualDayNotEnough': m0,
    'annual_leave': MessageLookupByLibrary.simpleMessage('សំរាកប្រចាំឆ្នាំ'),
    'appVersion': MessageLookupByLibrary.simpleMessage('កំណែកម្មវិធី'),
    'approved': MessageLookupByLibrary.simpleMessage('បានអនុម័ត'),
    'approvedBy': MessageLookupByLibrary.simpleMessage('អនុម័តដោយ'),
    'attendance': MessageLookupByLibrary.simpleMessage('វត្តមាន'),
    'attendanceSubtitle': MessageLookupByLibrary.simpleMessage('ចូល / ចេញ'),
    'attendanceSuccessful': MessageLookupByLibrary.simpleMessage('ចូលរួមដោយជោគជ័យ!'),
    'attendanceTitle': MessageLookupByLibrary.simpleMessage('ការចុះឈ្មោះ'),
    'attendance_history': MessageLookupByLibrary.simpleMessage('ប្រវត្តិវត្តមាន'),
    'calendarSubtitle': MessageLookupByLibrary.simpleMessage('ថ្ងៃធ្វើការ និងថ្ងៃឈប់សម្រាក'),
    'calendarTitle': MessageLookupByLibrary.simpleMessage('ប្រតិទិនរបស់ខ្ញុំ'),
    'cancel': MessageLookupByLibrary.simpleMessage('បោះបង់'),
    'canceledSuccessfully': MessageLookupByLibrary.simpleMessage('បានលុបដោយជោគជ័យ'),
    'cannot_check_in': MessageLookupByLibrary.simpleMessage('មិនអាចចូលរួច'),
    'check': MessageLookupByLibrary.simpleMessage('ពិនិត្យ'),
    'check_in': MessageLookupByLibrary.simpleMessage('ចូល'),
    'check_out': MessageLookupByLibrary.simpleMessage('ចេញ'),
    'checkinTimeOutsideOvertime': MessageLookupByLibrary.simpleMessage('ពេលវេលា Check-in គឺខុសពីម៉ោងបន្ថែម'),
    'code': MessageLookupByLibrary.simpleMessage('កូដ'),
    'comment': MessageLookupByLibrary.simpleMessage('មតិយោបល់'),
    'confirm_logout': MessageLookupByLibrary.simpleMessage('បញ្ជាក់ការចេញចូល'),
    'created_date': MessageLookupByLibrary.simpleMessage('កាលបរិច្ឆេទបង្កើត'),
    'date': MessageLookupByLibrary.simpleMessage('ថ្ងៃ'),
    'dateErrorBeforeEnd': MessageLookupByLibrary.simpleMessage('សូមជ្រើសរើសថ្ងៃចាប់ផ្តើមមុនថ្ងៃចុងក្រោយ'),
    'dateErrorEnd': MessageLookupByLibrary.simpleMessage('សូមជ្រើសរើសថ្ងៃចុងក្រោយក្រោយពេលបច្ចុប្បន្ន'),
    'dateErrorMonth': MessageLookupByLibrary.simpleMessage('សូមជ្រើសរើសចន្លោះថ្ងៃនៅក្នុងខែតែមួយ។'),
    'dateErrorStart': MessageLookupByLibrary.simpleMessage('សូមជ្រើសរើសថ្ងៃចាប់ផ្តើមក្រោយពេលបច្ចុប្បន្ន'),
    'day': MessageLookupByLibrary.simpleMessage('ថ្ងៃ'),
    'dayOff': MessageLookupByLibrary.simpleMessage('ថ្ងៃឈប់'),
    'dayOffError': m1,
    'dayOffErrorEnd': MessageLookupByLibrary.simpleMessage('ថ្ងៃចុងក្រោយនេះមិនមែនជាថ្ងៃសម្រាកទេ'),
    'dayOffErrorStart': MessageLookupByLibrary.simpleMessage('ថ្ងៃចាប់ផ្តើមនេះមិនមែនជាថ្ងៃសម្រាកទេ'),
    'days': MessageLookupByLibrary.simpleMessage('ថ្ងៃ'),
    'department': MessageLookupByLibrary.simpleMessage('នាយកដ្ឋាន'),
    'description': MessageLookupByLibrary.simpleMessage('ការពិពណ៌នា'),
    'doneButton': MessageLookupByLibrary.simpleMessage('ធ្វើរួច'),
    'duration': MessageLookupByLibrary.simpleMessage('រយៈពេល'),
    'early': MessageLookupByLibrary.simpleMessage('មុនពេល'),
    'error': m2,
    'errorLeaveRequest': MessageLookupByLibrary.simpleMessage('ការស្នើសុំឈប់បរាជ័យ'),
    'errorTitle': MessageLookupByLibrary.simpleMessage('កំហុស'),
    'failedToAddLeaveRequest': MessageLookupByLibrary.simpleMessage('បរាជ័យក្នុងការបន្ថែមសំណើចាកចេញ:'),
    'failedToCancel': MessageLookupByLibrary.simpleMessage('មិនអាចលុប'),
    'failedToLogIn': MessageLookupByLibrary.simpleMessage('បរាជ័យក្នុងការចូល'),
    'feedback': MessageLookupByLibrary.simpleMessage('មតិយោបល់'),
    'from': MessageLookupByLibrary.simpleMessage('ពី'),
    'give_feedback': MessageLookupByLibrary.simpleMessage('ផ្តល់មតិយោបល់'),
    'go_to_settings': MessageLookupByLibrary.simpleMessage('ទៅកាន់ការកំណត់'),
    'haveRegisterRequest': MessageLookupByLibrary.simpleMessage('អ្នកបានចុះឈ្មោះសំណើនៅក្នុងពេលវេលានេះ សូមពិនិត្យម្តងទៀត។'),
    'holiday': MessageLookupByLibrary.simpleMessage('ថ្ងៃឈប់សម្រាក'),
    'home': MessageLookupByLibrary.simpleMessage('ទំព័រដើម'),
    'hours': MessageLookupByLibrary.simpleMessage('ម៉ោង'),
    'iAmSick': MessageLookupByLibrary.simpleMessage('ខ្ញុំឈឺ'),
    'joinAt': MessageLookupByLibrary.simpleMessage('ចូលរួមនៅ'),
    'late': MessageLookupByLibrary.simpleMessage('យឺត'),
    'leave': MessageLookupByLibrary.simpleMessage('សំរាក'),
    'leaveRequestDetail': MessageLookupByLibrary.simpleMessage('ព័ត៌មានលម្អិតអំពីការស្នើសុំឈប់'),
    'leaveSubtitle': MessageLookupByLibrary.simpleMessage('ប្រវត្តិ និងស្នើរសុំការច្បាស់លាស់'),
    'leaveTitle': MessageLookupByLibrary.simpleMessage('ការច្បាស់លាស់'),
    'leaveType': MessageLookupByLibrary.simpleMessage('ប្រភេទការស្នើសុំឈប់'),
    'loading': MessageLookupByLibrary.simpleMessage('កំពុងផ្ទុក...'),
    'locationError': MessageLookupByLibrary.simpleMessage('អ្នកមិននៅក្នុងទីតាំងត្រឹមត្រូវដើម្បីចុះឈ្មោះ។'),
    'location_dialog_content': MessageLookupByLibrary.simpleMessage('អ្នកបានបដិសេធការចូលដំណើរការទីតាំងយ៉ាងអចិន្រ្ដៃយ៍។ សូមបើកការអនុញ្ញាតនៅក្នុងការកំណត់ប្រព័ន្ធ។'),
    'location_dialog_title': MessageLookupByLibrary.simpleMessage('បានបដិសេធការអនុញ្ញាតទីតាំង'),
    'logInSuccessfully': MessageLookupByLibrary.simpleMessage('ចូលដោយជោគជ័យ'),
    'logout': MessageLookupByLibrary.simpleMessage('ចាកចេញ'),
    'logout_confirmation': MessageLookupByLibrary.simpleMessage('តើអ្នកប្រាកដថាលាចេញចូលឬទេ?\nបើអ្នកចេញចូល អ្នកត្រូវការម៉ូដ QR ដែលត្រូវបានផ្ដល់ដោយអ្នកគ្រប់គ្រងរបស់អ្នកដើម្បីចូលប្រើវិញ។'),
    'markAllAsRead': MessageLookupByLibrary.simpleMessage('ធ្វើការវាយស្នាមទាំងអស់ថាអានរួច'),
    'me': MessageLookupByLibrary.simpleMessage('ខ្ញុំ'),
    'member': MessageLookupByLibrary.simpleMessage('សមាជិក'),
    'membersSubtitle': MessageLookupByLibrary.simpleMessage('បញ្ជីសមាជិកទាំងអស់'),
    'membersTitle': MessageLookupByLibrary.simpleMessage('សមាជិក'),
    'month': MessageLookupByLibrary.simpleMessage('ខែ'),
    'months': MessageLookupByLibrary.simpleMessage('ខែ'),
    'morning': MessageLookupByLibrary.simpleMessage('ព្រឹក'),
    'no': MessageLookupByLibrary.simpleMessage('ទេ'),
    'noDataAvailable': MessageLookupByLibrary.simpleMessage('មិនមានទិន្នន័យ'),
    'noFileSelected': MessageLookupByLibrary.simpleMessage('មិនមានឯកសារត្រូវបានជ្រើសរើស'),
    'no_data': MessageLookupByLibrary.simpleMessage('គ្មានទិន្នន័យ'),
    'notDayOffError': m3,
    'noteHint': MessageLookupByLibrary.simpleMessage('សូមសរសេរកំណត់ចំណាំរបស់អ្នកនៅទីនេះ...'),
    'noteTitle': MessageLookupByLibrary.simpleMessage('កំណត់ចំណាំ'),
    'notification': MessageLookupByLibrary.simpleMessage('ជូនដំណឹង'),
    'ot_checkin_note': MessageLookupByLibrary.simpleMessage('សូមធ្វើការចូលមុន 30 នាទីមុនពេលចុះឈ្មោះ និងមិនលើសពី 1 ម៉ោងបន្ទាប់ពីពេលចុះឈ្មោះ។'),
    'overtimeExceed': MessageLookupByLibrary.simpleMessage('ម៉ោងលើសម៉ោងមិនអាចលើសពី 12 ម៉ោង'),
    'overtimeRequestDetail': MessageLookupByLibrary.simpleMessage('ស្នើសុំម៉ោងបន្ថែមលម្អិត'),
    'overtimeSubtitle': MessageLookupByLibrary.simpleMessage('ស្នើរសុំ និងប្រវត្តិម៉ោងបន្ថែម'),
    'overtimeTitle': MessageLookupByLibrary.simpleMessage('ម៉ោងបន្ថែម'),
    'pending': MessageLookupByLibrary.simpleMessage('រង់ចាំ'),
    'phoneNumber': MessageLookupByLibrary.simpleMessage('លេខទូរស័ព្ទ'),
    'phoneNumberError': MessageLookupByLibrary.simpleMessage('សូមបញ្ចូលលេខទូរស័ព្ទរបស់អ្នក'),
    'pleaseEnterLeaveReason': MessageLookupByLibrary.simpleMessage('សូមបញ្ចូលហេតុផល'),
    'pleaseEnterPhoneNumber': MessageLookupByLibrary.simpleMessage('សូមបញ្ចូលលេខទូរស័ព្ទរបស់អ្នក'),
    'pleaseSelectStartBeforeEnd': MessageLookupByLibrary.simpleMessage('សូមជ្រើសរើសថ្ងៃចាប់ផ្តើមមុនថ្ងៃបញ្ចប់'),
    'pleaseTryAgainOrContactYourManager': MessageLookupByLibrary.simpleMessage('សូមព្យាយាមម្តងទៀត ឬទាក់ទងអ្នកគ្រប់គ្រងរបស់អ្នក។'),
    'position': MessageLookupByLibrary.simpleMessage('មុខតំណែង'),
    'profile': MessageLookupByLibrary.simpleMessage('ប្រវត្តិរូប'),
    'qrCodeScanner': MessageLookupByLibrary.simpleMessage('ឧបករណ៍ស្កេន QR កូដ'),
    'rate_experience': MessageLookupByLibrary.simpleMessage('អ្នកនឹងតម្លៃបទពិសោធន៍របស់អ្នកយ៉ាងដូចម្តេច?'),
    'reason': MessageLookupByLibrary.simpleMessage('មូលហេតុ'),
    'reasonPlaceholder': MessageLookupByLibrary.simpleMessage('សូមសរសេរเหตุผลរបស់អ្នកនៅទីនេះ...'),
    'recommendation': MessageLookupByLibrary.simpleMessage('សំណើ'),
    'rejected': MessageLookupByLibrary.simpleMessage('បានបដិសេធ'),
    'replace': MessageLookupByLibrary.simpleMessage('ជំនួស'),
    'replaceDayNotEnough': m4,
    'replaceRequestDetail': MessageLookupByLibrary.simpleMessage('ស្នើសុំជំនួសលម្អិត'),
    'replaceRequestTitle': MessageLookupByLibrary.simpleMessage('ស្នើសុំប្តូរ'),
    'replaceSubtitle': MessageLookupByLibrary.simpleMessage('ប្រវត្តិ និងស្នើរសុំការជំនួស'),
    'replaceTitle': MessageLookupByLibrary.simpleMessage('ការជំនួស'),
    'replace_leave': MessageLookupByLibrary.simpleMessage('សំរាកជំនួស'),
    'requestLeave': MessageLookupByLibrary.simpleMessage('សំណើសុំឈប់'),
    'requestOvertime': MessageLookupByLibrary.simpleMessage('ស្នើសុំម៉ោងបន្ថែម'),
    'scanACode': MessageLookupByLibrary.simpleMessage('ស្កេនកូដ'),
    'scanQRCodeToLogin': MessageLookupByLibrary.simpleMessage('ស្កេន QR កូដ ដើម្បីចូល'),
    'seniority': MessageLookupByLibrary.simpleMessage('អតីតភាព'),
    'settings': MessageLookupByLibrary.simpleMessage('ការកំណត់'),
    'skipButton': MessageLookupByLibrary.simpleMessage('រំលង'),
    'sorryLate': MessageLookupByLibrary.simpleMessage('សូមអភ័យទោស ខ្ញុំមកយឺត'),
    'status': MessageLookupByLibrary.simpleMessage('ស្ថានភាព'),
    'submit': MessageLookupByLibrary.simpleMessage('ដាក់ស្នើ'),
    'submitFailure': MessageLookupByLibrary.simpleMessage('បន្ថែមបរាជ័យ'),
    'submitNotePrompt': MessageLookupByLibrary.simpleMessage('សូមដាក់កំណត់ចំណាំរបស់អ្នកមុនពេលស្កេន'),
    'submitSuccess': MessageLookupByLibrary.simpleMessage('បន្ថែមដោយជោគជ័យ'),
    'successLeaveRequest': MessageLookupByLibrary.simpleMessage('ការស្នើសុំឈប់បានបន្ថែមដោយជោគជ័យ'),
    'title': MessageLookupByLibrary.simpleMessage('កន្លែងធ្វើការប្រាកដ'),
    'to': MessageLookupByLibrary.simpleMessage('ទៅ'),
    'total': MessageLookupByLibrary.simpleMessage('សរុប'),
    'totalDays': m5,
    'typeOfLeave': MessageLookupByLibrary.simpleMessage('ប្រភេទការឈប់'),
    'unchecked': MessageLookupByLibrary.simpleMessage('មិនបានចុះឈ្មោះ'),
    'unpaid': MessageLookupByLibrary.simpleMessage('គ្មានប្រាក់ខែ'),
    'upload_failed': MessageLookupByLibrary.simpleMessage('ផ្ទុកឡើងបរាជ័យ'),
    'upload_success': MessageLookupByLibrary.simpleMessage('ផ្ទុកឡើងដោយជោគជ័យ'),
    'workdayTime': MessageLookupByLibrary.simpleMessage('ថ្ងៃធ្វើការ / ម៉ោង'),
    'workingTime': MessageLookupByLibrary.simpleMessage('ម៉ោងធ្វើការ'),
    'write_feedback': MessageLookupByLibrary.simpleMessage('សូមសរសេរ​មតិយោបល់​របស់​អ្នកនៅទីនេះ...'),
    'write_recommendation': MessageLookupByLibrary.simpleMessage('សូមសរសេរ​សំណើ​របស់​អ្នកនៅទីនេះ...'),
    'year': MessageLookupByLibrary.simpleMessage('ឆ្នាំ'),
    'years': MessageLookupByLibrary.simpleMessage('ឆ្នាំ'),
    'yes': MessageLookupByLibrary.simpleMessage('បាទ')
  };
}
