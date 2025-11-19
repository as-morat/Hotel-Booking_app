import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/category_list.dart';
import '../../services/widgets_supported.dart';

class RelevantCategory extends StatefulWidget {
  const RelevantCategory({super.key});

  @override
  State<RelevantCategory> createState() => _RelevantCategoryState();
}

class _RelevantCategoryState extends State<RelevantCategory> {
  final Map<int, bool> _loadingStates = {};

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: .horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: relevantCategory.length,
        itemBuilder: (_, index) {
          final category = relevantCategory[index];
          final isLoading = _loadingStates[index] ?? true;

          return Container(
            width: size.width * 0.75,
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 2,
                  color: Colors.black26,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    category.image,
                    height: 185,
                    width: size.width * 0.75,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress != null) {
                        if (_loadingStates[index] != true) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                _loadingStates[index] = true;
                              });
                            }
                          });
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 180,
                            width: size.width * 0.75,
                            color: Colors.grey.shade300,
                          ),
                        );
                      }
                      if (_loadingStates[index] != false) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _loadingStates[index] = false;
                            });
                          }
                        });
                      }
                      return child;
                    },
                  ),
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            crossAxisAlignment: .start,
                            mainAxisSize: .min,
                            children: [
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Container(
                                    height: 14,
                                    width: 110,
                                    color: Colors.grey.shade300,
                                  ),
                                  Container(
                                    height: 14,
                                    width: 70,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 14,
                                width: 180,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  category.name,
                                  style: AppWidget.normalTextStyle(18.5),
                                ),
                                Text(
                                  category.price,
                                  style: AppWidget.normalTextStyle(15).copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    category.location,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppWidget.normalTextStyle(
                                      13.7,
                                    ).copyWith(color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
