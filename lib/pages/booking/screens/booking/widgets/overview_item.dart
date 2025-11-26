import 'package:flutter/material.dart';
import 'package:booking_app/services/text_style.dart';

class OverviewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const OverviewItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900, size: 30),
      title: Text(title, style: AppWidget.normalTextStyle(18)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.check_circle, color: Colors.blueGrey),
    );
  }
}
