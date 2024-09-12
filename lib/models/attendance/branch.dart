class Branch {
  final String id;
  final String name;
  final bool isDeleted;
  final String? address;
  final double latitude;
  final double longitude;
  final int distance;

  Branch({
    required this.id,
    required this.name,
    required this.isDeleted,
    required this.latitude,
    required this.longitude,
    this.address,
    this.distance = 100,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      isDeleted: json['isDeleted'],
      address: json['address'],
      latitude: json['latitude'] == null ? 0 : double.parse(json['latitude'].toString()),
      longitude: json['longitude'] == null ? 0 : double.parse(json['longitude'].toString()),
      distance: json['distance'] ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isDeleted': isDeleted,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}
