import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medi_app/common/Constants.dart';
import 'package:medi_app/models/CreateUserResponse.dart';
import 'package:medi_app/models/GetAllProductsResponse.dart';
import 'package:medi_app/models/GetProductbyProductNameResponse.dart';
import 'package:medi_app/models/GetUserProfileResponse.dart';
import 'package:medi_app/models/GetUserStockResponse.dart';
import 'package:medi_app/models/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repo {
  Future<CreateUserResponse> createUser(
    String name,
    String address,
    String password,
    String email,
    String phoneNumber,
    String pinCode,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$CREATE_USER_ENDPOINT"),
        body: {
          "name": name,
          "address": address,
          "password": password,
          "email": email,
          "phone_number": phoneNumber,
          "pin_code": pinCode,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return CreateUserResponse.fromJson(json);
      } else {
        throw Exception("Nothing found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$LOGIN_ENDOINT"),
        body: {"password": password, "email": email},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return LoginResponse.fromJson(json);
      } else {
        throw Exception("Nothing found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetAllProductsResponse> getAllproducts() async {
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL$GET_ALLPRODUCTS_ENDPOINT"),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GetAllProductsResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetProductByProductNameResponse> getProductByProductName(
    String productName,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_PRODUCTBYPRODUCTNAME_ENDPOINT"),
        body: {"product_name": productName},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GetProductByProductNameResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CreateUserResponse> addOrder(
    String userId,
    String productId,
    int quantity,
    double price,
    double totalAmount,
    String productName,
    String userName,
    String message,
    String category,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$ADD_ORDER_ENDPOINT"),

        body: {
          "userId": userId,
          "product_id": productId,
          "quantity": quantity.toString(),
          "price": price.toString(),
          "total_amount": totalAmount.toString(),
          "product_name": productName,
          "user_name": userName,
          "message": message,
          "category": category,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return CreateUserResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetUserStockResponse> getAllStock(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_USERSTOCK_ENDPOINT"),

        body: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return GetUserStockResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        throw Exception("Not found");
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GetUserProfileResponse> getUserProfile(String userID) async {
    try {
      final response = await http.post(
        Uri.parse("$BASE_URL$GET_USERPROFILE_ENDPOINT"),

        body: {"user_id": userID},
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GetUserProfileResponse.fromJson(json);
      } else if (response.statusCode == 400) {
        print("Not found");
        throw Exception("Not found");
      } else {
        print("${response.statusCode}");
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }





}
