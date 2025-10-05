import 'package:flutter/cupertino.dart';
import 'package:medi_app/common/UiState.dart';
import 'package:medi_app/models/CreateUserResponse.dart';
import 'package:medi_app/models/GetAllProductsResponse.dart';
import 'package:medi_app/models/GetProductbyProductNameResponse.dart';
import 'package:medi_app/models/GetUserProfileResponse.dart';
import 'package:medi_app/models/GetUserStockResponse.dart';
import 'package:medi_app/models/LoginResponse.dart';
import 'package:medi_app/repo/Repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyViewModel extends ChangeNotifier {
  final _repo = Repo();

  UiState<CreateUserResponse> _createState = UiState.loading();

  UiState<CreateUserResponse> get createState => _createState;

  UiState<LoginResponse> _loginState = UiState.idle();

  UiState<LoginResponse> get loginState => _loginState;

  UiState<GetAllProductsResponse> _getAllProductState = UiState.idle();

  UiState<GetAllProductsResponse> get getAllProductState => _getAllProductState;

  UiState<GetProductByProductNameResponse> _getProductByNameState =
      UiState.idle();

  UiState<GetProductByProductNameResponse> get getProductByNameState =>
      _getProductByNameState;

  UiState<CreateUserResponse> _addOrderState = UiState.idle();

  UiState<CreateUserResponse> get addOrderState => _addOrderState;

  UiState<GetUserStockResponse> _getUserStockState = UiState.idle();

  UiState<GetUserStockResponse> get getUserStockState => _getUserStockState;

  UiState<GetUserProfileResponse> _getUserProfileState = UiState.idle();

  UiState<GetUserProfileResponse> get getUserProfileState =>
      _getUserProfileState;

  String? userId;
  String? userName;
  bool _isLoading = true;
  bool get isLoading => _isLoading;


  MyViewModel() {
    getAllProducts();
    _init();

  }
  Future<void> _init() async {

    _isLoading = true;
    notifyListeners();

    final sf = await SharedPreferences.getInstance();


    userId = sf.getString('userId');
    userName = sf.getString('userName');
    if(userId!=null){
     getUserProfile(userId!);
     getUserStock(userId!);
    }

    _isLoading = false;


    notifyListeners();
  }

  Future<void> createUser(
    String name,
    String address,
    String password,
    String email,
    String phoneNumber,
    String pinCode,
  ) async {
    _createState = UiState.loading();
    notifyListeners();
    try {
      final response = await _repo.createUser(
        name,
        address,
        password,
        email,
        phoneNumber,
        pinCode,
      );

      _createState = UiState.success(response);
      addUserDetails(response.message, name);
      notifyListeners();
    } catch (e) {
      _createState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    _loginState = UiState.loading();
    notifyListeners();

    try {
      final response = await _repo.loginUser(email, password);
      _loginState = UiState.success(response);
      addUserDetails(response.message.userId, response.message.userName);

      notifyListeners(); // ✅ important
    } catch (e) {
      _loginState = UiState.error(e.toString());
      notifyListeners(); // ✅ important
    }
  }

  Future<void> getAllProducts() async {
    _getAllProductState = UiState.loading();
    notifyListeners();
    try {
      final response = await _repo.getAllproducts();
      _getAllProductState = UiState.success(response);
      notifyListeners();
    } catch (e) {
      _getAllProductState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getProductByProductName(String productName) async {
    _getProductByNameState = UiState.idle();
    notifyListeners();
    try {
      final response = await _repo.getProductByProductName(productName);
      _getProductByNameState = UiState.success(response);
      notifyListeners();
    } catch (e) {
      _getProductByNameState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> addOrder(
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
    _addOrderState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.addOrder(
        userId,
        productId,
        quantity,
        price,
        totalAmount,
        productName,
        userName,
        message,
        category,
      );
      _addOrderState = UiState.success(data);
    } catch (e) {
      _addOrderState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getUserStock(String userId) async {
    _getUserStockState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.getAllStock(userId);
      _getUserStockState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getUserStockState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> getUserProfile(String userId) async {
    _getUserProfileState = UiState.loading();
    notifyListeners();

    try {
      final data = await _repo.getUserProfile(userId);
      _getUserProfileState = UiState.success(data);
      notifyListeners();
    } catch (e) {
      _getUserProfileState = UiState.error(e.toString());
      notifyListeners();
    }
  }

  void addUserDetails(String userId, String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    sf.setString("userId", userId);
    sf.setString("userName", userName);

    print(sf.getString("userId"));
    print(sf.getString("userName"));
  }

  Future<void> getUserId() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    if (sf.getString('userId') != null) {
      userId = sf.getString("userId");
    }
  }

  Future<void> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    if (sf.getString('userName') != null) {
      userName = sf.getString("userName");
    }
  }


  void signOut()async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.clear();

  }

}
