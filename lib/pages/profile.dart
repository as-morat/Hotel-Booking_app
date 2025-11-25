import 'dart:io';
import 'package:booking_app/services/local_storage_service.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:booking_app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../database/user_dao.dart';
import '../services/provider/auth_provider/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    final data = await UserDao().getProfile(user.uid);

    if (data != null) {
      setState(() {
        imageFile = data['imagePath'] != null && data['imagePath'] != ""
            ? File(data['imagePath'])
            : null;
        usernameController.text = data['username'] ?? '';
        locationController.text = data['location'] ?? '';
      });
    }
  }

  Future<void> pickImage(String userID) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final savedPath = await StorageService.saveProfileImage(
        File(picked.path),
        userID,
      );

      await UserDao().saveProfile(
        userId: userID,
        username: usernameController.text,
        location: locationController.text,
        imagePath: savedPath,
      );

      setState(() {
        imageFile = File(savedPath);
      });
      if (mounted) {
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          "Profile Update Successfully",
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
      }
    }
  }

  void editImage(String userID) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const .all(50),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 5,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => pickImage(userID),
                      icon: Icon(
                        Icons.image,
                        size: 56,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Gallery", style: AppWidget.normalTextStyle(24)),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 5,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (imageFile != null) {
                          await StorageService.deleteProfileImage(imageFile!);
                        }

                        await UserDao().saveProfile(
                          userId: userID,
                          username: usernameController.text.trim(),
                          location: locationController.text.trim(),
                          imagePath: "",
                        );

                        setState(() {
                          imageFile = null;
                        });
                        if (mounted) {
                          Navigator.pop(context);
                          showCustomSnackBar(
                            context,
                            "Profile Update Successfully",
                            icon: Icons.check_circle_outline,
                            color: Colors.green,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.hide_image,
                        size: 56,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Remove", style: AppWidget.normalTextStyle(24)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void editText(
    BuildContext context,
    TextEditingController controller,
    String field,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Info"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Write content..."),
            style: const TextStyle(letterSpacing: 0.5, fontSize: 15.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: () async {
                Navigator.pop(context);

                final user = ref.read(firebaseAuthProvider).currentUser!;
                final data = await UserDao().getProfile(user.uid);

                final username = usernameController.text.trim().isNotEmpty
                    ? usernameController.text.trim()
                    : data?['username'] ?? "";

                final location = locationController.text.trim().isNotEmpty
                    ? locationController.text.trim()
                    : data?['location'] ?? "";

                final imagePath = imageFile != null
                    ? imageFile!.path
                    : data?['imagePath'] ?? "";

                await UserDao().saveProfile(
                  userId: user.uid,
                  username: username,
                  location: location,
                  imagePath: imagePath,
                );

                showCustomSnackBar(
                  context,
                  "Update Successfully",
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                );

                setState(() {});
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(firebaseAuthProvider).currentUser!;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF86C7FC),
                                Color(0xFF42A5F5),
                                Color(0xFF1E88E5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                          child: imageFile == null
                              ? Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey.shade400,
                                  child: Text(
                                    user.email!.substring(0, 2).toUpperCase(),
                                    style: GoogleFonts.playfair(
                                      fontSize: 85,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                )
                              : Image.file(imageFile!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      top: 120,
                      child: Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => editImage(user.uid),
                          icon: const Icon(Icons.edit, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  usernameController.text.isNotEmpty
                      ? usernameController.text
                      : user.email.toString().substring(0, 5),
                  style: AppWidget.normalTextStyle(32),
                ),
                const SizedBox(height: 6),
                Text(
                  user.email.toString(),
                  style: AppWidget.normalTextStyle(
                    15.5,
                  ).copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 30),
                _detailContainer(
                  leading: Icons.person_2_outlined,
                  name: usernameController.text.isNotEmpty
                      ? usernameController.text
                      : user.email.toString().substring(0, 5),
                  trailing: Icons.edit_square,
                  onTap: () =>
                      editText(context, usernameController, "username"),
                ),
                _detailContainer(
                  leading: Icons.mail,
                  name: user.email.toString(),
                  trailing: Icons.edit_square,
                  onTap: () => showCustomSnackBar(
                    context,
                    "Email editing needs Firebase update",
                    icon: Icons.warning_amber,
                    color: Colors.amber,
                  ),
                ),
                _detailContainer(
                  leading: Icons.location_on_rounded,
                  name: locationController.text.isNotEmpty
                      ? locationController.text
                      : "Location",
                  trailing: Icons.edit_square,
                  onTap: () =>
                      editText(context, locationController, "location"),
                ),
                _detailContainer(
                  leading: Icons.support_agent,
                  name: "Support",
                  trailing: Icons.arrow_forward_ios,
                  onTap: () {
                    showCustomSnackBar(
                      context,
                      "Under Maintenance",
                      icon: Icons.warning_amber,
                      color: Colors.amber,
                    );
                  },
                ),
                _detailContainer(
                  leading: Icons.question_answer,
                  name: "FAQs",
                  trailing: Icons.arrow_forward_ios,
                  onTap: () {
                    showCustomSnackBar(
                      context,
                      "Under Maintenance",
                      icon: Icons.warning_amber,
                      color: Colors.amber,
                    );
                  },
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                    icon: const Icon(
                      Icons.logout,
                      size: 22,
                      color: Colors.white,
                    ),
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
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(leading, size: 26, color: Colors.blue.shade900),
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          trailing: Icon(trailing, size: 24, color: Colors.blue.shade900),
        ),
      ),
    );
  }
}
