import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../utils/theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  // Mock reviews data
  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'userName': 'Ahmet Yılmaz',
      'rating': 5.0,
      'date': '2024-01-15',
      'comment': 'Harika bir ürün! Çok memnun kaldım. Kesinlikle tavsiye ederim.',
      'userAvatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
    },
    {
      'id': '2',
      'userName': 'Ayşe Demir',
      'rating': 4.0,
      'date': '2024-01-14',
      'comment': 'Kaliteli ürün, fiyatına değer. Hızlı teslimat için teşekkürler.',
      'userAvatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
    },
    {
      'id': '3',
      'userName': 'Mehmet Kaya',
      'rating': 5.0,
      'date': '2024-01-13',
      'comment': 'Beklentilerimin üzerinde bir ürün. Çok beğendim!',
      'userAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
    },
    {
      'id': '4',
      'userName': 'Fatma Özkan',
      'rating': 4.5,
      'date': '2024-01-12',
      'comment': 'Güzel ürün, kaliteli malzeme. Tavsiye ederim.',
      'userAvatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
    },
    {
      'id': '5',
      'userName': 'Ali Çelik',
      'rating': 3.5,
      'date': '2024-01-11',
      'comment': 'İyi ürün ama biraz pahalı. Yine de kaliteli.',
      'userAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favorilere eklendi')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildProductImage(),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Info
                  _buildProductInfo(),
                  
                  const SizedBox(height: 20),
                  
                  // Features
                  _buildFeatures(),
                  
                  const SizedBox(height: 20),
                  
                  // Reviews Section
                  _buildReviewsSection(),
                  
                  const SizedBox(height: 20),
                  
                  // Quantity Selector
                  _buildQuantitySelector(),
                  
                  const SizedBox(height: 20),
                  
                  // Add to Cart Button
                  _buildAddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Icon(
        _getCategoryIcon(widget.product['category']),
        size: 100,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product['name'],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '₺${widget.product['price']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.product['rating']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Marka: ${widget.product['brand']}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Kategori: ${widget.product['category']} > ${widget.product['subcategory']}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    final features = widget.product['features'] as List<String>;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Özellikler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(feature),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildReviewsSection() {
    final averageRating = _reviews.fold(0.0, (sum, review) => sum + review['rating']) / _reviews.length;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Müşteri Yorumları',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_reviews.length} yorum',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: List.generate(5, (index) => Icon(
                index < averageRating.floor() 
                    ? Icons.star 
                    : index < averageRating 
                        ? Icons.star_half 
                        : Icons.star_border,
                color: Colors.amber,
                size: 20,
              )),
            ),
            const SizedBox(width: 8),
            Text(
              '(${_reviews.length} değerlendirme)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._reviews.map((review) => _buildReviewCard(review)),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review['userAvatar']),
                onBackgroundImageError: (exception, stackTrace) {
                  // Fallback to icon if image fails to load
                },
                child: review['userAvatar'] == null 
                    ? Icon(Icons.person, color: Colors.grey[400])
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) => Icon(
                          index < review['rating'] 
                              ? Icons.star 
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        )),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['comment'],
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        const Text(
          'Adet:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    final totalPrice = widget.product['price'] * _quantity;
    
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          final cartProvider = Provider.of<CartProvider>(context, listen: false);
          cartProvider.addItem(
            productId: widget.product['id'],
            productName: widget.product['name'],
            businessId: 'ai_recommendation', // Default business ID for AI recommendations
            businessName: 'AI Önerisi',
            price: widget.product['price'],
            image: widget.product['category'],
          );
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.product['name']} sepete eklendi'),
              action: SnackBarAction(
                label: 'Sepeti Görüntüle',
                onPressed: () {
                  // Navigate to cart
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Sepete Ekle - ₺${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Teknoloji':
        return Icons.phone_android;
      case 'Market':
        return Icons.shopping_basket;
      case 'Restoran':
        return Icons.restaurant;
      default:
        return Icons.shopping_bag;
    }
  }
} 