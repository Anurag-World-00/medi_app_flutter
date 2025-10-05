import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../viewModel/MyViewModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Consumer<MyViewModel>(
        builder: (context, vm, _) {
          final state = vm.getUserProfileState;

          if (state.isLoading || vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
            return const Center(child: Text("No profile data found"));
          }

          final user = response.message;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.blueGrey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 28,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 👤 Profile Avatar
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.lightBlueAccent.withOpacity(
                              0.15,
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Colors.lightBlueAccent,
                              size: 55,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 🧍 Name
                          Text(
                            user.name ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2E3A59),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Subtitle
                          const Text(
                            "Personal Details",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // 📨 Details
                          _buildDetailRow("📧 Email", user.email ?? "-"),
                          _buildDetailRow(
                            "📱 Phone Number",
                            user.phoneNumber ?? "-",
                          ),
                          _buildDetailRow("🏠 Address", user.address ?? "-"),
                          _buildDetailRow("📮 Pin Code", user.pinCode ?? "-"),

                          const SizedBox(height: 25),

                          // 🔄 Refresh Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                vm.getUserProfile(vm.userId.toString());
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Refresh Data",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // 🚪 Sign Out
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                vm.signOut();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.CREATE_ROUTES,
                                  (Route<dynamic> route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent
                                    .withOpacity(0.8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🧾 Helper widget for each field
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F9FF),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                color: Color(0xFF6E7B8B),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.5,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
