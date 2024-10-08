// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static m0(remainingDays) => "Bạn có ${remainingDays} ngày nghỉ phép hàng năm. Không đủ để nghỉ";

  static m1(date) => "Ngày ${date} là ngày nghỉ.";

  static m2(error) => "Lỗi: ${error}";

  static m3(date) => "Ngày ${date} không phải là ngày nghỉ.";

  static m4(remainingDays) => "Bạn có ${remainingDays} ngày nghỉ phép bù. Không đủ để nghỉ";

  static m5(totalDays) => "Tổng cộng: ${totalDays} ngày";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'add_leave_request': MessageLookupByLibrary.simpleMessage('Thêm yêu cầu nghỉ phép'),
    'afternoon': MessageLookupByLibrary.simpleMessage('Buổi chiều'),
    'all': MessageLookupByLibrary.simpleMessage('Tất cả'),
    'alreadyCheckedOut': MessageLookupByLibrary.simpleMessage('Bạn đã check-out rồi'),
    'annualDayNotEnough': m0,
    'annual_leave': MessageLookupByLibrary.simpleMessage('Nghỉ phép hàng năm'),
    'appVersion': MessageLookupByLibrary.simpleMessage('Phiên bản ứng dụng'),
    'approved': MessageLookupByLibrary.simpleMessage('Đã duyệt'),
    'approvedBy': MessageLookupByLibrary.simpleMessage('Duyệt bởi'),
    'attendance': MessageLookupByLibrary.simpleMessage('Điểm danh'),
    'attendanceSubtitle': MessageLookupByLibrary.simpleMessage('Điểm danh/Đăng xuất'),
    'attendanceSuccessful': MessageLookupByLibrary.simpleMessage('Điểm danh thành công!'),
    'attendanceTitle': MessageLookupByLibrary.simpleMessage('Chấm công'),
    'attendance_history': MessageLookupByLibrary.simpleMessage('Lịch sử điểm danh'),
    'calendarSubtitle': MessageLookupByLibrary.simpleMessage('Ngày làm việc & Ngày nghỉ'),
    'calendarTitle': MessageLookupByLibrary.simpleMessage('Lịch của tôi'),
    'cancel': MessageLookupByLibrary.simpleMessage('HỦY'),
    'canceledSuccessfully': MessageLookupByLibrary.simpleMessage('Hủy thành công'),
    'cannot_check_in': MessageLookupByLibrary.simpleMessage('Không thể điểm danh'),
    'check': MessageLookupByLibrary.simpleMessage('Điểm danh'),
    'check_in': MessageLookupByLibrary.simpleMessage('Điểm danh vào'),
    'check_out': MessageLookupByLibrary.simpleMessage('Điểm danh ra'),
    'checkinTimeOutsideOvertime': MessageLookupByLibrary.simpleMessage('Thời gian check-in nằm ngoài thời gian làm thêm giờ'),
    'code': MessageLookupByLibrary.simpleMessage('Mã'),
    'comment': MessageLookupByLibrary.simpleMessage('Nhận xét'),
    'confirm_logout': MessageLookupByLibrary.simpleMessage('Xác nhận đăng xuất'),
    'created_date': MessageLookupByLibrary.simpleMessage('Ngày tạo'),
    'date': MessageLookupByLibrary.simpleMessage('Ngày'),
    'dateErrorBeforeEnd': MessageLookupByLibrary.simpleMessage('Vui lòng chọn ngày bắt đầu trước ngày kết thúc'),
    'dateErrorEnd': MessageLookupByLibrary.simpleMessage('Vui lòng chọn ngày kết thúc sau thời điểm hiện tại'),
    'dateErrorMonth': MessageLookupByLibrary.simpleMessage('Vui lòng chọn khoảng thời gian trong cùng một tháng.'),
    'dateErrorStart': MessageLookupByLibrary.simpleMessage('Vui lòng chọn ngày bắt đầu sau thời điểm hiện tại'),
    'day': MessageLookupByLibrary.simpleMessage('ngày'),
    'dayOff': MessageLookupByLibrary.simpleMessage('Ngày nghỉ'),
    'dayOffError': m1,
    'dayOffErrorEnd': MessageLookupByLibrary.simpleMessage('Ngày kết thúc này không phải là ngày nghỉ'),
    'dayOffErrorStart': MessageLookupByLibrary.simpleMessage('Ngày bắt đầu này không phải là ngày nghỉ'),
    'days': MessageLookupByLibrary.simpleMessage('ngày'),
    'department': MessageLookupByLibrary.simpleMessage('Phòng ban'),
    'description': MessageLookupByLibrary.simpleMessage('Mô tả'),
    'doneButton': MessageLookupByLibrary.simpleMessage('HOÀN TẤT'),
    'duration': MessageLookupByLibrary.simpleMessage('Thời gian'),
    'early': MessageLookupByLibrary.simpleMessage('Sớm'),
    'error': m2,
    'errorLeaveRequest': MessageLookupByLibrary.simpleMessage('Thêm yêu cầu nghỉ thất bại'),
    'errorTitle': MessageLookupByLibrary.simpleMessage('Lỗi'),
    'failedToAddLeaveRequest': MessageLookupByLibrary.simpleMessage('Thêm yêu cầu nghỉ phép thất bại:'),
    'failedToCancel': MessageLookupByLibrary.simpleMessage('Hủy không thành công'),
    'failedToLogIn': MessageLookupByLibrary.simpleMessage('Đăng nhập thất bại'),
    'feedback': MessageLookupByLibrary.simpleMessage('Đánh giá'),
    'from': MessageLookupByLibrary.simpleMessage('Từ'),
    'give_feedback': MessageLookupByLibrary.simpleMessage('Gửi đánh giá'),
    'go_to_settings': MessageLookupByLibrary.simpleMessage('Đi đến cài đặt'),
    'haveRegisterRequest': MessageLookupByLibrary.simpleMessage('Bạn đã đăng ký yêu cầu vào thời gian này, vui lòng kiểm tra lại.'),
    'holiday': MessageLookupByLibrary.simpleMessage('Ngày nghỉ'),
    'home': MessageLookupByLibrary.simpleMessage('TRANG CHỦ'),
    'hours': MessageLookupByLibrary.simpleMessage('giờ'),
    'iAmSick': MessageLookupByLibrary.simpleMessage('Tôi bị ốm'),
    'joinAt': MessageLookupByLibrary.simpleMessage('Gia nhập lúc'),
    'late': MessageLookupByLibrary.simpleMessage('Trễ'),
    'leave': MessageLookupByLibrary.simpleMessage('Nghỉ phép'),
    'leaveRequestDetail': MessageLookupByLibrary.simpleMessage('Chi tiết yêu cầu nghỉ phép'),
    'leaveSubtitle': MessageLookupByLibrary.simpleMessage('Lịch sử và yêu cầu nghỉ phép'),
    'leaveTitle': MessageLookupByLibrary.simpleMessage('Nghỉ phép'),
    'leaveType': MessageLookupByLibrary.simpleMessage('Loại nghỉ phép'),
    'loading': MessageLookupByLibrary.simpleMessage('Đang tải...'),
    'locationError': MessageLookupByLibrary.simpleMessage('Bạn không ở đúng vị trí để check-in.'),
    'location_dialog_content': MessageLookupByLibrary.simpleMessage('Bạn đã từ chối quyền truy cập vị trí vĩnh viễn. Hãy bật lại quyền trong cài đặt hệ thống.'),
    'location_dialog_title': MessageLookupByLibrary.simpleMessage('Quyền vị trí bị từ chối'),
    'logInSuccessfully': MessageLookupByLibrary.simpleMessage('Đăng nhập thành công'),
    'logout': MessageLookupByLibrary.simpleMessage('Đăng xuất'),
    'logout_confirmation': MessageLookupByLibrary.simpleMessage('Bạn có chắc chắn muốn đăng xuất không?\nNếu bạn đăng xuất, bạn sẽ cần mã QR được cung cấp bởi quản lý của bạn để đăng nhập lại.'),
    'markAllAsRead': MessageLookupByLibrary.simpleMessage('Đánh dấu tất cả là đã đọc'),
    'me': MessageLookupByLibrary.simpleMessage('TÔI'),
    'member': MessageLookupByLibrary.simpleMessage('Thành viên'),
    'membersSubtitle': MessageLookupByLibrary.simpleMessage('Danh sách tất cả các thành viên'),
    'membersTitle': MessageLookupByLibrary.simpleMessage('Thành viên'),
    'month': MessageLookupByLibrary.simpleMessage('tháng'),
    'months': MessageLookupByLibrary.simpleMessage('tháng'),
    'morning': MessageLookupByLibrary.simpleMessage('Buổi sáng'),
    'no': MessageLookupByLibrary.simpleMessage('Không'),
    'noDataAvailable': MessageLookupByLibrary.simpleMessage('Không có dữ liệu'),
    'noFileSelected': MessageLookupByLibrary.simpleMessage('Chưa chọn tệp'),
    'no_data': MessageLookupByLibrary.simpleMessage('Không có dữ liệu'),
    'notDayOffError': m3,
    'noteHint': MessageLookupByLibrary.simpleMessage('Vui lòng viết ghi chú của bạn ở đây...'),
    'noteTitle': MessageLookupByLibrary.simpleMessage('Ghi chú'),
    'notification': MessageLookupByLibrary.simpleMessage('Thông báo'),
    'ot_checkin_note': MessageLookupByLibrary.simpleMessage('Vui lòng thực hiện check in trước thời gian đăng ký tối đa 30 phút và sau thời gian đăng ký tối đa 1 giờ!'),
    'overtimeExceed': MessageLookupByLibrary.simpleMessage('Thời gian làm thêm không được vượt quá 12 giờ'),
    'overtimeRequestDetail': MessageLookupByLibrary.simpleMessage('Chi tiết yêu cầu làm thêm giờ'),
    'overtimeSubtitle': MessageLookupByLibrary.simpleMessage('Yêu cầu và lịch sử OT'),
    'overtimeTitle': MessageLookupByLibrary.simpleMessage('Làm thêm giờ'),
    'pending': MessageLookupByLibrary.simpleMessage('Đang chờ'),
    'phoneNumber': MessageLookupByLibrary.simpleMessage('Số điện thoại'),
    'phoneNumberError': MessageLookupByLibrary.simpleMessage('Vui lòng nhập số điện thoại của bạn'),
    'pleaseEnterLeaveReason': MessageLookupByLibrary.simpleMessage('Vui lòng nhập lý do'),
    'pleaseEnterPhoneNumber': MessageLookupByLibrary.simpleMessage('Vui lòng nhập số điện thoại của bạn'),
    'pleaseSelectStartBeforeEnd': MessageLookupByLibrary.simpleMessage('Vui lòng chọn ngày bắt đầu trước ngày kết thúc'),
    'pleaseTryAgainOrContactYourManager': MessageLookupByLibrary.simpleMessage('Vui lòng thử lại hoặc liên hệ với quản lý của bạn.'),
    'position': MessageLookupByLibrary.simpleMessage('Chức vụ'),
    'profile': MessageLookupByLibrary.simpleMessage('Hồ sơ'),
    'qrCodeScanner': MessageLookupByLibrary.simpleMessage('Quét mã QR'),
    'rate_experience': MessageLookupByLibrary.simpleMessage('Bạn đánh giá trải nghiệm của mình như thế nào?'),
    'reason': MessageLookupByLibrary.simpleMessage('Lý do'),
    'reasonPlaceholder': MessageLookupByLibrary.simpleMessage('Vui lòng viết lý do của bạn ở đây...'),
    'recommendation': MessageLookupByLibrary.simpleMessage('Đề xuất'),
    'rejected': MessageLookupByLibrary.simpleMessage('Bị từ chối'),
    'replace': MessageLookupByLibrary.simpleMessage('Thay thế'),
    'replaceDayNotEnough': m4,
    'replaceRequestDetail': MessageLookupByLibrary.simpleMessage('Chi tiết yêu cầu thay thế'),
    'replaceRequestTitle': MessageLookupByLibrary.simpleMessage('Yêu cầu thay thế'),
    'replaceSubtitle': MessageLookupByLibrary.simpleMessage('Lịch sử và yêu cầu làm bù'),
    'replaceTitle': MessageLookupByLibrary.simpleMessage('Làm bù'),
    'replace_leave': MessageLookupByLibrary.simpleMessage('Nghỉ thay thế'),
    'requestLeave': MessageLookupByLibrary.simpleMessage('Yêu cầu nghỉ'),
    'requestOvertime': MessageLookupByLibrary.simpleMessage('Yêu cầu làm thêm giờ'),
    'scanACode': MessageLookupByLibrary.simpleMessage('Quét mã'),
    'scanQRCodeToLogin': MessageLookupByLibrary.simpleMessage('Quét mã QR để đăng nhập'),
    'seniority': MessageLookupByLibrary.simpleMessage('Thâm niên'),
    'settings': MessageLookupByLibrary.simpleMessage('Cài đặt'),
    'skipButton': MessageLookupByLibrary.simpleMessage('BỎ QUA'),
    'sorryLate': MessageLookupByLibrary.simpleMessage('Xin lỗi tôi đến muộn'),
    'status': MessageLookupByLibrary.simpleMessage('Trạng thái'),
    'submit': MessageLookupByLibrary.simpleMessage('Gửi'),
    'submitFailure': MessageLookupByLibrary.simpleMessage('Thêm thất bại'),
    'submitNotePrompt': MessageLookupByLibrary.simpleMessage('Vui lòng gửi ghi chú của bạn trước khi quét'),
    'submitSuccess': MessageLookupByLibrary.simpleMessage('Thêm thành công'),
    'successLeaveRequest': MessageLookupByLibrary.simpleMessage('Yêu cầu nghỉ đã được thêm thành công'),
    'title': MessageLookupByLibrary.simpleMessage('Nơi làm việc'),
    'to': MessageLookupByLibrary.simpleMessage('Đến'),
    'total': MessageLookupByLibrary.simpleMessage('Tổng'),
    'totalDays': m5,
    'typeOfLeave': MessageLookupByLibrary.simpleMessage('Loại nghỉ'),
    'unchecked': MessageLookupByLibrary.simpleMessage('Chưa điểm danh'),
    'unpaid': MessageLookupByLibrary.simpleMessage('Không lương'),
    'upload_failed': MessageLookupByLibrary.simpleMessage('Tải lên thất bại'),
    'upload_success': MessageLookupByLibrary.simpleMessage('Tải lên thành công'),
    'workdayTime': MessageLookupByLibrary.simpleMessage('Ngày làm việc'),
    'workingTime': MessageLookupByLibrary.simpleMessage('Thời gian làm việc'),
    'write_feedback': MessageLookupByLibrary.simpleMessage('Vui lòng viết đánh giá của bạn ở đây...'),
    'write_recommendation': MessageLookupByLibrary.simpleMessage('Vui lòng viết đề xuất của bạn ở đây...'),
    'year': MessageLookupByLibrary.simpleMessage('năm'),
    'years': MessageLookupByLibrary.simpleMessage('năm'),
    'yes': MessageLookupByLibrary.simpleMessage('Có')
  };
}
