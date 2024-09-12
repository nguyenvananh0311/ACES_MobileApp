
class MonthlyLeave {
  String id;
  int employeeId;
  String employeeLeaveId;
  int year;
  int month;
  double earnedAnnualDay;
  double usedAnnualDay;
  double earnedReplaceDay;
  double usedReplaceDay;
  double unpaid;

  MonthlyLeave({
    required this.id,
    required this.employeeId,
    required this.employeeLeaveId,
    required this.year,
    required this.month,
    required this.earnedAnnualDay,
    required this.usedAnnualDay,
    required this.earnedReplaceDay,
    required this.usedReplaceDay,
    required this.unpaid,
  });

  // Method to create a MonthlyLeave object from a map
  factory MonthlyLeave.fromJson(Map<String, dynamic> map) {
    return MonthlyLeave(
      id: map['id'] as String,
      employeeId: map['employeeId'] as int,
      employeeLeaveId: map['employeeLeaveId'] as String,
      year: map['year'] as int,
      month: map['month'] as int,
      earnedAnnualDay:double.parse(map['earnedAnnualDay'].toString()),
      usedAnnualDay: double.parse(map['usedAnnualDay'].toString()),
      earnedReplaceDay: double.parse(map['earnedReplaceDay'].toString()) ,
      usedReplaceDay: double.parse(map['usedReplaceDay'].toString()),
      unpaid: double.parse(map['unpaid'].toString()),
    );
  }
  // Method to convert a MonthlyLeave object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeLeaveId': employeeLeaveId,
      'year': year,
      'month': month,
      'earnedAnnualDay': earnedAnnualDay,
      'usedAnnualDay': usedAnnualDay,
      'earnedReplaceDay': earnedReplaceDay,
      'usedReplaceDay': usedReplaceDay,
      'unpaid': unpaid,
    };
  }
}
