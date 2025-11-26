import 'package:flutter/material.dart';

class ProfileDetailTile extends StatelessWidget {
  final IconData leading;
  final String name;
  final IconData? trailing;
  final VoidCallback? onTap;

  const ProfileDetailTile({
    super.key,
    required this.leading,
    required this.name,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const .only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: .circular(16),
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
