import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/utils/navigation_helper.dart';
import 'welcome_screen.dart';

class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(51.5074, -0.1278), // Coordinates for London city center
                zoom: 12.0, // Slightly zoomed out to show more of the city
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.universal_customer',
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with concentric circles
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFFFF3CC),
                          Color(0xFFFFD940),
                        ],
                        center: Alignment.center,
                        radius: 0.6,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.location_on,
                          color: Colors.black87, size: 32),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Enable your location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  const Text(
                    'Choose your location to start find the request around you',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Use my location button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF1B400), // Yellowish color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Use my location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Skip button
                  TextButton(
                    onPressed: () {
                      NavigationHelper.pushReplacement(
                        context,
                        const WelcomeScreen(),
                      );
                    },
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
