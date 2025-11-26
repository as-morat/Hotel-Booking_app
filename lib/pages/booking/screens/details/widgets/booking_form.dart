import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../models/category_model.dart';
import '../../../../../services/widgets_supported.dart';
import '../../../controller/booking_controller.dart';
import '../../../model/booking_model.dart';
import 'date_picker.dart';
import 'guest_field.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../widgets/custom_snackbar.dart';
import 'primary_button.dart';

class BookingFormCard extends ConsumerWidget {
  final Category hotel;
  final Size size;
  final TextEditingController guestController;
  final TextEditingController checkInController;
  final TextEditingController checkOutController;
  final VoidCallback onPickCheckIn;
  final VoidCallback onPickCheckOut;

  const BookingFormCard({
    super.key,
    required this.hotel,
    required this.size,
    required this.guestController,
    required this.checkInController,
    required this.checkOutController,
    required this.onPickCheckIn,
    required this.onPickCheckOut,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser!;

    void handleBooking() async {
      if (guestController.text.isEmpty ||
          checkInController.text.isEmpty ||
          checkOutController.text.isEmpty) {
        showCustomSnackBar(
          context,
          "Please filled all the fields",
          icon: Icons.warning_amber,
          color: Colors.amber,
        );
        return;
      }

      final booking = BookingModel(
        id: const Uuid().v4(),
        userId: user.uid,
        title: hotel.name,
        price: hotel.price,
        location: hotel.location,
        image: hotel.image,
        guest: guestController.text,
        checkIn: checkInController.text,
        checkOut: checkOutController.text,
        isConfirmed: false,
      );

      await ref.read(bookingControllerProvider.notifier).addBooking(booking);

      if (context.mounted) {
        showCustomSnackBar(
          context,
          "Booking Saved! Confirm anytime.",
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
        Navigator.pop(context);
      }
    }

    return Container(
      width: size.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.black26),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.discount,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                hotel.discount,
                style: AppWidget.normalTextStyle(
                  22,
                ).copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text("Check-in Date", style: AppWidget.normalTextStyle(18)),
          const SizedBox(height: 10),
          DatePickerField(controller: checkInController, onTap: onPickCheckIn),
          const SizedBox(height: 15),
          Text("Check-out Date", style: AppWidget.normalTextStyle(18)),
          const SizedBox(height: 10),
          DatePickerField(
            controller: checkOutController,
            onTap: onPickCheckOut,
          ),
          const SizedBox(height: 15),
          Text("Guests", style: AppWidget.normalTextStyle(18)),
          const SizedBox(height: 10),
          GuestField(controller: guestController),
          const SizedBox(height: 20),
          PrimaryButton(title: "Book Now", onPressed: handleBooking),
        ],
      ),
    );
  }
}
