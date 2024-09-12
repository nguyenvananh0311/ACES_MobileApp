class ApiResponse<T> {
  final bool isSuccess;
  final String? message;
  final int statusCode;
  final T? response;

  ApiResponse({
    required this.isSuccess,
    this.message,
    required this.statusCode,
    this.response,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return ApiResponse<T>(
      isSuccess: json['isSuccess'],
      message: json['message'],
      statusCode: json['statusCode'],
      response: json['response'] != null ? fromJsonT(json['response']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'isSuccess': isSuccess,
      'message': message,
      'statusCode': statusCode,
      'response': response != null ? toJsonT(response as T) : null,
    };
  }
}

