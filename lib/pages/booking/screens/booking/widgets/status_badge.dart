import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final bool isConfirmed;

  const StatusBadge({super.key, required this.isConfirmed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isConfirmed ? Colors.green : Colors.transparent,
        border: Border.all(
          color: isConfirmed ? Colors.green : Colors.blueGrey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        isConfirmed ? "Booked" : "Pending",
        style: TextStyle(
          color: isConfirmed ? Colors.white : Colors.blueGrey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
