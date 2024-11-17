class ErrorResponse {
  final String message;
  final dynamic status;

  ErrorResponse({
    required this.message,
    required this.status,
  });

  ErrorResponse copyWith({
    String? message,
    dynamic status,
  }) {
    return ErrorResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map){
    return ErrorResponse(
      message: map['Object'] ?? map['Message'] ?? map['message'] ?? '',
      status: map['status'] ?? map['Status'] ?? '',
    );
  }
}