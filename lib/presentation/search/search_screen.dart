import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_customer/core/constants/colors.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _allResults = [
    'Burger Shop',
    'Shopping mall',
    'Coffee Shop',
    'Shopping center',
    'Shopping Villa',
    'Goldman Shop',
    'Citygroup Shop',
    'Bookstore',
    'Electronics Hub',
    'Flower Boutique',
  ];

  List<String> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchResults = List.from(_allResults); // Show all initially
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isLoading = false;
        if (query.isEmpty) {
          _searchResults = List.from(_allResults); // Show all
        } else {
          _searchResults = _allResults
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1B1),
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_on_outlined),
              hintText: 'Search...',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      iconSize: 14,
                      onPressed: () {
                        _searchController.clear();
                        _performSearch('');
                      },
                    )
                  : null,
            ),
            onChanged: (query) {
              _performSearch(query);
            },
            onSubmitted: (query) {
              _performSearch(query);
            },
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Results for  "',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.grey[700],
                                    ),
                              ),
                              TextSpan(
                                text: _searchController.text,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: '"',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.grey[700],
                                    ),
                              ),
                            ],
                          ),
                        ),
                        CustomText(
                          text: _searchResults.isNotEmpty
                              ? '${_searchResults.length} found'
                              : 'Not Found',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _searchResults.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/nodata.png",
                                  height: 180.h,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'No matching results',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.access_time),
                                title: Text(_searchResults[index]),
                                subtitle: const Text('Placeholder address'),
                                trailing: const Text('X.Xkm'),
                                onTap: () {
                                  // Handle item tap
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
