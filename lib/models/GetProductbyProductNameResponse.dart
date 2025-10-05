class GetProductByProductNameResponse {
  final Product message;
  final int status;

  const GetProductByProductNameResponse({
    required this.message,
    required this.status,
  });

  factory GetProductByProductNameResponse.fromJson(Map<String, dynamic> json) {
    return GetProductByProductNameResponse(
      message: Product.fromJson(json['message'] as Map<String, dynamic>),
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message.toJson(), 'status': status};
  }
}

class Product {
  final String category;
  final String dateOfProductCreation;
  final int id;
  final String name;
  final num price;
  final String productId;
  final int stock;

  const Product({
    required this.category,
    required this.dateOfProductCreation,
    required this.id,
    required this.name,
    required this.price,
    required this.productId,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      category: json['category'] as String,
      dateOfProductCreation: json['date_of_product_creation'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as num,
      productId: json['product_id'] as String,
      stock: json['stock'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'date_of_product_creation': dateOfProductCreation,
      'id': id,
      'name': name,
      'price': price,
      'product_id': productId,
      'stock': stock,
    };
  }
}
