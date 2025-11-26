import 'dart:io';

import 'package:booking_app/services/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../auth/auth_provider/auth_provider.dart';
import '../controllers/user_controller.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_detail_tile.dart';
import '../widgets/edit_text_dialog.dart';
import '../widgets/edit_image_sheet.dart';
import '../../../widgets/custom_snackbar.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);
    final user = ref.read(firebaseAuthProvider).currentUser!;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const .symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Profile", style: AppWidget.normalTextStyle(28)),
              const SizedBox(height: 12),

              ProfileAvatar(
                imageFile: state.imageFile,
                initials: user.email!.substring(0, 2).toUpperCase(),
                onEdit: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => EditImageSheet(
                      onGalleryPick: () async {
                        Navigator.pop(context);
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picked != null) {
                          await controller.updateImage(File(picked.path));
                          showCustomSnackBar(
                            context,
                            "Profile Updated",
                              icon: Icons.check_circle_outline,
                              color: Colors.green
                          );
                        }
                      },
                      onRemove: () async {
                        Navigator.pop(context);
                        await controller.removeImage();
                        showCustomSnackBar(context, "Removed Successfully", icon: Icons.check_circle_outline,
                            color: Colors.green);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),
              Text(
                state.username.isNotEmpty
                    ? state.username
                    : user.email!.substring(0, 5),
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

              ProfileDetailTile(
                leading: Icons.person_2_outlined,
                name: state.username.isNotEmpty
                    ? state.username
                    : user.email!.substring(0, 5),
                trailing: Icons.edit_square,
                onTap: () {
                  final textCtrl = TextEditingController(text: state.username);
                  showDialog(
                    context: context,
                    builder: (_) => EditTextDialog(
                      controller: textCtrl,
                      onUpdate: () async {
                        Navigator.pop(context);
                        await controller.updateText(
                          textCtrl.text,
                          state.location,
                        );
                        showCustomSnackBar(
                          context,
                          "Username Updated Successfully",
                            icon: Icons.check_circle_outline,
                            color: Colors.green
                        );
                      },
                    ),
                  );
                },
              ),

              ProfileDetailTile(leading: Icons.mail, name: user.email!),

              ProfileDetailTile(
                leading: Icons.location_on_rounded,
                name: state.location.isNotEmpty ? state.location : "Location",
                trailing: Icons.edit_square,
                onTap: () {
                  final textCtrl = TextEditingController(text: state.location);
                  showDialog(
                    context: context,
                    builder: (_) => EditTextDialog(
                      controller: textCtrl,
                      onUpdate: () async {
                        Navigator.pop(context);
                        await controller.updateText(
                          state.username,
                          textCtrl.text,
                        );
                        showCustomSnackBar(
                          context,
                          "Location Updated Successfully",
                            icon: Icons.check_circle_outline,
                            color: Colors.green
                        );
                      },
                    ),
                  );
                },
              ),

              ProfileDetailTile(
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

              ProfileDetailTile(
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

              const SizedBox(height: 25),

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
                  icon: const Icon(Icons.logout, size: 22, color: Colors.white),
                  label: Text("Sign Out", style: AppWidget.whiteTextStyle(18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
