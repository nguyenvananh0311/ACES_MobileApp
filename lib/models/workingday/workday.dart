
class WorkDay {
  final String id;
  final int employeeId;
  final int day;
  final String dayName;
  final bool status;
  final String? morCheckInTime;
  final String? morCheckOutTime;
  final String? aftCheckInTime;
  final String? aftCheckOutTime;

  WorkDay({
    required this.id,
    required this.employeeId,
    required this.day,
    required this.dayName,
    required this.status,
    this.morCheckInTime,
    this.morCheckOutTime,
    this.aftCheckInTime,
    this.aftCheckOutTime,
  });

  factory WorkDay.fromJson(Map<String, dynamic> json) {
    return WorkDay(
      id: json['id'],
      employeeId: json['employeeId'],
      status: json['status'],
      day: json['day'],
      dayName: json['dayName'],
      aftCheckInTime: json['aftCheckInTime'],
      aftCheckOutTime: json['aftCheckOutTime'],
      morCheckInTime: json['morCheckInTime'],
      morCheckOutTime: json['morCheckOutTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'status': status,
      'day': day,
      'dayName': dayName,
      'aftCheckInTime': aftCheckInTime,
      'aftCheckOutTime': aftCheckOutTime,
      'morCheckInTime': morCheckInTime,
      'morCheckOutTime': morCheckOutTime,
    };
  }
}
