class LoginResponse {
  final Message message;
  final int status;

  LoginResponse({required this.message, required this.status});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message.toJson(), 'status': status};
  }

  LoginResponse copyWith({Message? message, int? status}) {
    return LoginResponse(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}

class Message {
  final String userId;
  final String userName;

  Message({required this.userId, required this.userName});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName};
  }

  Message copyWith({String? userId, String? userName}) {
    return Message(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }
}
