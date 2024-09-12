
class PublicHoliday {
  final String? id;
  final String name;
  final int month;
  final int day;
  final String? type;
  final bool? isActive;
  final String? companyId;
  final DateTime date;

  PublicHoliday({
    this.id,
    required this.name,
    required this.month,
    required this.day,
    this.type,
    this.isActive,
    this.companyId,
    required this.date
  });


  factory PublicHoliday.fromJson(Map<String, dynamic> json) {
    return PublicHoliday(
      id: json['id'],
      name: json['name'],
      month: json['month'],
      day: json['day'],
      type: json['type'],
      isActive: json['isActive'],
      companyId: json['companyId'],
      date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'month': month,
      'day': day,
      'type': type,
      'isActive': isActive,
      'companyId': companyId,
      'date': date
    };
  }
}
