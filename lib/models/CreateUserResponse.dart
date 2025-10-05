class CreateUserResponse {
  final String message;
  final int status;

  CreateUserResponse({required this.message, required this.status});

  // Copy with method
  CreateUserResponse copyWith({String? message, int? status}) {
    return CreateUserResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  // JSON deserialization
  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
      message: json['message'] as String,
      status: json['status'] is int
          ? json['status'] as int
          : (json['status'] as num).toInt(),
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status};
  }

  @override
  String toString() => 'CreateUserResponse(message: $message, status: $status)';
}
