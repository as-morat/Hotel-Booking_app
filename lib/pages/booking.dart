import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF86C7FC), Color(0xFF42A5F5), Color(0xFF1E88E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text("Checkout", style: AppWidget.whiteTextStyle(28)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                height: size.height * 0.15,
                margin: const .only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 4),
                      blurRadius: 6,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: .hardEdge,
                      height: size.height * 0.15,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: const .only(
                          bottomLeft: .circular(18),
                          topLeft: .circular(18),
                          topRight: .elliptical(80, 95),
                          bottomRight: .elliptical(80, 95),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 0),
                            color: Colors.black26,
                            blurRadius: 5,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage("images/home.jpg"),
                          fit: .cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const .symmetric(horizontal: 14, vertical: 12),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              "Hotel Name",
                              style: AppWidget.normalTextStyle(
                                22,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 22,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "Location details here",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "\$300 / night",
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Trip Overview",
                  style: AppWidget.normalTextStyle(22),
                ),
              ),
              Container(
                margin: const .only(top: 20, bottom: 20),
                padding: const .all(5),
                decoration: BoxDecoration(
                  borderRadius: .circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 5,
                      color: Colors.black12
                    )
                  ],
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    _overview(Icons.date_range, "Dates", "25, November 2025"),
                    _overview(Icons.person_2_outlined, "Guests", "1 Guest")
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: .infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Confirm Booking",
                    style: AppWidget.whiteTextStyle(18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: .center,
      //     children: [
      //       Icon(
      //         Icons.shopping_bag_outlined,
      //         size: 80,
      //         color: Colors.grey.shade400,
      //       ),
      //       const SizedBox(height: 20),
      //       Text(
      //         'No bookings yet',
      //         style: TextStyle(
      //           fontSize: 20,
      //           color: Colors.grey.shade600,
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Text(
      //         'Start exploring and book your first hotel!',
      //         style: TextStyle(
      //           fontSize: 14,
      //           color: Colors.grey.shade500,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _overview(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade900, size: 30,),
      title: Text(title, style: AppWidget.normalTextStyle(18),),
      subtitle: Text(subtitle),
      trailing: TextButton(onPressed: (){}, child: Text("Edit")),
    );
  }
}
