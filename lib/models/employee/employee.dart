
class Employee {
  int id;
  String image;

  Employee({
    required this.id,
    required this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
