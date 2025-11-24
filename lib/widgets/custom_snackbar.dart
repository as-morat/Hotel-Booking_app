import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackBar(
    BuildContext context,
    String message, {
      Color? color,
      IconData? icon,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: .floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 1500),
      content: Container(
        padding: const .symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surface,
          borderRadius: .circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .15),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: .min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color != null
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
                size: 22,
              ),
            if (icon != null) const SizedBox(width: 10),

            Flexible(
              child: Text(
                message,
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color != null
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
