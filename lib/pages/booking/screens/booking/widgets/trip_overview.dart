import 'package:flutter/material.dart';
import '../../../model/booking_model.dart';
import 'overview_item.dart';

class TripOverview extends StatelessWidget {
  final BookingModel booking;

  const TripOverview({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.black12),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          OverviewItem(
              icon: Icons.date_range,
              title: "Check-In",
              subtitle: booking.checkIn),
          OverviewItem(
              icon: Icons.date_range,
              title: "Check-Out",
              subtitle: booking.checkOut),
          OverviewItem(
              icon: Icons.person_2_outlined,
              title: "Guests",
              subtitle: booking.guest),
        ],
      ),
    );
  }
}
