import 'package:flutter/material.dart';

import '../../services/widgets_supported.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: Image.asset(
            "images/home.jpg",
            width: size.width,
            height: 280,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 40, left: 20),
          width: size.width,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    "Chittagong, Bangladesh",
                    style: AppWidget.whiteTextStyle(18),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Hey, Ash! Tell us where you want to go",
                style: AppWidget.whiteTextStyle(26),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                margin: const EdgeInsets.only(right: 20),
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(82, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  style: AppWidget.whiteTextStyle(18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    hintText: "Search Places",
                    hintStyle: AppWidget.whiteTextStyle(
                      18,
                    ).copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
