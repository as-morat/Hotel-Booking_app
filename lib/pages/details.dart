import 'package:booking_app/models/category_model.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final Category hotel;

  const DetailsScreen({super.key, required this.hotel});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late Category selectedHotel;
  TextEditingController memberController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  DateTime? checkInDate;
  DateTime? checkOutDate;

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isCheckIn ? checkInDate : checkOutDate) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          checkInController.text = DateFormat("dd, MMMM yyyy").format(picked);
        } else {
          checkOutDate = picked;
          checkOutController.text = DateFormat("dd, MMMM yyyy").format(picked);
        }
      });
    }
  }

  @override
  void dispose() {
    memberController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedHotel = widget.hotel;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: selectedHotel.id,
                  child: ClipRRect(
                    borderRadius: const .only(
                      bottomLeft: .circular(60),
                      bottomRight: .circular(60),
                    ),
                    child: Image.network(
                      selectedHotel.image,
                      height: 350,
                      width: .infinity,
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
                      borderRadius: .circular(50),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
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
              padding: const .symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    selectedHotel.name,
                    style: AppWidget.normalTextStyle(26)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    selectedHotel.price,
                    style: AppWidget.normalTextStyle(20)
                        .copyWith(color: Colors.black54),
                  ),
                  const Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "What this place offers",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  if (selectedHotel.wifi)
                    _available(Icons.wifi, "Wi-Fi", context),
                  if (selectedHotel.hdtv)
                    _available(Icons.tv, "HDTV", context),
                  if (selectedHotel.kitchen)
                    _available(Icons.soup_kitchen_outlined, "Kitchen", context),
                  if (selectedHotel.bathroom)
                    _available(Icons.bathtub_outlined, "Bathroom", context),
                  const Divider(thickness: 3),
                  const SizedBox(height: 10),
                  Text(
                    "About this place",
                    style: AppWidget.normalTextStyle(24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedHotel.details,
                    style: AppWidget.normalTextStyle(18).copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width,
                    margin: const .only(bottom: 20),
                    padding: const .symmetric(horizontal: 10, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(20),
                      boxShadow: const [
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
                        Row(
                          children: [
                            Icon(Icons.discount, size: 22, color: Theme.of(context).colorScheme.primary,),
                            const SizedBox(width: 6),
                            Text(
                              selectedHotel.discount,
                              style: AppWidget.normalTextStyle(22),),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Check-in Date",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        const SizedBox(height: 8),
                        _buildDateField(checkInController, true),
                        const SizedBox(height: 10),
                        Text(
                          "Check-out Date",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        const SizedBox(height: 8),
                        _buildDateField(checkOutController, false),
                        const SizedBox(height: 10),
                        Text(
                          "Number of guests",
                          style: AppWidget.normalTextStyle(18),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 50,
                          padding: const .symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withAlpha(80),
                            borderRadius: .circular(14),
                          ),
                          child: Center(
                            child: TextField(
                              controller: memberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Guest numbers...",
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                              style: const TextStyle(
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
                            onPressed: () {
                              // Booking logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Theme.of(context).colorScheme.primary,
                              foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(14),
                              ),
                            ),
                            child: Text(
                              "Book Now",
                              style: AppWidget.whiteTextStyle(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, bool isCheckIn) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(isCheckIn),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: isCheckIn ? "Select Check-in Date" : "Select Check-out Date",
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.calendar_month_rounded,
            size: 26,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          )
              : Icon(
            Icons.arrow_drop_down,
            color: Colors.grey.shade400,
            size: 28,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding: const .symmetric(
            horizontal: 16,
            vertical: 16,
          ),
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
            style: AppWidget.normalTextStyle(size)
                .copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}