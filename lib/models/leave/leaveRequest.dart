class LeaveRequest {
  final String? id;
  final int employeeId;
  final DateTime? createdDate;
  final String type; // Annual-Replace-Unpaid
  final String reason;
  final DateTime fromDate;
  final bool isFromMorning;
  final DateTime toDate;
  final bool isToAfternoon;
  final double duration;
  final String? backupEmployeeId;
  final String? approvedById;
  final String? backupEmployeeName;
  final String? approvedByName;
  final String contactNumber;
  final String? status;
  final String? fileName;
  final String? image;
  final String? comment;
  final String? updateByName;

  LeaveRequest({
    required this.employeeId,
    required this.type,
    required this.reason,
    required this.fromDate,
    required this.isFromMorning,
    required this.toDate,
    required this.isToAfternoon,
    required this.duration,
    this.backupEmployeeId,
    required this.contactNumber,
    required this.status,
    this.fileName,
    this.id,
    this.approvedById,
    this.approvedByName,
    this.createdDate,
    this.backupEmployeeName,
    this.image,
    this.comment,
    this.updateByName
  });

  // Convert from JSON
  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'] as String,
      employeeId: json['employeeId'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      type: json['type'] as String,
      reason: json['reason'] as String,
      fromDate: DateTime.parse(json['fromDate'] as String),
      isFromMorning: json['isFromMorning'] as bool,
      toDate: DateTime.parse(json['toDate'] as String),
      isToAfternoon: json['isToAfternoon'] as bool,
      duration: double.parse(json['duration'].toString()) ,
      backupEmployeeId: json['backupEmployeeId'] as String?,
      approvedById: json['approvalById'] as String?,
      backupEmployeeName: json['backupEmployeeName'] as String?,
      approvedByName: json['approvalByName'] as String?,
      contactNumber: json['contactNumber'] as String,
      status: json['status'] as String,
      fileName: json['fileName'] as String?,
      image: json['image'] as String?,
      comment: json['comment'] as String?,
      updateByName: json['updateByName'] as String?
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'employeeId': employeeId,
      // 'createdDate': createdDate?.toIso8601String(),
      'type': type,
      'reason': reason,
      'fromDate': fromDate.toIso8601String(),
      'isFromMorning': isFromMorning,
      'toDate': toDate.toIso8601String(),
      'isToAfternoon': isToAfternoon,
      'duration': duration,
      'backupEmployeeId': backupEmployeeId,
      'approvalById': approvedById,
      'backupEmployeeName': backupEmployeeName,
      'approvalByName': approvedByName,
      'contactNumber': contactNumber,
      'status': status,
      'fileName': fileName,
      'image': image
    };
  }
}
