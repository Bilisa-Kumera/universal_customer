import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/widgets/custom_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  // Function to show the bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take up more space
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8,
        child: const LocationScreen(),
      ),
    );
  }

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _fromController = TextEditingController(text: '');
  final TextEditingController _toController = TextEditingController();
  final FocusNode _fromFocus = FocusNode();
  final FocusNode _toFocus = FocusNode();
  bool _showSummary = false;
  String _activeField = '';
  List<_Place> _filteredSuggestions = [];
  final List<_Place> _places = const [
    _Place(
      label: 'Office',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      icon: Icons.location_on,
      iconColor: Colors.amber,
      distance: '1.1km',
    ),
    _Place(
      label: 'Home',
      address: '1234 Main St. Springfield, Illinois 62704',
      icon: Icons.home,
      iconColor: Colors.blue,
      distance: '3.2km',
    ),
    _Place(
      label: 'Shopping Center',
      address: '5678 Market Ave. Chicago, Illinois 60616',
      icon: Icons.shopping_cart,
      iconColor: Colors.green,
      distance: '2.0km',
    ),
  ];

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _fromFocus.dispose();
    _toFocus.dispose();
    super.dispose();
  }

  void _onFieldChanged(String value, String field) {
    setState(() {
      _activeField = field;
      _filteredSuggestions = _places
          .where((place) =>
              place.label.toLowerCase().contains(value.toLowerCase()) ||
              place.address.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onSuggestionTap(_Place place, String field) {
    setState(() {
      if (field == 'from') {
        _fromController.text = place.address;
        _fromFocus.unfocus();
      } else {
        _toController.text = place.address;
        _toFocus.unfocus();
      }
      _filteredSuggestions = [];
      _activeField = '';
    });
  }

  bool get _canShowSummary =>
      _fromController.text.trim().isNotEmpty &&
      _toController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle and title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select address',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Editable From field
              TextField(
                controller: _fromController,
                focusNode: _fromFocus,
                onChanged: (v) => _onFieldChanged(v, 'from'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                  hintText: 'From',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_activeField == 'from' && _filteredSuggestions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: _filteredSuggestions
                        .map((place) => ListTile(
                              leading: Icon(place.icon, color: place.iconColor),
                              title: Text(place.label),
                              subtitle: Text(place.address),
                              onTap: () => _onSuggestionTap(place, 'from'),
                            ))
                        .toList(),
                  ),
                ),
              const SizedBox(height: 8),
              // Editable To field
              TextField(
                controller: _toController,
                focusNode: _toFocus,
                onChanged: (v) => _onFieldChanged(v, 'to'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  hintText: 'To',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              if (_activeField == 'to' && _filteredSuggestions.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: _filteredSuggestions
                        .map((place) => ListTile(
                              leading: Icon(place.icon, color: place.iconColor),
                              title: Text(place.label),
                              subtitle: Text(place.address),
                              onTap: () => _onSuggestionTap(place, 'to'),
                            ))
                        .toList(),
                  ),
                ),
              const SizedBox(height: 16),
              // Show summary and confirm button only when both fields are filled
              if (_canShowSummary) ...[
              //   _SummaryCard(
              //     icon: Icons.location_on,
              //     iconColor: Colors.red,
              //     title: 'From',
              //     address: _fromController.text,
              //     trailing: null,
              //   ),
              //   const SizedBox(height: 8),
                // _SummaryCard(
                //   icon: Icons.location_on_outlined,
                //   iconColor: Colors.amber,
                //   title: 'To',
                //   address: _toController.text,
                //   trailing: null,
                // ),
                const SizedBox(height: 24),

               CustomButton(text: 'Confirm Location', onPressed: (){}),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String address;
  final Widget? trailing;

  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.address,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(address,
                      style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ]
          ],
        ),
      ),
    );
  }
}

// Custom widget for each location tile
class LocationTile extends StatelessWidget {
  final String title;
  final String address;
  final String distance;

  const LocationTile({
    Key? key,
    required this.title,
    required this.address,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        address,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Text(
        distance,
        style: const TextStyle(color: Colors.grey),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      onTap: () {
        // Handle tap (e.g., select the address)
      },
    );
  }
}

class _Place {
  final String label;
  final String address;
  final IconData icon;
  final Color iconColor;
  final String distance;

  const _Place({
    required this.label,
    required this.address,
    required this.icon,
    required this.iconColor,
    required this.distance,
  });
}
