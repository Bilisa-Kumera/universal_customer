import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/widgets/custom_button.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';

import '../../core/utils/navigation_helper.dart';
import '../waiting/waiting_driver.dart';

class RequestConfirm extends StatelessWidget {
  const RequestConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: const Text('Request for rent'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Locations
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    Container(
                      width: 2,
                      height: 24,
                      color: Colors.yellow[700],
                    ),
                    Icon(Icons.location_on, color: Colors.amber, size: 20),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current location',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Office',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '1.1km',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Car Info
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: borderRadius,
                border: Border.all(color: Colors.yellow[700]!),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Toyota Vitz',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('4.5',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text('Plate: AA B27279',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/car.png', // Placeholder image
                    width: 70,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Date, Time, Promo
            CustomText(text: 'Charge'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Mustang/perhours'),
                CustomText(text: '\$200'),
              ],
            ),
            const SizedBox(height: 16),
            // Payment Methods
            Row(
              children: [
                Text('Select payment method',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Text('View All',
                    style: TextStyle(
                        color: Colors.amber[800], fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            // VISA
            _PaymentMethodTile(
              icon: Icons.credit_card,
              label: '**** **** **** 8970',
              subLabel: 'Expires: 12/26',
              selected: true,
              brandAsset: 'assets/images/visa.png', // Replace with your asset
            ),
            // Mastercard
            _PaymentMethodTile(
              icon: Icons.credit_card,
              label: '**** **** **** 8970',
              subLabel: 'Expires: 12/26',
              selected: false,
              brandAsset: 'assets/images/visa.png', // Replace with your asset
            ),
            // Wallet
            _PaymentMethodTile(
              icon: Icons.account_balance_wallet,
              label: 'My Wallet',
              subLabel: '\$349',
              selected: false,
            ),
            // Cash
            _PaymentMethodTile(
              icon: Icons.attach_money,
              label: 'Cash',
              selected: false,
            ),
            const SizedBox(height: 24),
            // Confirm Button
            CustomButton(
                onPressed: () {
                  NavigationHelper.push(context, WaitingDriverScreen());
                },
                text: 'Confirm Ride'),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subLabel;
  final bool selected;
  final String? brandAsset;

  const _PaymentMethodTile({
    required this.icon,
    required this.label,
    this.subLabel,
    this.selected = false,
    this.brandAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.yellow[50] : Colors.grey[100],
        border: Border.all(
          color: selected ? Colors.amber : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: brandAsset != null
            ? Image.asset(brandAsset!, width: 32, height: 32)
            : Icon(icon, size: 32, color: Colors.grey[700]),
        title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subLabel != null ? Text(subLabel!) : null,
        trailing:
            selected ? Icon(Icons.check_circle, color: Colors.amber) : null,
        onTap: () {},
      ),
    );
  }
}
