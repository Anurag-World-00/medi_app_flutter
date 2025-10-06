class GetAllProductsResponse {
  final List<Product> message;
  final int status;

  const GetAllProductsResponse({required this.message, required this.status});

  factory GetAllProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllProductsResponse(
      message: (json['message'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}

class Product {
  final String category;
  final String dateOfProductCreation;
  final int id;
  final String name;
  final double price;
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
    // Helper function to safely parse a value into a double
    double _safeToDouble(dynamic value) {
      if (value is num) {
        return value.toDouble();
      } else if (value is String) {
        // Use tryParse to convert strings like "10.99" or "10"
        return double.tryParse(value) ?? 0.0; // Default to 0.0 if parsing fails
      }
      return 0.0; // Default if neither num nor String
    }

    // You should also use the int-safe helper for id and stock
    // to cover both of your reported errors.
    int _safeToInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return Product(
      category: json['category'] as String,
      dateOfProductCreation: json['date_of_product_creation'] as String,
      // Use safe parsing for 'id' and 'stock' (which expect int)
      id: _safeToInt(json['id']),
      name: json['name'] as String,
      // Apply the robust parsing for 'price' (which expects double/num)
      price: _safeToDouble(json['price']),

      productId: json['product_id'] as String,
      stock: _safeToInt(json['stock']),
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
