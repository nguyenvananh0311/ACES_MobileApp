class EmployeePayslipInformation {
  final String id;
  final int employeeId;
  final String bankName;
  final String bankAccountName;
  final String bankAccountNumber;

  EmployeePayslipInformation({
    required this.id,
    required this.employeeId,
    required this.bankName,
    required this.bankAccountName,
    required this.bankAccountNumber,
  });

  factory EmployeePayslipInformation.fromJson(Map<String, dynamic> json) {
    return EmployeePayslipInformation(
      id: json['id'],
      employeeId: json['employeeId'],
      bankName: json['bankName'],
      bankAccountName:  json['bankAccountName'],
      bankAccountNumber: json['bankAccountNumber'],
    );
  }
}

class EmployeeWorkingInformation {
  final String id;
  final int employeeId;
  final String branchId;
  final String otherBranch;
  final String joinTime;
  final String branchName;
  final String typeId;
  final int seniority;

  EmployeeWorkingInformation({
    required this.id,
    required this.employeeId,
    required this.branchId,
    required this.otherBranch,
    required this.joinTime,
    required this.branchName,
    required this.typeId,
    required this.seniority,
  });

  factory EmployeeWorkingInformation.fromJson(Map<String, dynamic> json) {

    return EmployeeWorkingInformation(
      id: json['id'],
      employeeId: json['employeeId'],
      branchId: json['branchId'],
      otherBranch: json['otherBranch'],
      joinTime: json['joinTime'],
      branchName: json['branchName'],
      typeId: json['typeId'],
      seniority: json['seniority'],
    );
  }
}
