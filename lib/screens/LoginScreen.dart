import 'package:flutter/material.dart';
import 'package:medi_app/screens/SignUpScreen.dart';
import 'package:medi_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController(text: "");
  final TextEditingController passwordTextController = TextEditingController(text: "");

  void submit(BuildContext context) async {
    final vm = Provider.of<MyViewModel>(context, listen: false);
    await vm.loginUser(emailTextController.text, passwordTextController.text);
    Navigator.pushNamedAndRemoveUntil(context, Routes.APPROVAL_ROUTES, (Route<dynamic> route) => false,);

    if (vm.loginState.data != null) {
      print("from upper ${vm.loginState.data?.message}");
      _clearFields();
    }
  }

  void _clearFields() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<MyViewModel>(
              builder: (context, vm, child) {
                if (vm.loginState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vm.loginState.error != null) {
                  return Center(
                    child: Text(
                      vm.loginState.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile icon
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          color: Colors.lightBlueAccent,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Email
                      CustomTextField(
                        controller: emailTextController,
                        hintText: "Enter Email",

                        keyBoardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),

                      // Password
                      CustomTextField(
                        controller: passwordTextController,
                        hintText: "Enter Password",

                        keyBoardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => submit(context),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      if (vm.loginState.data != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Login Success: ${vm.loginState.data?.message}",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
