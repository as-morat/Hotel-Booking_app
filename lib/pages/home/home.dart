import 'package:booking_app/services/text_style.dart';
import 'package:booking_app/pages/home/widgets/discover_places.dart';
import 'package:booking_app/pages/home/widgets/intro.dart';
import 'package:booking_app/pages/home/widgets/hotel_category.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Intro(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "The most relevant",
                style: AppWidget.normalTextStyle(22),
              ),
            ),
            const SizedBox(height: 20),
            RelevantCategory(),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Discover new Places",
                style: AppWidget.normalTextStyle(22),
              ),
            ),
            const SizedBox(height: 20),
            DiscoverPlaces(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
          ],
        ),
      ),
    );
  }
}
