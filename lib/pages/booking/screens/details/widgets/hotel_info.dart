import 'package:flutter/material.dart';

import '../../../../../models/category_model.dart';
import '../../../../../services/widgets_supported.dart';

class HotelInfoSection extends StatelessWidget {
  final Category hotel;
  const HotelInfoSection({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          hotel.name,
          style: AppWidget.normalTextStyle(
            26,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          hotel.price,
          style: AppWidget.normalTextStyle(20).copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
