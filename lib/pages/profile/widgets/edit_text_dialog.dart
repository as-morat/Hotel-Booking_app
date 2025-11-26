import 'package:flutter/material.dart';

class EditTextDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onUpdate;

  const EditTextDialog({
    super.key,
    required this.controller,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Info"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Write content..."),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: onUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text("Update"),
        ),
      ],
    );
  }
}
