import 'package:flutter/material.dart';

import '../../../../../services/text_style.dart';

class OfferItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const OfferItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            title,
            style: AppWidget.normalTextStyle(
              20,
            ).copyWith(fontWeight: FontWeight.w600, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
