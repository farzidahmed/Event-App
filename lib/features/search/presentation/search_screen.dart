import 'dart:async';

import 'package:flutter/material.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/common/custom_form_field.dart';
import 'package:llr/common/custom_network_image.dart';
import 'package:llr/common/shimmer_widget.dart';
import 'package:llr/helpers/all_routes.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:llr/networks/api_access.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(scaffoldBackgroundColor: const Color(0xFF121212)),
      home: const FestivalHomeScreen(),
    );
  }
}

class FestivalHomeScreen extends StatefulWidget {
  const FestivalHomeScreen({super.key});

  @override
  State<FestivalHomeScreen> createState() => _FestivalHomeScreenState();
}

class _FestivalHomeScreenState extends State<FestivalHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  String? _selectedLocation;
  String? _selectedDate;

  bool _isThisWeekend(DateTime? start, DateTime? end) {
    if (start == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final saturday = startOfWeek.add(const Duration(days: 5));
    final startOfWeekend = DateTime(
      saturday.year,
      saturday.month,
      saturday.day,
    );
    final sunday = startOfWeek.add(const Duration(days: 6));
    final endOfWeekend = DateTime(
      sunday.year,
      sunday.month,
      sunday.day,
      23,
      59,
      59,
    );

    DateTime festivalStart = start;
    DateTime festivalEnd = end ?? start;

    return festivalStart.isBefore(endOfWeekend) &&
        festivalEnd.isAfter(startOfWeekend);
  }

  bool _isThisMonth(DateTime? start, DateTime? end) {
    if (start == null) return false;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(
      now.year,
      now.month + 1,
      1,
    ).subtract(const Duration(milliseconds: 1));

    DateTime festivalStart = start;
    DateTime festivalEnd = end ?? start;

    return festivalStart.isBefore(endOfMonth) &&
        festivalEnd.isAfter(startOfMonth);
  }

  @override
  void initState() {
    festivalSearchRx.searchFestival(search: _searchController.text);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      festivalSearchRx.searchFestival(search: query);
    });
  }

  String formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return "";
    final parsedDate = DateTime.parse(dateTime);
    return "${parsedDate.day.toString().padLeft(2, '0')}-"
        "${parsedDate.month.toString().padLeft(2, '0')}-"
        "${parsedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              // Container(
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF1E1E1E),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: TextField(
              //     controller: _searchController,
              //     onChanged: _onSearchChanged,
              //     decoration: const InputDecoration(
              //       hintText: 'Search festivals...',
              //       hintStyle: TextStyle(color: Colors.grey),
              //       border: InputBorder.none,
              //       prefixIcon: Icon(Icons.search, color: Colors.grey),
              //     ),
              //   ),
              // ),
              CustomFormField(
                hintText: "Search festivals...",
                fillColor: Color(0xFF1E1E1E),
                onChanged: _onSearchChanged,
                controller: _searchController,
              ),
              const SizedBox(height: 16),

              StreamBuilder(
                stream: festivalSearchRx.dataFetcher.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const FestivalListShimmer();
                  } else if (snapshot.hasData) {
                    final response = snapshot.data!;
                    final festivals = response.data ?? [];

                    // Extract unique locations
                    final locations =
                        festivals
                            .map((e) => e.location)
                            .where(
                              (loc) =>
                                  loc != null &&
                                  loc.toString().trim().isNotEmpty,
                            )
                            .toSet()
                            .toList()
                            .cast<String>();

                    // Apply filters
                    final filteredFestivals =
                        festivals.where((festival) {
                          if (_selectedLocation != null &&
                              festival.location != _selectedLocation) {
                            return false;
                          }
                          if (_selectedDate == "This Weekend") {
                            if (!_isThisWeekend(
                              festival.startDate,
                              festival.endDate,
                            )) {
                              return false;
                            }
                          } else if (_selectedDate == "This Month") {
                            if (!_isThisMonth(
                              festival.startDate,
                              festival.endDate,
                            )) {
                              return false;
                            }
                          }
                          return true;
                        }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilterChipWidget(
                              label: "This Weekend",
                              icon: Icons.calendar_today,
                              isSelected: _selectedDate == "This Weekend",
                              onTap: () {
                                setState(() {
                                  if (_selectedDate == "This Weekend") {
                                    _selectedDate = null;
                                  } else {
                                    _selectedDate = "This Weekend";
                                  }
                                });
                              },
                            ),
                            FilterChipWidget(
                              label: "This Month",
                              icon: Icons.calendar_month,
                              isSelected: _selectedDate == "This Month",
                              onTap: () {
                                setState(() {
                                  if (_selectedDate == "This Month") {
                                    _selectedDate = null;
                                  } else {
                                    _selectedDate = "This Month";
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        if (locations.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  locations.map((loc) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: FilterChipWidget(
                                        label: loc,
                                        icon: Icons.location_on,
                                        isSelected: _selectedLocation == loc,
                                        onTap: () {
                                          setState(() {
                                            if (_selectedLocation == loc) {
                                              _selectedLocation = null;
                                            } else {
                                              _selectedLocation = loc;
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        Text(
                          "${filteredFestivals.length} festivals found",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        filteredFestivals.isEmpty
                            ? const Center(
                              child: Text(
                                "Not Found",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                            : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredFestivals.length,
                              itemBuilder: (context, index) {
                                final data = filteredFestivals[index];
                                return FestivalCardWidget(
                                  onTap: () {
                                    NavigationService.navigateToWithArgs(
                                      Routes.pastFestialvalDetailsScreen,
                                      {'id': data.id},
                                    );
                                  },
                                  imageUrl: data.image ?? "",
                                  title: data.festivalName ?? "",
                                  location: data.location ?? "",
                                  date:
                                      "${formatDate(data.startDate?.toString())} - ${formatDate(data.endDate?.toString())}",
                                  category: "Indie Rock",
                                  rating: 4.5,
                                );
                              },
                            ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Filter Chip Widget
class FilterChipWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white,
          size: 18,
        ),
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white),
        ),
        backgroundColor: isSelected ? Colors.white : const Color(0xFF1E1E1E),
        side: BorderSide.none,
      ),
    );
  }
}

/// Custom Festival Card Widget
class FestivalCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String date;
  final String category;
  final double rating;
  final VoidCallback? onTap;

  const FestivalCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
    required this.category,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            //   child: Image.network(
            //     imageUrl,
            //     height: 160,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CustomNetworkImage(
                urls: imageUrl,
                height: 160,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.cFFFFFF,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(date, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.local_fire_department,
                      //       color: Colors.orange,
                      //       size: 18,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       rating.toString(),
                      //       style: const TextStyle(color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
