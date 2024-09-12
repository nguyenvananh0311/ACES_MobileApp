class MultiApiResponse<T> {
  final bool isSuccess;
  final int total;
  final int index;
  final int pageSize;
  final String? message;
  final int statusCode;
  final List<T>? response;

  MultiApiResponse({
    required this.isSuccess,
    required this.total,
    required this.index,
    required this.pageSize,
    this.message,
    required this.statusCode,
    this.response,
  });

  factory MultiApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return MultiApiResponse<T>(
      isSuccess: json['isSuccess'],
      total: json['total'],
      index: json['index'],
      pageSize: json['pageSize'],
      message: json['message']  as String,
      statusCode: json['statusCode'],
      response: json['response'] != null ? List<T>.from(json['response'].map(fromJsonT)) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'isSuccess': isSuccess,
      'total': total,
      'index': index,
      'pageSize': pageSize,
      'message': message,
      'statusCode': statusCode,
      'response': response?.map(toJsonT).toList(),
    };
  }
}
