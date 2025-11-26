import 'package:flutter/material.dart';

class HotelImage extends StatelessWidget {
  final String imageUrl;
  final Size size;

  const HotelImage({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: size.height * 0.2,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          topLeft: Radius.circular(18),
          topRight: Radius.elliptical(80, 95),
          bottomRight: Radius.elliptical(80, 95),
        ),
        boxShadow: const [
          BoxShadow(offset: Offset(5, 0), color: Colors.black26, blurRadius: 5),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
