class Notification {
  final String id; // Using String for Guid
  final DateTime createdTime;
  final String link;
  final int createdById;
  final String createdBy;
  final String name;
  final String description;
  final String event;

  Notification({
    required this.id,
    required this.createdTime,
    required this.link,
    required this.createdById,
    required this.createdBy,
    required this.name,
    required this.description,
    required this.event
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        id: json['id'],
        description: json['description'],
        createdBy: json['createdBy'],
        createdById: json['createdById'],
        createdTime: DateTime.parse(json['createdTime'] as String),
        link: json['link'],
        name: json['name'],
        event: json['event']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'createdBy': createdBy,
      'createdById': createdById,
      'createdTime': createdTime.toIso8601String(),
      'link': link,
      'name': name,
      'event': event
    };
  }
}