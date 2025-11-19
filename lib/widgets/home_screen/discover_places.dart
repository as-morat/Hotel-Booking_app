import 'package:booking_app/services/places_list.dart';
import 'package:booking_app/services/widgets_supported.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPlaces extends StatefulWidget {
  const DiscoverPlaces({super.key});

  @override
  State<DiscoverPlaces> createState() => _DiscoverPlacesState();
}

class _DiscoverPlacesState extends State<DiscoverPlaces> {
  final Map<int, bool> loadingIndex = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (_, index) {
          final place = places[index];
          final isLoading = loadingIndex[index] ?? true;

          return Container(
            width: size.width * 0.5,
            margin: const EdgeInsets.only(right: 16, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      place.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress != null) {
                          if (loadingIndex[index] != true) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                setState(() => loadingIndex[index] = true);
                              }
                            });
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(color: Colors.grey.shade300),
                          );
                        }
                        if (loadingIndex[index] != false) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() => loadingIndex[index] = false);
                            }
                          });
                        }
                        return child;
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: .topCenter,
                          end: .bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          stops: const [0.3, 0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  isLoading
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                crossAxisAlignment: .start,
                                mainAxisSize: .min,
                                children: [
                                  Container(
                                    height: 14,
                                    width: 80,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 14,
                                    width: 150,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: .start,
                              mainAxisSize: .min,
                              children: [
                                Text(
                                  place.place,
                                  style: AppWidget.whiteTextStyle(22).copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.hotel_rounded,
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        place.havingHotels,
                                        style: AppWidget.whiteTextStyle(14)
                                            .copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
