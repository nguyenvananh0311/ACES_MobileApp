class Subscription {
  final int id; // Using String for Guid
  final String token;
  Subscription({
    required this.id,
    required this.token
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
    };
  }
}