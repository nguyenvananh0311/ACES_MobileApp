
class MemberProfile {
  final int? id;
  final String name;
  final String department;
  final String branch;
  final String position;
  final String? phoneNumber;

  MemberProfile({
    this.id,
    required this.name,
    required this.department,
    required this.branch,
    required this.position,
    this.phoneNumber
  });

  factory MemberProfile.fromJson(Map<String, dynamic> json) {
    return MemberProfile(
      id: json['id'],
      name: json['name'],
      branch: json['branch'],
      department:json['department'],
      position:json['position'],
      phoneNumber: json['phoneNumber'] as String?,
    );
  }
}
