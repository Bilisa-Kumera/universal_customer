import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:universal_customer/core/constants/spacings.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/available_cars/available_cars.dart';
import 'package:universal_customer/presentation/location/location_screen.dart';
import '../../core/constants/widgets/custom_icon.dart';
import '../../core/utils/hive_service.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  int selectedTab = 0; // 0: Transport, 1: Delivery

  @override
  void initState() {
    super.initState();
    _checkFirstVisit();
  }

  Future<void> _checkFirstVisit() async {
    const boxName = 'app_prefs';
    const key = 'hasReadHomeWelcomePopup';
    final hasRead = await HiveService.get<bool>(boxName, key) ?? false;
    if (!hasRead) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomeDialog();
      });
    }
  }

  void _setPopupRead() async {
    const boxName = 'app_prefs';
    const key = 'hasReadHomeWelcomePopup';
    await HiveService.put(boxName, key, true);
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _setPopupRead();
                  },
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF9E5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check_circle,
                      color: Color(0xFF6FCF97), size: 56),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Congratulations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your account is ready to use. You will be redirected to the Home Page in a few seconds.',
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Icon(Icons.sync, color: Color(0xFFF7B731), size: 36),
            ],
          ),
        ),
      ),
    );
    // Optionally auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        _setPopupRead();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set your initial map center (latitude, longitude)
    final LatLng mapCenter =
        LatLng(37.7749, -122.4194); // Example: San Francisco
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Free map background using OpenStreetMap
          SizedBox.expand(
            child: FlutterMap(
                options: MapOptions(
                  center: mapCenter,
                  zoom: 13.0,
                  interactiveFlags: InteractiveFlag.all,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width:
                            100, // Slightly larger to match the image's proportions
                        height: 100,
                        point: mapCenter,
                        child: Stack(
                          children: [
                            // Gradient circle
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Color(
                                        0x99FFF9E6), // More transparent center
                                    Color(0x99FFD940), // More transparent edge
                                    Color(
                                        0x00FFD940), // Transparent at the outermost edge
                                  ],
                                  stops: [
                                    0.0,
                                    0.5,
                                    1.0
                                  ], // Control gradient transition
                                  center: Alignment.center,
                                  radius:
                                      0.8, // Adjusted for a more diffused look
                                ),
                              ),
                            ),
                            // Subtle outer overlay/shadow effect
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black
                                    .withOpacity(0.03), // Even softer opacity
                              ),
                            ),
                            // Location pin icon
                            const Center(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black54, // More transparent icon
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
          // Top bar
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                children: [
                  // Menu button
                  CustomIconBox(
                    icon: Icons.menu,
                    iconColor: Colors.black,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  // Search button
                  CustomIconBox(
                    icon: Icons.search,
                    iconColor: Colors.black,
                    onTap: () {
                      NavigationHelper.push(context, LocationScreen());
                    },
                  ),
                  AppSpacing.sizedBoxW10,
                  // Notification button
                  CustomIconBox(
                    icon: Icons.notifications_none_outlined,
                    iconColor: Colors.black,
                    onTap: () {
                      NavigationHelper.push(context, AvailableCarsScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom card
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xffFFFBE7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xffFEC400), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search field
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBE7),
                        border: Border.all(color: Color(0xffFEC400), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          LocationScreen.show(context);
                        },
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: const Icon(Icons.favorite_border,
                              color: Colors.grey),
                          hintText: 'Where would you go?',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border:
                              InputBorder.none, // Removes the default border
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Toggle buttons
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CC),
                        border: Border.all(color: Color(0xffFEC400), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedTab = 0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: selectedTab == 0
                                      ? const Color(0xFFEDAE10)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Transport',
                                  style: TextStyle(
                                    color: selectedTab == 0
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedTab = 1),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: selectedTab == 1
                                      ? const Color(0xFFEDAE10)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: selectedTab == 1
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
