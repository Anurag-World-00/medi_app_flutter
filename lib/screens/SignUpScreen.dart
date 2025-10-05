import 'package:flutter/material.dart';
import 'package:medi_app/main.dart';
import 'package:provider/provider.dart';
import '../viewModel/MyViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    final vm = Provider.of<MyViewModel>(context, listen: false);

    await vm.createUser(
      nameController.text.trim(),
      addressController.text.trim(),
      passwordController.text.trim(),
      emailController.text.trim(),
      phoneNumberController.text.trim(),
      pinCodeController.text.trim(),
    );

    if (vm.createState.data != null) {
      print(vm.createState.data?.message);
      _clearFields();
      Navigator.pushNamedAndRemoveUntil(context, Routes.APPROVAL_ROUTES, (Route<dynamic> route) => false,);
    } else if (vm.createState.error != null) {
      print(vm.createState.error);
    }
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    addressController.clear();
    phoneNumberController.clear();
    pinCodeController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<MyViewModel>(
              builder: (context, vm, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile icon
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.lightBlueAccent.shade100,
                        child: const Icon(
                          Icons.person,
                          color: Colors.lightBlueAccent,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Using your own CustomTextField
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Enter Name',

                        keyBoardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Enter Email',

                        keyBoardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Enter Password',

                        keyBoardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: addressController,
                        hintText: 'Enter Address',

                        keyBoardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: phoneNumberController,
                        hintText: 'Enter Phone Number',

                        keyBoardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: pinCodeController,
                        hintText: 'Enter Pin Code',

                        keyBoardType: TextInputType.number,
                      ),

                      const SizedBox(height: 20),

                      // Sign Up button
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
                          onPressed: () => _submit(context),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Already have an account
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, Routes.LOGIN_ROUTES),
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black54),
                            children: [
                              TextSpan(
                                text: "Log in",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      if (vm.createState.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            vm.createState.error ?? 'Something went wrong',
                            style: const TextStyle(color: Colors.red),
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


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return
      TextField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
      ),
    );
  }
}
