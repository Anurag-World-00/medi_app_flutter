class GetUserProfileResponse {
  final Message message;
  final int status;

  const GetUserProfileResponse({required this.message, required this.status});

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetUserProfileResponse(
      message: Message.fromJson(json['message']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'status': status,
  };
}

class Message {
  final String address;
  final int block;
  final String dateOfAccountCreation;
  final String email;
  final int id;
  final int isApproved;
  final String name;
  final String password;
  final String phoneNumber;
  final String pinCode;
  final String userId;

  const Message({
    required this.address,
    required this.block,
    required this.dateOfAccountCreation,
    required this.email,
    required this.id,
    required this.isApproved,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.pinCode,
    required this.userId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      address: json['address'],
      block: json['block'],
      dateOfAccountCreation: json['date_of_account_creation'],
      email: json['email'],
      id: json['id'],
      isApproved: json['isApproved'],
      name: json['name'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      pinCode: json['pin_code'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'block': block,
    'date_of_account_creation': dateOfAccountCreation,
    'email': email,
    'id': id,
    'isApproved': isApproved,
    'name': name,
    'password': password,
    'phone_number': phoneNumber,
    'pin_code': pinCode,
    'user_id': userId,
  };
}
