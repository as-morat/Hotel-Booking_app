import 'package:flutter/material.dart';
import '../../../model/booking_model.dart';
import 'hotel_image.dart';
import 'hotel_details.dart';

class HotelCard extends StatelessWidget {
  final BookingModel booking;
  final Size size;
  final Function(String, String) onDelete;

  const HotelCard({
    super.key,
    required this.booking,
    required this.size,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.2,
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(offset: Offset(2, 4), blurRadius: 6, color: Colors.black12),
            ],
          ),
          child: Row(
            children: [
              HotelImage(imageUrl: booking.image, size: size),
              Expanded(child: HotelDetails(booking: booking)),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 18,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => onDelete(booking.id, booking.userId),
              icon: const Icon(Icons.delete_outline, color: Colors.white, size: 26),
            ),
          ),
        ),
      ],
    );
  }
}
