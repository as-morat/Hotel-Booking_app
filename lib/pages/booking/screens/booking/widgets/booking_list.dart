import 'package:flutter/material.dart';

import '../../../model/booking_model.dart';
import 'booking_card.dart';

class BookingList extends StatelessWidget {
  final List<BookingModel> bookings;
  final Function(String, String) onConfirm;
  final Function(String, String) onDelete;

  const BookingList({
    super.key,
    required this.bookings,
    required this.onConfirm,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: bookings.map((booking) {
          return BookingCard(
            booking: booking,
            size: size,
            onConfirm: onConfirm,
            onDelete: onDelete,
          );
        }).toList(),
      ),
    );
  }
}
