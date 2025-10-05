import 'package:flutter/material.dart';
import 'package:medi_app/screens/SignUpScreen.dart';
import 'package:medi_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  final TextEditingController productMessageController =
      TextEditingController();
  final TextEditingController productStockController = TextEditingController();
  String? selectedValue;
  late String Product_ID;
  late String Product_PRICE;
  late double Product_TOTAL_AMOUNT;
  late String Product_Category;

  void getProductDetails(BuildContext context) async {
    final vm = Provider.of<MyViewModel>(context, listen: false);

    if (productNameController.text.isEmpty) {
      debugPrint("⚠️ No product selected");
      return;
    }
    await vm.getProductByProductName(productNameController.text);

    if (vm.getProductByNameState.data != null) {
      productStockController.text = vm.getProductByNameState.data!.message.stock
          .toString();
      Product_ID = vm.getProductByNameState.data!.message.productId.toString();
      Product_PRICE = vm.getProductByNameState.data!.message.price.toString();
      Product_Category = vm.getProductByNameState.data!.message.category
          .toString();
      final qty = int.tryParse(productQuantityController.text) ?? 0;

      Product_TOTAL_AMOUNT =
          (vm.getProductByNameState.data!.message.price * qty).toDouble();

      print(Product_TOTAL_AMOUNT);
      print(Product_ID);
    }
  }

  void clearData() {
    productNameController.clear();
    productQuantityController.clear();
    productMessageController.clear();
    productStockController.clear();
  }

  void _calculateOrder(BuildContext context) async {
    final vm = Provider.of<MyViewModel>(context, listen: false);

    Product_ID = vm.getProductByNameState.data!.message.productId.toString();
    Product_PRICE = vm.getProductByNameState.data!.message.price.toString();
    Product_Category = vm.getProductByNameState.data!.message.category
        .toString();
    final qty = int.tryParse(productQuantityController.text) ?? 0;

    Product_TOTAL_AMOUNT = (vm.getProductByNameState.data!.message.price * qty)
        .toDouble();

    print(Product_TOTAL_AMOUNT);
    print(Product_ID);

    await vm.addOrder(
      vm.userId.toString(),
      Product_ID,
      qty,
      double.parse(Product_PRICE),
      Product_TOTAL_AMOUNT,
      productNameController.text,
      vm.userName.toString(),
      productMessageController.text,
      Product_Category,
    );

    clearData();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productQuantityController.dispose();
    productMessageController.dispose();
    productStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text("Add Product", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, child) {
          if (vm.getAllProductState.isLoading || vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (vm.getAllProductState.error != null) {
            return Center(child: Text(vm.getAllProductState.error.toString()));
          }
          final productResponse = vm.getAllProductState.data;
          if (productResponse == null || productResponse.message.isEmpty) {
            return const Center(child: Text("No User Found"));
          }
          final data = productResponse.message;
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: productNameController,
                  readOnly: true, // prevents typing
                  decoration: InputDecoration(
                    hintText: "SELECT PRODUCT",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        // Show dropdown only when icon is clicked
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ListView(
                              children: data.map((option) {
                                return ListTile(
                                  title: Text(option.name),
                                  onTap: () {
                                    setState(() {
                                      productNameController.text = option.name;
                                      getProductDetails(context);
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    // Optional: you can keep this empty to prevent opening dropdown on field tap
                  },
                ),

                SizedBox(height: 20),

                TextField(
                  controller: productStockController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Calculating Stock",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 16,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                CustomTextField(
                  controller: productQuantityController,
                  hintText: "Enter Product Quantity",
                  keyBoardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: productMessageController,
                  hintText: "Enter Message",
                  keyBoardType: TextInputType.text,
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      _calculateOrder(context);
                    },
                    child: Text(
                      "Create Order",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
