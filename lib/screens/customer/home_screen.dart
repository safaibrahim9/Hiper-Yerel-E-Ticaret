import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/location_provider.dart';
import '../../providers/cart_provider.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';
import 'business_detail_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String? _selectedCategory;
  bool _showDiscounts = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Market', 'icon': Icons.shopping_basket, 'color': Colors.green},
    {'name': 'Restoran', 'icon': Icons.restaurant, 'color': Colors.orange},
    {'name': 'Kafe', 'icon': Icons.coffee, 'color': Colors.brown},
    {'name': 'Teknoloji', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'Giyim', 'icon': Icons.checkroom, 'color': Colors.purple},
    {'name': 'Kozmetik', 'icon': Icons.face, 'color': Colors.pink},
    {'name': 'Eczane', 'icon': Icons.local_pharmacy, 'color': Colors.red},
    {'name': 'Kırtasiye', 'icon': Icons.school, 'color': Colors.indigo},
  ];

  final List<Map<String, dynamic>> _businesses = [
    {
      'id': '1',
      'name': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'rating': 4.8,
      'distance': '0.3 km',
      'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400',
      'isOpen': true,
      'deliveryTime': '20-30 dk',
      'minOrder': '₺100',
      'deliveryFee': '₺8',
    },
    {
      'id': '2',
      'name': 'Mega Market',
      'category': 'Market',
      'rating': 4.5,
      'distance': '0.5 km',
      'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺50',
      'deliveryFee': '₺5',
    },
    {
      'id': '3',
      'name': 'Pizza Palace',
      'category': 'Restoran',
      'rating': 4.7,
      'distance': '0.8 km',
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'isOpen': true,
      'deliveryTime': '25-35 dk',
      'minOrder': '₺40',
      'deliveryFee': '₺6',
    },
    {
      'id': '4',
      'name': 'Kafe Moda',
      'category': 'Kafe',
      'rating': 4.6,
      'distance': '0.2 km',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'isOpen': true,
      'deliveryTime': '10-15 dk',
      'minOrder': '₺25',
      'deliveryFee': '₺4',
    },
    {
      'id': '5',
      'name': 'Burger House',
      'category': 'Restoran',
      'rating': 4.4,
      'distance': '0.7 km',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺35',
      'deliveryFee': '₺6',
    },
    {
      'id': '6',
      'name': 'Sushi Bar',
      'category': 'Restoran',
      'rating': 4.9,
      'distance': '1.2 km',
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
      'isOpen': true,
      'deliveryTime': '30-40 dk',
      'minOrder': '₺60',
      'deliveryFee': '₺10',
    },
    {
      'id': '7',
      'name': 'Sağlık Eczanesi',
      'category': 'Eczane',
      'rating': 4.8,
      'distance': '0.6 km',
      'image': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=400',
      'isOpen': true,
      'deliveryTime': '15-20 dk',
      'minOrder': '₺20',
      'deliveryFee': '₺4',
    },
    {
      'id': '8',
      'name': 'Kırtasiye Dünyası',
      'category': 'Kırtasiye',
      'rating': 4.4,
      'distance': '1.1 km',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'isOpen': true,
      'deliveryTime': '20-30 dk',
      'minOrder': '₺35',
      'deliveryFee': '₺5',
    },
    {
      'id': '9',
      'name': 'Taze Market',
      'category': 'Market',
      'rating': 4.3,
      'distance': '0.7 km',
      'image': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400',
      'isOpen': true,
      'deliveryTime': '12-18 dk',
      'minOrder': '₺45',
      'deliveryFee': '₺4',
    },
    {
      'id': '10',
      'name': 'Pizza Köşesi',
      'category': 'Restoran',
      'rating': 4.5,
      'distance': '1.0 km',
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'isOpen': true,
      'deliveryTime': '25-35 dk',
      'minOrder': '₺40',
      'deliveryFee': '₺8',
    },
    {
      'id': '11',
      'name': 'Burger House',
      'category': 'Restoran',
      'rating': 4.0,
      'distance': '0.4 km',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺35',
      'deliveryFee': '₺6',
    },
    {
      'id': '12',
      'name': 'Sushi Bar',
      'category': 'Restoran',
      'rating': 4.9,
      'distance': '1.3 km',
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
      'isOpen': true,
      'deliveryTime': '30-40 dk',
      'minOrder': '₺60',
      'deliveryFee': '₺12',
    },
    {
      'id': '13',
      'name': 'Starbucks Moda',
      'category': 'Kafe',
      'rating': 4.4,
      'distance': '0.6 km',
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
      'isOpen': true,
      'deliveryTime': '10-15 dk',
      'minOrder': '₺30',
      'deliveryFee': '₺4',
    },
    {
      'id': '14',
      'name': 'Gloria Jean\'s',
      'category': 'Kafe',
      'rating': 4.2,
      'distance': '1.4 km',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'isOpen': true,
      'deliveryTime': '12-18 dk',
      'minOrder': '₺25',
      'deliveryFee': '₺5',
    },
    {
      'id': '15',
      'name': 'Kebap Dünyası',
      'category': 'Restoran',
      'rating': 4.6,
      'distance': '0.9 km',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
      'isOpen': true,
      'deliveryTime': '20-30 dk',
      'minOrder': '₺45',
      'deliveryFee': '₺7',
    },
    {
      'id': '16',
      'name': 'Çiçek Bahçesi',
      'category': 'Çiçekçi',
      'rating': 4.7,
      'distance': '1.5 km',
      'image': 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400',
      'isOpen': true,
      'deliveryTime': '30-45 dk',
      'minOrder': '₺80',
      'deliveryFee': '₺15',
    },
    {
      'id': '17',
      'name': 'Pastane Lezzet',
      'category': 'Pastane',
      'rating': 4.8,
      'distance': '0.3 km',
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      'isOpen': true,
      'deliveryTime': '10-20 dk',
      'minOrder': '₺30',
      'deliveryFee': '₺3',
    },
    {
      'id': '18',
      'name': 'Kozmetik Güzellik',
      'category': 'Kozmetik',
      'rating': 4.5,
      'distance': '0.8 km',
      'image': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400',
      'isOpen': true,
      'deliveryTime': '20-30 dk',
      'minOrder': '₺50',
      'deliveryFee': '₺6',
    },
    {
      'id': '19',
      'name': 'Giyim Moda',
      'category': 'Giyim',
      'rating': 4.3,
      'distance': '1.0 km',
      'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
      'isOpen': true,
      'deliveryTime': '25-35 dk',
      'minOrder': '₺100',
      'deliveryFee': '₺8',
    },
    {
      'id': '20',
      'name': 'Spor Dünyası',
      'category': 'Spor',
      'rating': 4.4,
      'distance': '1.2 km',
      'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      'isOpen': true,
      'deliveryTime': '30-40 dk',
      'minOrder': '₺150',
      'deliveryFee': '₺10',
    },
    {
      'id': '21',
      'name': 'Kitap Evi',
      'category': 'Kitapçı',
      'rating': 4.6,
      'distance': '0.7 km',
      'image': 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      'isOpen': true,
      'deliveryTime': '20-30 dk',
      'minOrder': '₺40',
      'deliveryFee': '₺5',
    },
    {
      'id': '22',
      'name': 'Oyuncak Dünyası',
      'category': 'Oyuncak',
      'rating': 4.2,
      'distance': '1.3 km',
      'image': 'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?w=400',
      'isOpen': true,
      'deliveryTime': '25-35 dk',
      'minOrder': '₺60',
      'deliveryFee': '₺7',
    },
    {
      'id': '23',
      'name': 'Mobilya Ev',
      'category': 'Mobilya',
      'rating': 4.1,
      'distance': '2.0 km',
      'image': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      'isOpen': true,
      'deliveryTime': '60-90 dk',
      'minOrder': '₺500',
      'deliveryFee': '₺25',
    },
    {
      'id': '24',
      'name': 'Elektronik Merkez',
      'category': 'Teknoloji',
      'rating': 4.7,
      'distance': '0.5 km',
      'image': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400',
      'isOpen': true,
      'deliveryTime': '30-45 dk',
      'minOrder': '₺200',
      'deliveryFee': '₺12',
    },
    {
      'id': '25',
      'name': 'Gıda Market',
      'category': 'Market',
      'rating': 4.4,
      'distance': '0.4 km',
      'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺40',
      'deliveryFee': '₺4',
    },
    {
      'id': '26',
      'name': 'Tatlı Dünyası',
      'category': 'Tatlıcı',
      'rating': 4.8,
      'distance': '0.6 km',
      'image': 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺35',
      'deliveryFee': '₺5',
    },
    {
      'id': '27',
      'name': 'Kahve Dünyası',
      'category': 'Kafe',
      'rating': 4.5,
      'distance': '0.8 km',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'isOpen': true,
      'deliveryTime': '10-15 dk',
      'minOrder': '₺25',
      'deliveryFee': '₺4',
    },
    {
      'id': '28',
      'name': 'Balıkçı Restoran',
      'category': 'Restoran',
      'rating': 4.6,
      'distance': '1.1 km',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
      'isOpen': true,
      'deliveryTime': '25-35 dk',
      'minOrder': '₺70',
      'deliveryFee': '₺8',
    },
    {
      'id': '29',
      'name': 'Dondurma Dünyası',
      'category': 'Dondurma',
      'rating': 4.3,
      'distance': '0.9 km',
      'image': 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400',
      'isOpen': true,
      'deliveryTime': '15-25 dk',
      'minOrder': '₺30',
      'deliveryFee': '₺5',
    },
    {
      'id': '30',
      'name': 'Çay Bahçesi',
      'category': 'Kafe',
      'rating': 4.4,
      'distance': '1.0 km',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
      'isOpen': true,
      'deliveryTime': '12-18 dk',
      'minOrder': '₺20',
      'deliveryFee': '₺3',
    },
  ];

  final List<Map<String, dynamic>> _products = [
    // Teknoloji Dünyası ürünleri
    {
      'id': '1',
      'name': 'iPhone 15 Pro Max',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 65000.0,
      'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
    },
    {
      'id': '2',
      'name': 'Samsung Galaxy S24 Ultra',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 55000.0,
      'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
    },
    {
      'id': '3',
      'name': 'MacBook Pro M3',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 85000.0,
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    },
    {
      'id': '4',
      'name': 'AirPods Pro',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 8500.0,
      'image': 'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf0?w=400',
    },
    {
      'id': '5',
      'name': 'iPad Air',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 25000.0,
      'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
    },
    {
      'id': '6',
      'name': 'Sony WH-1000XM5',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 12000.0,
      'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
    },
    {
      'id': '7',
      'name': 'Apple Watch Series 9',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 15000.0,
      'image': 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
    },
    {
      'id': '8',
      'name': 'Dell XPS 13',
      'businessId': '1',
      'businessName': 'Teknoloji Dünyası',
      'category': 'Teknoloji',
      'price': 45000.0,
      'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
    },
    
    // Mega Market ürünleri
    {
      'id': '9',
      'name': 'Sütaş Tam Yağlı Süt 1L',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 18.0,
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
    },
    {
      'id': '10',
      'name': 'Köy Ekmeği Tam Buğday',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 12.0,
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    },
    {
      'id': '11',
      'name': 'Pınar Beyaz Peynir 500g',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 32.0,
      'image': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400',
    },
    {
      'id': '12',
      'name': 'Domates 1kg',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 15.0,
      'image': 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
    },
    {
      'id': '13',
      'name': 'Muz 1kg',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
    },
    {
      'id': '14',
      'name': 'Yumurta 30\'lu',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1569288063648-5d8453b9a9e0?w=400',
    },
    {
      'id': '15',
      'name': 'Ekmek 500g',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 8.0,
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    },
    {
      'id': '16',
      'name': 'Zeytinyağı 1L',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 120.0,
      'image': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
    },
    {
      'id': '17',
      'name': 'Elma 1kg',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 20.0,
      'image': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400',
    },
    {
      'id': '18',
      'name': 'Portakal Suyu 1L',
      'businessId': '2',
      'businessName': 'Mega Market',
      'category': 'Market',
      'price': 15.0,
      'image': 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
    },
    
    // Pizza Palace ürünleri
    {
      'id': '19',
      'name': 'Margherita Pizza',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 65.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '20',
      'name': 'Pepperoni Pizza',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 75.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '21',
      'name': 'Quattro Formaggi',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 85.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '22',
      'name': 'Hawaiian Pizza',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 70.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '23',
      'name': 'BBQ Chicken Pizza',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 80.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '24',
      'name': 'Veggie Supreme',
      'businessId': '3',
      'businessName': 'Pizza Palace',
      'category': 'Restoran',
      'price': 60.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    
    // Kafe Moda ürünleri
    {
      'id': '25',
      'name': 'Espresso',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '26',
      'name': 'Latte',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 30.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '27',
      'name': 'Cappuccino',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 28.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '28',
      'name': 'Americano',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 22.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '29',
      'name': 'Mocha',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 35.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '30',
      'name': 'Türk Kahvesi',
      'businessId': '4',
      'businessName': 'Kafe Moda',
      'category': 'Kafe',
      'price': 20.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    
    // Burger House ürünleri
    {
      'id': '31',
      'name': 'Cheeseburger Deluxe',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'id': '32',
      'name': 'Bacon Burger',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 55.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'id': '33',
      'name': 'Chicken Burger',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 40.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'id': '34',
      'name': 'Veggie Burger',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 35.0,
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    },
    {
      'id': '35',
      'name': 'Chicken Wings',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 65.0,
      'image': 'https://images.unsplash.com/photo-1567620832904-9fe0d3b2b8b8?w=400',
    },
    {
      'id': '36',
      'name': 'French Fries',
      'businessId': '5',
      'businessName': 'Burger House',
      'category': 'Restoran',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
    },
    
    // Sushi Bar ürünleri
    {
      'id': '37',
      'name': 'Sushi Set Premium',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 120.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    {
      'id': '38',
      'name': 'Salmon Nigiri',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    {
      'id': '39',
      'name': 'Tuna Roll',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 55.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    {
      'id': '40',
      'name': 'California Roll',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 50.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    {
      'id': '41',
      'name': 'Dragon Roll',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 85.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    {
      'id': '42',
      'name': 'Miso Soup',
      'businessId': '6',
      'businessName': 'Sushi Bar',
      'category': 'Restoran',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
    },
    
    // Kebap Dünyası ürünleri
    {
      'id': '43',
      'name': 'Kebap Karışık',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 85.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '44',
      'name': 'Adana Kebap',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 75.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '45',
      'name': 'Urfa Kebap',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 70.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '46',
      'name': 'İskender',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 90.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '47',
      'name': 'Lahmacun',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '48',
      'name': 'Pide Karışık',
      'businessId': '15',
      'businessName': 'Kebap Dünyası',
      'category': 'Restoran',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    
    // Taze Market ürünleri
    {
      'id': '49',
      'name': 'Organik Domates 1kg',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 18.0,
      'image': 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
    },
    {
      'id': '50',
      'name': 'Taze Süt 1L',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 20.0,
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
    },
    {
      'id': '51',
      'name': 'Köy Yumurtası 15\'li',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 35.0,
      'image': 'https://images.unsplash.com/photo-1569288063648-5d8453b9a9e0?w=400',
    },
    {
      'id': '52',
      'name': 'Taze Ekmek',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 10.0,
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    },
    {
      'id': '53',
      'name': 'Organik Elma 1kg',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 22.0,
      'image': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400',
    },
    {
      'id': '54',
      'name': 'Taze Muz 1kg',
      'businessId': '9',
      'businessName': 'Taze Market',
      'category': 'Market',
      'price': 28.0,
      'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
    },
    
    // Gıda Market ürünleri
    {
      'id': '55',
      'name': 'Sütaş Süt 1L',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 16.0,
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
    },
    {
      'id': '56',
      'name': 'Pınar Peynir 500g',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 30.0,
      'image': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400',
    },
    {
      'id': '57',
      'name': 'Domates 1kg',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 14.0,
      'image': 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
    },
    {
      'id': '58',
      'name': 'Ekmek 500g',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 7.0,
      'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    },
    {
      'id': '59',
      'name': 'Yumurta 30\'lu',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 42.0,
      'image': 'https://images.unsplash.com/photo-1569288063648-5d8453b9a9e0?w=400',
    },
    {
      'id': '60',
      'name': 'Muz 1kg',
      'businessId': '25',
      'businessName': 'Gıda Market',
      'category': 'Market',
      'price': 24.0,
      'image': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400',
    },
    
    // Starbucks Moda ürünleri
    {
      'id': '61',
      'name': 'Caramel Macchiato',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '62',
      'name': 'Vanilla Latte',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 40.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '63',
      'name': 'Espresso Shot',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 28.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '64',
      'name': 'Cappuccino',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 32.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '65',
      'name': 'Mocha',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 38.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '66',
      'name': 'Americano',
      'businessId': '13',
      'businessName': 'Starbucks Moda',
      'category': 'Kafe',
      'price': 25.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    
    // Gloria Jean's ürünleri
    {
      'id': '67',
      'name': 'Hazelnut Latte',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 35.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '68',
      'name': 'Caramel Cappuccino',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 38.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '69',
      'name': 'Espresso',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 22.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '70',
      'name': 'Mocha',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 36.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '71',
      'name': 'Americano',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 20.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '72',
      'name': 'Latte',
      'businessId': '14',
      'businessName': 'Gloria Jean\'s',
      'category': 'Kafe',
      'price': 28.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    
    // Kahve Dünyası ürünleri
    {
      'id': '73',
      'name': 'Türk Kahvesi',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 18.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '74',
      'name': 'Espresso',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 20.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '75',
      'name': 'Cappuccino',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 24.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '76',
      'name': 'Latte',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 26.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '77',
      'name': 'Mocha',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 30.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '78',
      'name': 'Americano',
      'businessId': '27',
      'businessName': 'Kahve Dünyası',
      'category': 'Kafe',
      'price': 18.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    
    // Çay Bahçesi ürünleri
    {
      'id': '79',
      'name': 'Siyah Çay',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 12.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '80',
      'name': 'Yeşil Çay',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 15.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '81',
      'name': 'Earl Grey',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 18.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '82',
      'name': 'Chamomile Çay',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 16.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    {
      'id': '83',
      'name': 'Mint Çay',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 14.0,
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
    },
    {
      'id': '84',
      'name': 'Limon Çay',
      'businessId': '30',
      'businessName': 'Çay Bahçesi',
      'category': 'Kafe',
      'price': 13.0,
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
    
    // Pizza Köşesi ürünleri
    {
      'id': '85',
      'name': 'Margherita Pizza',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 60.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '86',
      'name': 'Pepperoni Pizza',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 70.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '87',
      'name': 'Quattro Formaggi',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 80.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '88',
      'name': 'Hawaiian Pizza',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 65.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '89',
      'name': 'BBQ Chicken Pizza',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 75.0,
      'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    },
    {
      'id': '90',
      'name': 'Veggie Supreme',
      'businessId': '10',
      'businessName': 'Pizza Köşesi',
      'category': 'Restoran',
      'price': 55.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    
    // Balıkçı Restoran ürünleri
    {
      'id': '91',
      'name': 'Çipura Izgara',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 120.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '92',
      'name': 'Levrek Izgara',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 110.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '93',
      'name': 'Somon Izgara',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 130.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '94',
      'name': 'Karides Izgara',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 150.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '95',
      'name': 'Kalamar Izgara',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 140.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
    {
      'id': '96',
      'name': 'Balık Çorbası',
      'businessId': '28',
      'businessName': 'Balıkçı Restoran',
      'category': 'Restoran',
      'price': 45.0,
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    },
  ];

  final List<Map<String, dynamic>> _popularProducts = [
    {
      'id': '1',
      'name': 'iPhone 15 Pro Max',
      'business': 'Teknoloji Dünyası',
      'price': 65000.0,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
    },
    {
      'id': '2',
      'name': 'Samsung Galaxy S24 Ultra',
      'business': 'Teknoloji Dünyası',
      'price': 55000.0,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=400',
    },
    {
      'id': '3',
      'name': 'MacBook Pro M3',
      'business': 'Teknoloji Dünyası',
      'price': 85000.0,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    },
    {
      'id': '4',
      'name': 'AirPods Pro',
      'business': 'Teknoloji Dünyası',
      'price': 8500.0,
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf0?w=400',
    },
    {
      'id': '5',
      'name': 'iPad Air',
      'business': 'Teknoloji Dünyası',
      'price': 25000.0,
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
    },
  ];

  final List<Map<String, dynamic>> _discounts = [
    {
      'id': '1',
      'title': 'Süper Market\'te %20 İndirim',
      'description': 'Tüm süt ürünlerinde %20 indirim',
      'businessName': 'Süper Market Kadıköy',
      'discount': 20,
      'validUntil': '2024-01-15',
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
    },
    {
      'id': '2',
      'title': 'Lezzet Dünyası\'nda 2 Al 1 Öde',
      'description': 'Seçili menülerde 2 al 1 öde kampanyası',
      'businessName': 'Lezzet Dünyası',
      'discount': 50,
      'validUntil': '2024-01-20',
      'image': 'https://images.unsplash.com/photo-1567620832904-9fe0d3b2b8b8?w=400',
    },
    {
      'id': '3',
      'title': 'Kahve Durağı\'nda %15 İndirim',
      'description': 'Tüm kahve çeşitlerinde %15 indirim',
      'businessName': 'Kahve Durağı',
      'discount': 15,
      'validUntil': '2024-01-18',
      'image': 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=400',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize location
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      locationProvider.initializeLocation();
    });
  }

  List<Map<String, dynamic>> get _filteredBusinesses {
    if (_selectedCategory == null) return _businesses;
    return _businesses.where((business) => business['category'] == _selectedCategory).toList();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == null) return _products;
    return _products.where((product) => product['category'] == _selectedCategory).toList();
  }

  void _addToCart(Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addItem(
      productId: product['id'],
      productName: product['name'],
      businessId: product['businessId'],
      businessName: product['businessName'],
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
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Hiper Yerel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // TODO: Show notifications
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
                  // Location Header
                  _buildLocationHeader(),
                  
                  const SizedBox(height: 20),
                  
                  // Search Bar
                  _buildSearchBar(),
                  
                  const SizedBox(height: 20),
                  
                  // Categories
                  _buildCategories(),
                  
                  const SizedBox(height: 20),
                  
                  // Special Discounts Button
                  _buildSpecialDiscountsButton(),
                  
                  const SizedBox(height: 20),
                  
                  // Campaigns
                  _buildCampaigns(),
                  
                  const SizedBox(height: 20),
                  
                  // Nearby Businesses
                  _buildNearbyBusinesses(),
                  
                  const SizedBox(height: 20),
                  
                  // Popular Products
                  _buildPopularProducts(),
                  
                  const SizedBox(height: 20),
                  
                  // Community Announcements
                  _buildCommunityAnnouncements(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Teslimat Adresi',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    Text(
                      locationProvider.currentAddress ?? 'Konum alınıyor...',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  // TODO: Change location
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'İşletme, ürün veya hizmet ara...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onTap: () {
          // TODO: Navigate to search screen
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kategoriler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            if (_selectedCategory != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = null;
                  });
                },
                child: const Text('Tümünü Göster'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['name'];
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = isSelected ? null : category['name'];
                  });
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? category['color'] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category['icon'],
                        color: isSelected ? Colors.white : category['color'],
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialDiscountsButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDiscounts = !_showDiscounts;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.secondaryColor, AppTheme.accentColor],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.secondaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Colors.white, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Özel İndirimler',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Bugünün fırsatlarını kaçırma!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _showDiscounts ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaigns() {
    if (!_showDiscounts) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Özel İndirimler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _discounts.length,
            itemBuilder: (context, index) {
              final discount = _discounts[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: discount['image'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '%${discount['discount']} İndirim',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            discount['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            discount['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            discount['businessName'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
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
        ),
      ],
    );
  }

  Widget _buildNearbyBusinesses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedCategory != null ? '$_selectedCategory İşletmeleri' : 'Yakındaki İşletmeler',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to map view
              },
              child: const Text('Haritada Göster'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredBusinesses.length,
          itemBuilder: (context, index) {
            final business = _filteredBusinesses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessDetailScreen(business: business),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
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
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: business['image'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    business['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: business['isOpen'] ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    business['isOpen'] ? 'Açık' : 'Kapalı',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  business['rating'].toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.location_on, color: AppTheme.primaryColor, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  business['distance'],
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
                                const Icon(Icons.access_time, color: AppTheme.textSecondaryColor, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  business['deliveryTime'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.delivery_dining, color: AppTheme.textSecondaryColor, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  business['deliveryFee'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popüler Ürünler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all products
              },
              child: const Text('Tümünü Gör'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _popularProducts.length,
            itemBuilder: (context, index) {
              final product = _popularProducts[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(product['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['business'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '₺${product['price'].toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Text(
                                  product['rating'].toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Add to cart
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product['name']} sepete eklendi'),
                                      backgroundColor: AppTheme.primaryColor,
                                    ),
                                  );
                                },
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
                                    fontWeight: FontWeight.bold,
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityAnnouncements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Topluluk Duyuruları',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
                  const Icon(Icons.announcement, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Kadıköy Belediyesi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '2 saat önce',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Yarın Kadıköy\'de yerel üretici pazarı kurulacak. Taze ve organik ürünler için pazarı ziyaret edebilirsiniz.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}