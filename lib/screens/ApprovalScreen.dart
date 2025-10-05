import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medi_app/viewModel/MyViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MyViewModel>(
        builder: (context, vm, _) {
          final state = vm.getUserProfileState;
          if (state.isLoading || vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            );
          }

          final response = state.data;
          if (response == null || response.message == null) {
            return Center(child: Text("No profile data found"));
          }

          final user = response.message;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/hourglass.gif", height: 90, width: 90),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (user.isApproved == 1) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.BOTTOM_ROUTES,
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      final vm = context.read<MyViewModel>();

                      vm.getUserProfile(vm.userId.toString());
                    }
                  },
                  child: const Text(
                    "Check Approval",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
