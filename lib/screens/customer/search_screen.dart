import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class CustomerSearchScreen extends StatefulWidget {
  const CustomerSearchScreen({super.key});

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tümü';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'İşletme, ürün veya hizmet ara...',
                      prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondaryColor),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.clear, color: AppTheme.textSecondaryColor),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppTheme.backgroundColor,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Category Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ['Tümü', ...AppConstants.businessCategories].length,
                      itemBuilder: (context, index) {
                        final category = ['Tümü', ...AppConstants.businessCategories][index];
                        final isSelected = category == _selectedCategory;
                        
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            backgroundColor: Colors.white,
                            selectedColor: AppTheme.primaryColor,
                            checkmarkColor: Colors.white,
                            side: BorderSide(
                              color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Results
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchQuery.isEmpty) {
      return _buildRecentSearches();
    }

    // TODO: Implement actual search functionality
    return _buildSearchResultsList();
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son Aramalar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          
          // Recent searches list
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final recentSearches = [
                  'Mahalle Marketi',
                  'Köşe Restoranı',
                  'Eczane',
                  'Kırtasiye',
                  'Teknoloji Mağazası',
                ];
                
                return ListTile(
                  leading: const Icon(Icons.history, color: AppTheme.textSecondaryColor),
                  title: Text(
                    recentSearches[index],
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.textPrimaryColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  onTap: () {
                    _searchController.text = recentSearches[index];
                    setState(() {
                      _searchQuery = recentSearches[index];
                    });
                  },
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          const Text(
            'Popüler Aramalar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          
          // Popular searches
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Market',
              'Restoran',
              'Eczane',
              'Kırtasiye',
              'Teknoloji',
              'Giyim',
            ].map((tag) => ActionChip(
              label: Text(
                tag,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryColor,
                  fontFamily: 'Poppins',
                ),
              ),
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              onPressed: () {
                _searchController.text = tag;
                setState(() {
                  _searchQuery = tag;
                });
              },
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsList() {
    // TODO: Replace with actual search results
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildSearchResultCard(
          name: 'Arama Sonucu ${index + 1}',
          category: _selectedCategory == 'Tümü' ? 'Market' : _selectedCategory,
          rating: 4.0 + (index % 5) * 0.1,
          distance: '${0.5 + index * 0.2} km',
          isOpen: index % 2 == 0,
        );
      },
    );
  }

  Widget _buildSearchResultCard({
    required String name,
    required String category,
    required double rating,
    required String distance,
    required bool isOpen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Business Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: AppTheme.primaryColor,
              size: 30,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Business Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondaryColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isOpen ? 'Açık' : 'Kapalı',
              style: TextStyle(
                fontSize: 12,
                color: isOpen ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Market':
        return Icons.shopping_basket;
      case 'Restoran':
        return Icons.restaurant;
      case 'Kafe':
        return Icons.coffee;
      case 'Teknoloji':
        return Icons.phone_android;
      case 'Giyim':
        return Icons.checkroom;
      case 'Kozmetik':
        return Icons.face;
      case 'Eczane':
        return Icons.local_pharmacy;
      case 'Kırtasiye':
        return Icons.edit;
      case 'Spor':
        return Icons.sports_soccer;
      case 'Ev & Yaşam':
        return Icons.home;
      default:
        return Icons.store;
    }
  }
} 