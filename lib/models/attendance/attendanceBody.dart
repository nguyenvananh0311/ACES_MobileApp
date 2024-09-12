
class AttendanceBody {
  String? cameraId;
  String? requestId;
  int? employeeId;
  String? employeeName;
  String? note;
  String? qRCode;

  AttendanceBody({
    this.cameraId,
    this.employeeId,
    this.employeeName,
    this.note,
    this.qRCode,
    this.requestId
  });

  // Method to convert a AttendanceBody object to a map
  Map<String, dynamic> toJson() {
    return {
      'cameraId': cameraId,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'note': note,
      'qRCode': qRCode,
      'requestId': requestId
    };
  }

  // Method to create a AttendanceBody object from a map
  factory AttendanceBody.fromJson(Map<String, dynamic> map) {
    return AttendanceBody(
      cameraId: map['cameraId'] as String?,
      employeeId: map['employeeId'] as int?,
      employeeName: map['employeeName'] as String?,
      note: map['note'] as String?,
      qRCode: map['qRCode'] as String?,
      requestId: map['requestId'] as String?
    );
  }

}
