import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class EditImageSheet extends StatelessWidget {
  final VoidCallback onGalleryPick;
  final VoidCallback onRemove;

  const EditImageSheet({
    super.key,
    required this.onGalleryPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const .vertical(top: .circular(28)),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: .circular(20),
            ),
          ),
          const SizedBox(height: 18),

          Text(
            "Profile Photo",
            style: AppWidget.normalTextStyle(22),
          ),

          const SizedBox(height: 8),

          Text(
            "Choose a new photo or remove the current one",
            style: AppWidget.normalTextStyle(16).copyWith(color: Colors.black45),
            textAlign: .center,
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              _buildOption(
                context,
                Icons.image_outlined,
                "Choose\nfrom Gallery",
                onGalleryPick,
              ),
              _buildOption(
                context,
                Icons.hide_image,
                "Remove\nPhoto",
                onRemove,
              ),
            ],
          ),

          const SizedBox(height: 22),
        ],
      ),
    );
  }

  Widget _buildOption(
      BuildContext context,
      IconData icon,
      String label,
      VoidCallback action,
      ) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: Icon(icon, size: 40),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppWidget.normalTextStyle(16).copyWith(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
