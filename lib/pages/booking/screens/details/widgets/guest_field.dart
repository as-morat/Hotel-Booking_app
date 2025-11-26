import 'package:flutter/material.dart';

class GuestField extends StatelessWidget {
  final TextEditingController controller;

  const GuestField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const .symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(80),
        borderRadius: .circular(14),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: .number,
          decoration: const InputDecoration(
            hintText: "Guest numbers...",
            border: .none,
            isCollapsed: true,
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
