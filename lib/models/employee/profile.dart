
class Profile {
  final String name;
  final String department;
  final String branch;
  final String position;
  final String joinTime;
  final int seniority;

  Profile({
    required this.name,
    required this.department,
    required this.branch,
    required this.position,
    required this.seniority,
    required this.joinTime
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      branch: json['branch'],
      department:json['department'],
      position:json['position'],
      seniority: json['seniority'],
      joinTime: json['joinTime']
    );
  }
}
