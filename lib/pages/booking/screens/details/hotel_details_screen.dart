import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/pages/booking/screens/details/widgets/booking_form.dart';
import 'package:booking_app/pages/booking/screens/details/widgets/hotel_header.dart';
import 'package:booking_app/pages/booking/screens/details/widgets/hotel_info.dart';
import 'package:booking_app/pages/booking/screens/details/widgets/offer_item.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:booking_app/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../controller/booking_controller.dart';
import '../../model/booking_model.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final Category hotel;
  const DetailsScreen({super.key, required this.hotel});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late TextEditingController guestController;
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  final user = FirebaseAuth.instance.currentUser!;

  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  void initState() {
    super.initState();
    guestController = TextEditingController();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
  }

  @override
  void dispose() {
    guestController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  Future<void> pickDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isCheckIn ? checkInDate : checkOutDate) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          checkInController.text = DateFormat("dd MMMM yyyy").format(picked);
        } else {
          checkOutDate = picked;
          checkOutController.text = DateFormat("dd MMMM yyyy").format(picked);
        }
      });
    }
  }

  void onBookPressed(Category hotel) async {
    if (guestController.text.isEmpty ||
        checkInController.text.isEmpty ||
        checkOutController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final booking = BookingModel(
      id: Uuid().v4(),
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

    if (mounted) {
      showCustomSnackBar(
        context,
        "Booking Saved! Confirm anytime.",
        icon: Icons.check_circle_outline,
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotelHeader(hotel: hotel),
            const SizedBox(height: 20),

            Padding(
              padding: const .symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  HotelInfoSection(hotel: hotel),

                  const Divider(thickness: 3),

                  const SizedBox(height: 10),
                  Text(
                    "What this place offers",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),

                  if (hotel.wifi) OfferItem(icon: Icons.wifi, title: "Wi-Fi"),
                  if (hotel.hdtv) OfferItem(icon: Icons.tv, title: "HDTV"),
                  if (hotel.kitchen)
                    OfferItem(icon: Icons.kitchen, title: "Kitchen"),
                  if (hotel.bathroom)
                    OfferItem(icon: Icons.bathtub_outlined, title: "Bathroom"),

                  const Divider(thickness: 3),
                  const SizedBox(height: 10),

                  Text(
                    "About this place",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    hotel.details,
                    style: AppWidget.normalTextStyle(16).copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 20),

                  BookingFormCard(
                    hotel: hotel,
                    size: size,
                    guestController: guestController,
                    checkInController: checkInController,
                    checkOutController: checkOutController,
                    onPickCheckIn: () => pickDate(true),
                    onPickCheckOut: () => pickDate(false),
                  ),

                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
