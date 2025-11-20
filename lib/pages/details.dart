import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(60),
                bottomRight: const Radius.circular(60),
              ),
              child: Image.network(
                "https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?cs=srgb&dl=pexels-donaldtong94-189296.jpg&fm=jpg",
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Sea Pearl",
                    style: AppWidget.normalTextStyle(
                      26,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "৳12,500",
                    style: AppWidget.normalTextStyle(
                      20,
                    ).copyWith(color: Colors.black54),
                  ),
                  Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "What this place offers",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  _available(Icons.wifi, "Wi-Fi", context),
                  _available(Icons.tv, "HDTV", context),
                  _available(Icons.soup_kitchen_outlined, "Kitchen", context),
                  _available(Icons.bathtub_outlined, "Bathroom", context),
                  Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "About this place",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: AppWidget.normalTextStyle(
                      18,
                    ).copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 390,
                    width: size.width,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 5),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "৳30,000 for 4 nights",
                          style: AppWidget.normalTextStyle(20),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Check-in-Date",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        Divider(),
                        _available(
                          Icons.calendar_month,
                          "19, November 2025",
                          context,
                          17,
                        ),
                        Text(
                          "Check-out-Date",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        Divider(),
                        _available(
                          Icons.calendar_month,
                          "22, November 2025",
                          context,
                          17,
                        ),
                        Text(
                          "Number of guests",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                hintText: "Guest numbers...",
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.2,),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14,),
                        Container(
                          height: 50,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                          ), child: Text("Book Now", style: AppWidget.whiteTextStyle(22),)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _available(
    IconData icon,
    String content,
    BuildContext context, [
    double size = 20,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            content,
            style: AppWidget.normalTextStyle(
              size,
            ).copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
