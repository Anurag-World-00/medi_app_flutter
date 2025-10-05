class GetUserStockResponse {
  GetUserStockResponse({required this.message, required this.status});

  factory GetUserStockResponse.fromJson(Map<String, dynamic> json) {
    return GetUserStockResponse(
      message: json['message'] != null
          ? List<Message>.from(json['message'].map((x) => Message.fromJson(x)))
          : [],
      status: json['status'] ?? 0,
    );
  }

  List<Message> message;
  int status;

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
    "status": status,
  };
}

class Message {
  Message({
    required this.category,
    required this.id,
    required this.price,
    required this.productId,
    required this.productName,
    required this.stock,
    required this.stockId,
    required this.userId,
    required this.userName,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    category: json['category'] ?? '',
    id: json['id'] ?? 0,
    price: (json['price'] ?? 0).toDouble(),
    productId: json['product_id'] ?? '',
    productName: json['product_name'] ?? '',
    stock: json['stock'] ?? 0,
    stockId: json['stock_id'] ?? '',
    userId: json['user_id'] ?? '',
    userName: json['user_name'] ?? '',
  );

  String category;
  int id;
  double price;
  String productId;
  String productName;
  int stock;
  String stockId;
  String userId;
  String userName;

  Map<String, dynamic> toJson() => {
    "category": category,
    "id": id,
    "price": price,
    "product_id": productId,
    "product_name": productName,
    "stock": stock,
    "stock_id": stockId,
    "user_id": userId,
    "user_name": userName,
  };
}
