import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/provider/auth_provider/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const .symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: .min,
              children: [
                Text("Profile", style: AppWidget.normalTextStyle(28)),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    SizedBox(
                      height: 165,
                      width: 165,
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF86C7FC),
                                Color(0xFF42A5F5),
                                Color(0xFF1E88E5),
                              ],
                              begin: .topLeft,
                              end: .bottomRight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      bottom: 4,
                      left: 4,
                      right: 4,
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipOval(
                          child: Image.asset("images/home.jpg", fit: .cover),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      top: 120,
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: .center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: .circle,
                          border: .all(color: Colors.black26, width: 2),
                        ),
                        child: IconButton(
                          padding: .zero,
                          onPressed: () {},
                          icon: const Icon(Icons.edit, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text("As Morat", style: AppWidget.normalTextStyle(32)),
                const SizedBox(height: 6),
                Text(
                  "morat@gmail.com",
                  style: AppWidget.normalTextStyle(
                    15.5,
                  ).copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 30),
                _detailContainer(
                  leading: Icons.person_2_outlined,
                  name: "As Morat",
                  trailing: Icons.edit_square,
                ),
                _detailContainer(
                  leading: Icons.mail,
                  name: "morat@gmail.com",
                  trailing: Icons.edit_square,
                ),
                _detailContainer(
                  leading: Icons.location_on_rounded,
                  name: "Ashulia Model Town, Savar, dhaka",
                  trailing: Icons.edit_square,
                ),
                _detailContainer(
                  leading: Icons.support_agent,
                  name: "Support",
                  trailing: Icons.arrow_forward_ios,
                ),
                _detailContainer(
                  leading: Icons.question_answer,
                  name: "FAQs",
                  trailing: Icons.arrow_forward_ios,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await ref.read(firebaseAuthProvider).signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    icon: Icon(Icons.logout, size: 22, color: Colors.white),

                    label: Text(
                      "Sign Out",
                      style: AppWidget.whiteTextStyle(18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailContainer({
    required IconData leading,
    required String name,
    IconData? trailing,
  }) {
    return Container(
      width: double.infinity,
      margin: .only(bottom: 12),
      alignment: .center,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: .circular(16),
      ),
      child: ListTile(
        leading: Icon(leading, size: 26, color: Colors.blue.shade900),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        trailing: Icon(trailing, size: 24, color: Colors.blue.shade900),
      ),
    );
  }
}
