import 'package:flutter/material.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/request_rent/request_rent.dart';

class AvailableCarsScreen extends StatelessWidget {
  const AvailableCarsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = [
      {
        'title': 'Economy',
        'seats': '5 seats',
        'type': 'Diesel',
        'distance': '800m',
        'time': '5mins away',
        'price': '250 Birr',
        'transmission': 'Automatic',
      },
      {
        'title': 'Economy Plus',
        'seats': '3 seats',
        'type': 'Electric',
        'distance': '800m',
        'time': '5mins away',
        'price': '250 Birr',
        'transmission': 'Automatic',
      },
      {
        'title': 'Mini Van',
        'seats': '7 seats',
        'type': 'Gasoline',
        'distance': '800m',
        'time': '5mins away',
        'price': '250 Birr',
        'transmission': 'Automatic',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Available cars for ride',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '18 cars found',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ...cars.map((car) => CarCard(car: car)),
          ],
        ),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final Map<String, String> car;
  const CarCard({required this.car, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      color: Colors.amber[50],
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  car['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  car['price']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${car['transmission']}  |  ${car['seats']}  |  ${car['type']}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  '${car['distance']} (${car['time']})',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.amber[700]!),
                      foregroundColor: Colors.amber[700],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      NavigationHelper.push(context, RequestRentPage());
                    },
                    child: const Text('Book later'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text('Ride Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
