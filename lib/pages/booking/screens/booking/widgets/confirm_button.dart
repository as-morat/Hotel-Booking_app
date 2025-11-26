import 'package:flutter/material.dart';
import 'package:booking_app/services/text_style.dart';

import '../../../model/booking_model.dart';

class ConfirmButton extends StatelessWidget {
  final BookingModel booking;
  final Function(String, String) onConfirm;

  const ConfirmButton({
    super.key,
    required this.booking,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: booking.isConfirmed
            ? null
            : () => onConfirm(booking.id, booking.userId),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: booking.isConfirmed
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          booking.isConfirmed ? "Already Booking" : "Confirm Booking",
          style: AppWidget.whiteTextStyle(18),
        ),
      ),
    );
  }
}
