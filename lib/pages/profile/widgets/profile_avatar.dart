import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class ProfileAvatar extends StatelessWidget {
  final File? imageFile;
  final String initials;
  final VoidCallback onEdit;

  const ProfileAvatar({
    super.key,
    required this.imageFile,
    required this.initials,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  begin: .topLeft,
                  end: .bottomRight,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          bottom: 4,
          right: 4,
          child: SizedBox(
            height: 150,
            width: 150,
            child: ClipOval(
              child: imageFile == null
                  ? Container(
                      color: Colors.grey.shade400,
                      alignment: .center,
                      child: Text(
                        initials,
                        style: GoogleFonts.playfair(
                          fontSize: 85,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : Image.file(imageFile!, fit: .cover),
            ),
          ),
        ),
        Positioned(
          left: 120,
          top: 120,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              height: 35,
              width: 35,
              alignment: .center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: .circle,
                border: .all(color: Colors.blueGrey, width: 2),
              ),
              child: const Icon(Icons.edit, size: 22),
            ),
          ),
        ),
      ],
    );
  }
}
