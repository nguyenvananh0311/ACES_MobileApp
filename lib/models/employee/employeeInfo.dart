
class EmployeeInformation {
  final int id;
  final String name;
  final String nameInKhmer;
  final bool isApp;
  final bool isActive;
  final bool isDeleted;
  final bool isNoNeedScan;
  final bool isAddFace;
  final bool canApprove;
  final String dateOfBirth;
  final String createdTime;
  final String positionId;
  final String departmentId;
  final String branchId;
  final String positionGroupId;
  final String companyId;
  final String identityCardNumber;
  final String nssfNumber;
  final String gender;
  final String address;
  final String phoneNumber;
  final String emailAddress;
  final Position position;
  final Department department;
  final Branch branch;
  final PositionGroup positionGroup;

  EmployeeInformation({
    required this.id,
    required this.name,
    required this.nameInKhmer,
    required this.isApp,
    required this.isActive,
    required this.isDeleted,
    required this.isNoNeedScan,
    required this.isAddFace,
    required this.canApprove,
    required this.dateOfBirth,
    required this.createdTime,
    required this.positionId,
    required this.departmentId,
    required this.branchId,
    required this.positionGroupId,
    required this.companyId,
    required this.identityCardNumber,
    required this.nssfNumber,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.emailAddress,
    required this.position,
    required this.department,
    required this.branch,
    required this.positionGroup,
  });

  factory EmployeeInformation.fromJson(Map<String, dynamic> json) {
    return EmployeeInformation(
      id: json['id'],
      name: json['name'],
      nameInKhmer: json['nameInKhmer'],
      isApp: json['isApp'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      isNoNeedScan: json['isNoNeedScan'],
      isAddFace: json['isAddFace'],
      canApprove: json['canApprove'],
      dateOfBirth: json['dateOfBirth'],
      createdTime: json['createdTime'],
      positionId: json['positionId'],
      departmentId: json['departmentId'],
      branchId: json['branchId'],
      positionGroupId: json['positionGroupId'],
      companyId: json['companyId'],
      identityCardNumber: json['identityCardNumber'],
      nssfNumber: json['nssfNumber'],
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      emailAddress: json['emailAddress'],
      position: Position.fromJson(json['position']),
      department: Department.fromJson(json['department']),
      branch: Branch.fromJson(json['branch']),
      positionGroup: PositionGroup.fromJson(json['positionGroup']),
    );
  }
}

class Position {
  final String id;
  final String name;
  final String companyId;

  Position({
    required this.id,
    required this.name,
    required this.companyId,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
    );
  }
}

class Department {
  final String id;
  final String name;
  final bool isDeleted;
  final String companyId;
  final String parentId;
  final Company company;

  Department({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.companyId,
    required this.parentId,
    required this.company,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      isDeleted: json['isDeleted'],
      companyId: json['companyId'],
      parentId: json['parentId'],
      company: Company.fromJson(json['company']),
    );
  }
}

class Branch {
  final String id;
  final String name;

  Branch({
    required this.id,
    required this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
    );
  }
}

class PositionGroup {
  final String id;
  final String name;
  final String companyId;
  final bool isManager;
  final bool isDirector;
  final bool isLeader;

  PositionGroup({
    required this.id,
    required this.name,
    required this.companyId,
    required this.isManager,
    required this.isDirector,
    required this.isLeader,
  });

  factory PositionGroup.fromJson(Map<String, dynamic> json) {
    return PositionGroup(
      id: json['id'],
      name: json['name'],
      companyId: json['companyId'],
      isManager: json['isManager'],
      isDirector: json['isDirector'],
      isLeader: json['isLeader'],
    );
  }
}

class Company {
  final String id;
  final String name;

  Company({
    required this.id,
    required this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
    );
  }
}
