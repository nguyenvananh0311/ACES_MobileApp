
class Feedback {
  int employeeId;
  int rating;
  String companyId;
  String feedback;
  String? recommendation;

  Feedback({
    required this.employeeId,
    required this.rating,
    required this.companyId,
    required this.feedback,
    this.recommendation
  });

  // Method to convert a AttendanceBody object to a map
  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'rating': rating,
      'companyId': companyId,
      'feedback': feedback,
      'recommendation': recommendation
    };
  }

  // Method to create a AttendanceBody object from a map
  factory Feedback.fromJson(Map<String, dynamic> map) {
    return Feedback(
        employeeId: map['employeeId'] as int,
        rating: map['rating'] as int,
        companyId: map['companyId'] as String,
        feedback: map['feedback'] as String,
        recommendation: map['recommendation'] as String?,
    );
  }

}
