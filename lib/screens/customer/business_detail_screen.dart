import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/cart_provider.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class BusinessDetailScreen extends StatefulWidget {
  final Map<String, dynamic> business;
  
  const BusinessDetailScreen({
    super.key,
    required this.business,
  });

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  String _selectedCategory = 'Tümü';
  
  final List<String> _categories = ['Tümü', 'Popüler', 'Yeni', 'İndirimli'];

  final List<Map<String, dynamic>> _products = [
    // Teknoloji Dünyası ürünleri
    {
      'id': '1',
      'name': 'iPhone 15 Pro Max',
      'businessId': '1',
      'price': 65000.0,
      'originalPrice': 70000.0,
      'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
      'category': 'Telefon',
      'discount': 7,
      'description': 'Apple iPhone 15 Pro Max 256GB',
      'stock': 10,
    },
    {
      'id': '2',
      'name': 'Samsung Galaxy S24 Ultra',
      'businessId': '1',
      'price': 55000.0,
      'originalPrice': 60000.0,
      'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
      'category': 'Telefon',
      'discount': 8,
      'description': 'Samsung Galaxy S24 Ultra 256GB',
      'stock': 15,
    },
    {
      'id': '3',
      'name': 'MacBook Pro M3',
      'businessId': '1',
      'price': 85000.0,
      'originalPrice': 90000.0,
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      'category': 'Bilgisayar',
      'discount': 6,
      'description': 'Apple MacBook Pro M3 14 inch',
      'stock': 8,
    },
    {
      'id': '4',
      'name': 'AirPods Pro',
      'businessId': '1',
      'price': 8500.0,
      'originalPrice': 9500.0,
      'image': 'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf0?w=400',
      'category': 'Aksesuar',
      'discount': 11,
      'description': 'Apple AirPods Pro 2. Nesil',
      'stock': 25,
    },
    {
      'id': '5',
      'name': 'iPad Air',
      'businessId': '1',
      'price': 25000.0,
      'originalPrice': 27000.0,
      'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
      'category': 'Tablet',
      'discount': 7,
      'description': 'Apple iPad Air 5. Nesil 256GB',
      'stock': 12,
    },
    
    // Mega Market ürünleri
    {
      'id': '6',
      'name': 'Sütaş Tam Yağlı Süt 1L',
      'businessId': '2',
      'price': 18.0,
      'originalPrice': 20.0,
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
      'category': 'Süt Ürünleri',
      'discount': 10,
      'description': 'Taze tam yağlı süt',
      'stock': 50,
    },
    {
      'id': '7',
      'name': 'Köy Ekmeği Tam Buğday',
      'businessId': '2',
      'price': 12.0,
      'originalPrice': 14.0,
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      'category': 'Fırın Ürünleri',
      'discount': 14,
      'description': 'Tam buğday unundan yapılmış ekmek',
      'stock': 30,
    },
    {
      'id': '8',
      'name': 'Pınar Beyaz Peynir 500g',
      'businessId': '2',
      'price': 32.0,
      'originalPrice': 35.0,
      'image': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400',
      'category': 'Süt Ürünleri',
      'discount': 9,
      'description': 'Beyaz peynir 500 gram',
      'stock': 25,
    },
    {
      'id': '9',
      'name': 'Domates 1kg',
      'businessId': '2',
      'price': 15.0,
      'originalPrice': 18.0,
      'image': 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
      'category': 'Sebze',
      'discount': 17,
      'description': 'Taze domates 1 kilogram',
      'stock': 40,
    },
    {
      'id': '10',
      'name': 'Muz 1kg',
      'businessId': '2',
      'price': 25.0,
      'originalPrice': 28.0,
      'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
      'category': 'Meyve',
      'discount': 11,
      'description': 'Taze muz 1 kilogram',
      'stock': 35,
    },
    
    // Pizza Palace ürünleri
    {
      'id': '11',
      'name': 'Margherita Pizza',
      'businessId': '3',
      'price': 65.0,
      'originalPrice': 75.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'category': 'Pizza',
      'discount': 13,
      'description': 'Domates sosu, mozzarella peyniri',
      'stock': 20,
    },
    {
      'id': '12',
      'name': 'Pepperoni Pizza',
      'businessId': '3',
      'price': 75.0,
      'originalPrice': 85.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
      'category': 'Pizza',
      'discount': 12,
      'description': 'Pepperoni, mozzarella peyniri',
      'stock': 18,
    },
    {
      'id': '13',
      'name': 'Quattro Formaggi',
      'businessId': '3',
      'price': 85.0,
      'originalPrice': 95.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'category': 'Pizza',
      'discount': 11,
      'description': '4 farklı peynir çeşidi',
      'stock': 15,
    },
    {
      'id': '14',
      'name': 'Hawaiian Pizza',
      'businessId': '3',
      'price': 70.0,
      'originalPrice': 80.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
      'category': 'Pizza',
      'discount': 13,
      'description': 'Jambon, ananas, mozzarella',
      'stock': 22,
    },
    {
      'id': '15',
      'name': 'BBQ Chicken Pizza',
      'businessId': '3',
      'price': 80.0,
      'originalPrice': 90.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'category': 'Pizza',
      'discount': 11,
      'description': 'BBQ soslu tavuk, soğan',
      'stock': 16,
    },
    
    // Kafe Moda ürünleri
    {
      'id': '16',
      'name': 'Espresso',
      'businessId': '4',
      'price': 25.0,
      'originalPrice': 28.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'category': 'Kahve',
      'discount': 11,
      'description': 'Tek shot espresso',
      'stock': 100,
    },
    {
      'id': '17',
      'name': 'Latte',
      'businessId': '4',
      'price': 30.0,
      'originalPrice': 35.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
      'category': 'Kahve',
      'discount': 14,
      'description': 'Espresso ve buharlanmış süt',
      'stock': 80,
    },
    {
      'id': '18',
      'name': 'Cappuccino',
      'businessId': '4',
      'price': 28.0,
      'originalPrice': 32.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'category': 'Kahve',
      'discount': 13,
      'description': 'Espresso, buharlanmış süt ve süt köpüğü',
      'stock': 75,
    },
    {
      'id': '19',
      'name': 'Americano',
      'businessId': '4',
      'price': 22.0,
      'originalPrice': 25.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
      'category': 'Kahve',
      'discount': 12,
      'description': 'Espresso ve sıcak su',
      'stock': 90,
    },
    {
      'id': '20',
      'name': 'Mocha',
      'businessId': '4',
      'price': 35.0,
      'originalPrice': 40.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'category': 'Kahve',
      'discount': 13,
      'description': 'Espresso, çikolata ve süt',
      'stock': 60,
    },
    
    // Burger House ürünleri
    {
      'id': '21',
      'name': 'Cheeseburger Deluxe',
      'businessId': '5',
      'price': 45.0,
      'originalPrice': 50.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'category': 'Burger',
      'discount': 10,
      'description': 'Dana eti, cheddar peyniri, marul, domates',
      'stock': 30,
    },
    {
      'id': '22',
      'name': 'Bacon Burger',
      'businessId': '5',
      'price': 55.0,
      'originalPrice': 60.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'category': 'Burger',
      'discount': 8,
      'description': 'Dana eti, bacon, cheddar peyniri',
      'stock': 25,
    },
    {
      'id': '23',
      'name': 'Chicken Burger',
      'businessId': '5',
      'price': 40.0,
      'originalPrice': 45.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'category': 'Burger',
      'discount': 11,
      'description': 'Tavuk göğsü, marul, domates',
      'stock': 35,
    },
    {
      'id': '24',
      'name': 'Chicken Wings',
      'businessId': '5',
      'price': 65.0,
      'originalPrice': 75.0,
      'image': 'https://images.unsplash.com/photo-1567620832904-9fe0d3b2b8b8?w=400',
      'category': 'Tavuk',
      'discount': 13,
      'description': '8 adet çıtır tavuk kanadı',
      'stock': 20,
    },
    {
      'id': '25',
      'name': 'French Fries',
      'businessId': '5',
      'price': 25.0,
      'originalPrice': 30.0,
      'image': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
      'category': 'Yan Ürün',
      'discount': 17,
      'description': 'Çıtır patates kızartması',
      'stock': 50,
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) => product['businessId'] == widget.business['id']).toList();
  }

  void _addToCart(Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addItem(
      productId: product['id'],
      productName: product['name'],
      businessId: product['businessId'],
      businessName: widget.business['name'],
      price: product['price'].toDouble(),
      image: product['image'],
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} sepete eklendi'),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.business['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.business['image'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  // TODO: Add to favorites
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // TODO: Share business
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Business Info
                  _buildBusinessInfo(),
                  
                  const SizedBox(height: 20),
                  
                  // Categories
                  _buildCategories(),
                  
                  const SizedBox(height: 20),
                  
                  // Products
                  _buildProducts(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.business['isOpen'] ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.business['isOpen'] ? 'Açık' : 'Kapalı',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    widget.business['rating'].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppTheme.primaryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    widget.business['distance'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Teslimat: ${widget.business['deliveryTime']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.delivery_dining, color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Ücret: ${widget.business['deliveryFee']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.shopping_cart, color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Min. Sipariş: ${widget.business['minOrder']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategoriler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProducts() {
    final products = _filteredProducts;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ürünler (${products.length})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: product['image'],
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['category'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondaryColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (product['discount'] > 0) ...[
                              Text(
                                '₺${product['originalPrice']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondaryColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              '₺${product['price']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _addToCart(product),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Sepete Ekle',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
} 