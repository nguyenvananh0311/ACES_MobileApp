class OvertimeRequest {
  final String? id;
  final int employeeId;
  final DateTime? createdDate;
  final String? reason;
  final DateTime fromDate;
  final DateTime toDate;
  final double duration;
  final String? approvedById;
  final String? approvedByName;
  final String contactNumber;
  final String? status;
  final String? fileName;
  final String? image;
  final String? comment;
  final String? updateByName;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  OvertimeRequest({
    required this.employeeId,
    required this.reason,
    required this.fromDate,
    required this.toDate,
    required this.duration,
    required this.contactNumber,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.fileName,
    this.id,
    this.approvedById,
    this.approvedByName,
    this.createdDate,
    this.image,
    this.comment,
    this.updateByName
  });

  // Convert from JSON
  factory OvertimeRequest.fromJson(Map<String, dynamic> json) {
    return OvertimeRequest(
      id: json['id'] as String,
      employeeId: json['employeeId'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      reason: json['reason'] as String,
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: DateTime.parse(json['toDate'] as String),
      duration: double.parse(json['duration'].toString()) ,
      approvedById: json['approvalById'] as String?,
      approvedByName: json['approvalByName'] as String?,
      contactNumber: json['contactNumber'] as String,
      status: json['status'] as String,
      fileName: json['fileName'] as String?,
      image: json['image'] as String?,
      comment: json['comment'] as String?,
      updateByName: json['updateByName'] as String?,
      checkInTime: json['checkInTime'] == null ? null : DateTime.parse(json['checkInTime'] as String) as DateTime?,
      checkOutTime: json['checkOutTime'] == null ? null : DateTime.parse(json['checkOutTime'] as String ),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'employeeId': employeeId,
      // 'createdDate': createdDate?.toIso8601String(),
      'reason': reason,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'duration': duration,
      'approvalById': approvedById,
      'approvalByName': approvedByName,
      'contactNumber': contactNumber,
      'status': status,
      'fileName': fileName,
      'image': image
    };
  }
}
