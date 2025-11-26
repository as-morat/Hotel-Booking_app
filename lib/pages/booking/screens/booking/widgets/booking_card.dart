import 'package:flutter/material.dart';
import '../../../model/booking_model.dart';
import 'hotel_card.dart';
import 'trip_overview.dart';
import 'confirm_button.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final Size size;
  final Function(String, String) onConfirm;
  final Function(String, String) onDelete;

  const BookingCard({
    super.key,
    required this.booking,
    required this.size,
    required this.onConfirm,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HotelCard(
          booking: booking,
          size: size,
          onDelete: onDelete,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("Trip Overview",
              style: Theme.of(context).textTheme.titleMedium),
        ),
        TripOverview(booking: booking),
        const SizedBox(height: 30),
        ConfirmButton(
          booking: booking,
          onConfirm: onConfirm,
        ),
        const SizedBox(height: 50),
        const Divider(thickness: 5),
      ],
    );
  }
}
