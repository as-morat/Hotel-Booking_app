import 'package:booking_app/pages/booking/controller/booking_controller.dart';
import 'package:booking_app/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/booking_appbar.dart';
import 'widgets/booking_empty_state.dart';
import 'widgets/booking_list.dart';

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    Future.microtask(
          () => ref.read(bookingControllerProvider.notifier).loadBookings(userId),
    );
  }

  Future<void> _confirm(String bookingId, String id) async {
    try {
      await ref.read(bookingControllerProvider.notifier).confirm(bookingId, id);
      if (mounted) {
        showCustomSnackBar(
          context,
          "Booking Confirmed Successfully!",
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        showCustomSnackBar(
          context,
          "Failed to confirm booking",
          icon: Icons.cancel_outlined,
          color: Colors.red,
        );
      }
    }
  }

  Future<void> _delete(String id, String userId) async {
    try {
      await ref.read(bookingControllerProvider.notifier).delete(id, userId);
      if (mounted) {
        showCustomSnackBar(
          context,
          "Booking Deleted Successfully!",
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        showCustomSnackBar(
          context,
          "Failed to Delete booking",
          icon: Icons.cancel_outlined,
          color: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingControllerProvider);
    final bookings = bookingState.bookings;
    final isLoading = bookingState.loading;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const BookingAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : bookings.isEmpty
            ? const BookingEmptyState()
            : BookingList(
          bookings: bookings,
          onConfirm: _confirm,
          onDelete: _delete,
        ),
      ),
    );
  }
}
