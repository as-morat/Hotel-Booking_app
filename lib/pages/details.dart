import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Category? category;

  const DetailsScreen({
    super.key,
    this.category
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: category!.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    child: Image.network(
                      category!.image,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 48,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category!.name,
                    style: AppWidget.normalTextStyle(
                      26,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    category!.price,
                    style: AppWidget.normalTextStyle(
                      20,
                    ).copyWith(color: Colors.black54),
                  ),
                  const Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "What this place offers",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  if (category!.wifi) _available(Icons.wifi, "Wi-Fi", context),
                  if (category!.hdtv) _available(Icons.tv, "HDTV", context),
                  if (category!.kitchen)
                    _available(Icons.soup_kitchen_outlined, "Kitchen", context),
                  if (category!.bathroom)
                    _available(Icons.bathtub_outlined, "Bathroom", context),
                  const Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "About this place",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category!.details,
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
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 5),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Divider(),
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
                        const Divider(),
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
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer.withAlpha(50),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Guest numbers...",
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              "Book Now",
                              style: AppWidget.whiteTextStyle(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
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
