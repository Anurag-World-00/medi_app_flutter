import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medi_app/viewModel/MyViewModel.dart';

class AllStockScreen extends StatefulWidget {
  const AllStockScreen({super.key});

  @override
  State<AllStockScreen> createState() => _AllStockScreenState();
}

class _AllStockScreenState extends State<AllStockScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(5),
          child: Text("All Stock", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, child) {
          if (vm.getUserStockState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.getUserStockState.error != null) {
            return Center(child: Text(vm.getUserStockState.error.toString()));
          }

          final usersResponse = vm.getUserStockState.data;

          if (usersResponse == null || usersResponse.message.isEmpty) {
            return const Center(child: Text("No User Found"));
          }

          final data = usersResponse.message;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final response = data[index];

              return Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${response.productName}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(thickness: 2, color: Colors.lightBlueAccent),
                          const SizedBox(height: 6),
                          Text(
                            "Category : ${response.category}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Price : ${response.price}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Price : ${response.stock}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
