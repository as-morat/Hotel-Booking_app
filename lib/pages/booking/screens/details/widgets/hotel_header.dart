import 'package:flutter/material.dart';

import '../../../../../models/category_model.dart';

class HotelHeader extends StatelessWidget {
  final Category hotel;
  const HotelHeader({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: hotel.id,
          child: ClipRRect(
            borderRadius: const .only(
              bottomLeft: .circular(60),
              bottomRight: .circular(60),
            ),
            child: Image.network(
              hotel.image,
              height: 350,
              width: .infinity,
              fit: .cover,
            ),
          ),
        ),
        Positioned(
          top: 48,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: .circular(50),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
