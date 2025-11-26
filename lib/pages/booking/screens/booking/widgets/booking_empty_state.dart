import 'package:flutter/material.dart';

class BookingEmptyState extends StatelessWidget {
  const BookingEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text('No bookings yet',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Text('Start exploring and book your first hotel!',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
